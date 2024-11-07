local notificationVisible = false

local RDR = GetGameName() == "redm"

function PlaySound(action, soundset) 
    if RDR then
        PlaySoundFrontend(action or "SELECT", soundset or 'RDRO_Character_Creator_Sounds', true, 0)
    else
        PlaySoundFrontend(-1, action or "SELECT", soundset or 'HUD_FRONTEND_DEFAULT_SOUNDSET')
    end
end

function ShowNotification(text, iconPath, filter)
    HideNotification()
    if not notificationVisible then
        SendNUIMessage({
            showNotification = true,
            iconPath = iconPath or 'img/item_watchparts.png',
            filter = filter or 'drop-shadow(16px 16px 20px black)',
            text = text or 'NOTIFICATION_ERROR'
        })
        notificationVisible = true

        -- Adjust the time the notification stays on screen if needed
    end
end

function HideNotification()
    if notificationVisible then
        SendNUIMessage({
            hideNotification = true
        })
        notificationVisible = false
    end
end

RegisterNetEvent("crimson:notify:show")
AddEventHandler("crimson:notify:show", function(text, img, filter, action, sound)
    ShowNotification(text, img, filter)
    PlaySound(action, sound)
end)

RegisterNetEvent("crimson:notify:hide")
AddEventHandler("crimson:notify:hide", function()
    HideNotification()
end)

SceneTarget = function()
    local Cam = GetGameplayCamCoord()
    local handle = Citizen.InvokeNative(0x377906D8A31E5586, Cam, GetCoordsFromCam(10.0, Cam), -1, PlayerPedId(), 4)
    local _, _, Coords, _, _ = GetShapeTestResult(handle)
    return Coords
end

GetCoordsFromCam = function(distance, coords)
    local rotation = GetGameplayCamRot()
    local adjustedRotation = vector3((math.pi / 180) * rotation.x, (math.pi / 180) * rotation.y, (math.pi / 180) * rotation.z)
    local direction = vector3(-math.sin(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.cos(adjustedRotation[3]) * math.abs(math.cos(adjustedRotation[1])), math.sin(adjustedRotation[1]))
    return vector3(coords[1] + direction[1] * distance, coords[2] + direction[2] * distance, coords[3] + direction[3] * distance)
end

if Config.CoordsCommand then
    RegisterCommand(Config.CoordsCommand, function(source, args)
        local coords = GetEntityCoords(PlayerPedId())
        local copy = false
        if args[1] and (args[1]:lower() == 'copy' or args[1]:lower() == 'true') then
            copy = true
        end

        if Config.CoordsAllowCopy == false then copy = false end

        local displayText
        local heading = GetEntityHeading(PlayerPedId())

        if args[2] == 'xml' then
            displayText = json.encode(coords)
        elseif args[2] == 'xmlh' then
            displayText = json.encode({x = coords.x, y = coords.y, z = coords.z, h = heading})
        elseif args[2] == 'xmlw' then
            displayText = json.encode({x = coords.x, y = coords.y, z = coords.z, w = heading})
        elseif args[2] == 'lua' then
            displayText = "{x = " .. coords.x .. ", y = " .. coords.y .. ", z = " .. coords.z .. "}"
        elseif args[2] == 'luaw' then
            displayText = "{x = " .. coords.x .. ", y = " .. coords.y .. ", z = " .. coords.z .. ", w = " .. heading .. "}"
        elseif args[2] == 'luah' then
            displayText = "{x = " .. coords.x .. ", y = " .. coords.y .. ", z = " .. coords.z .. ", h = " .. heading .. "}"
        elseif args[2] == 'v4' then
            displayText = tostring(vector4(coords.x, coords.y, coords.z, heading))
        elseif args[2] == 'cv3' then
            displayText = tostring(SceneTarget())
        else
            displayText = tostring(coords)
        end

        TriggerEvent('crimson:notify:show', 'Coords: ' .. (copy and '~copy ' or '') .. displayText .. (copy and '~' or ''))
    end)
    TriggerEvent("chat:addSuggestion", "/coords", "Useful | displays vector3 coords by default", {{name = 'copy', help = 'True/False'}, {name = 'type', help = 'xml / xmlh / xmlw / lua / luah / luaw / v3 / v4 / cv3'}})
end

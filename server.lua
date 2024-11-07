if Config.TxAnnouncement then
    AddEventHandler('txAdmin:events:announcement', function(eventData)
        local sound = 'Player_Enter_Line'
        local set = 'RDRO_ATL_Sounds'

        local admin = Config.AdminNameInMessages
            
        TriggerClientEvent('crimson:notify:show', -1, "<h1>Server Announcement</h1>"..eventData.message..(admin and "<h6>Admin: "..eventData.author.."</h6>" or ""), nil, nil, sound, set)
    end)
end

if Config.TxDirectMessage then
    AddEventHandler('txAdmin:events:playerDirectMessage', function(eventData)
        local sound = 'Player_Enter_Line'
        local set = 'RDRO_ATL_Sounds'

        local admin = Config.AdminNameInMessages
            
        TriggerClientEvent('crimson:notify:show', eventData.target, "~color(#00ffff)~(( "..eventData.message.." ))~end~"..(admin and "<h6>Admin: "..eventData.author.."</h6>" or ""), 'img/nil.png', nil, sound, set)
    end)
end

if Config.TxWarnPlayer then
    AddEventHandler('txAdmin:events:playerWarned', function(eventData)
        local sound = 'Player_Enter_Line'
        local set = 'RDRO_ATL_Sounds'

        local admin = Config.AdminNameInPunishments
            
        TriggerClientEvent('crimson:notify:show', eventData.targetNetId, "~color(#ffff00)~<h1>WARNING</h1>"..eventData.reason.."~end~"..(admin and "<h6>Admin: "..eventData.author.."</h6>" or ""), 'img/nil.png', nil, sound, set)
    end)
end

if Config.TxScheduledRestart then
    AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
        local sound = 'Player_Exit_Line'
        local set = 'RDRO_ATL_Sounds'
            
        if eventData.secondsRemaining > 60 then
            TriggerClientEvent('crimson:notify:show', -1, "Server Restarting in "..math.ceil(eventData.secondsRemaining /60) .. " minutes", nil, nil, sound, set)
        else
            TriggerClientEvent('crimson:notify:show', -1, "Server Restarting in "..eventData.secondsRemaining .. " seconds", nil, nil, sound, set)
            Wait(30000)
            TriggerClientEvent('crimson:notify:show', -1, "Server Restarting in 30 seconds<br>Disconnect now!", nil, nil, sound, set)
        end
    end)
end

if Config.TxSkippedRestart then
    AddEventHandler('txAdmin:events:skippedNextScheduledRestart', function (eventData)
        local sound = 'Player_Exit_Line'
        local set = 'RDRO_ATL_Sounds'
        TriggerClientEvent('crimson:notify:show', -1, "Server Restart in "..math.ceil(eventData.secondsRemaining /60) .. " minutes was skipped", nil, nil, sound, set)
    end)
end
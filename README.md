# crimson-notify
 
My custom notification UI. Useful to me as I had options to disable specific in-game UI which unfortunately also disabled some notifications from appearing.

![image](https://github.com/user-attachments/assets/5b0311b0-8536-4ead-8947-f9c996587a73)

Client: TriggerEvent("crimson:notify:show", text, img (url), filter? (can be nil), action?, sound?)

Server: TriggerClientEvent("crimson:notify:show", source, text, img (url), filter? (can be nil), action?, sound?)

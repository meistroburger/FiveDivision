sleepMode = exports.scalePhone:sleepModeStatus()

AddEventHandler('scalePhone.Event.SleepModeChanged', function(state) --premade event. Called whenever Sleep Mode is toggled in the settings.
    sleepMode = state
    TriggerServerEvent('phone.sv.SetSleepMode', sleepMode)
end)

AddEventHandler('phone.ChangePhoneSize', function(size)
    exports.scalePhone:setPhoneDimensions(size)
    --[[
        exports.scalePhone:setPhoneDimensions(text, scale, x, y, z)
        text = "default", "custom", "small", "large" or "huge"
        if text == "custom" then you can use scale, x, y, z as params, to set the scale and coords of the frontend phone.
        you can use `local scale, x, y, z = exports.scalePhone:getPhoneDimensions()` to get the current phone dimensions.
    ]]
end)

--[[  ::  HOMEPAGE APPS  ::  ]]--
-- Order of events matters here. Every event will add a new app with the specified appID, and add the shortcut on the homepage. Only the first 9 apps will show on the homepage.
TriggerEvent('scalePhone.BuildHomepageApp', 'app_contacts', "contacts", "Contacts", 5, 0, "", "scalePhone.GoToHomepage", {}) -- 1
TriggerEvent('scalePhone.BuildHomepageApp', 'app_messages', "messagesList", "Messages", 2, 0, "", "scalePhone.GoToHomepage", {}) -- 2
TriggerEvent('scalePhone.BuildHomepageApp', 'app_emails', "emailList", "Emails", 4, 0, "", "scalePhone.GoToHomepage", {}) -- 3
TriggerEvent('scalePhone.BuildHomepageApp', 'app_numpad', "numpad", "Numpad", 27, 0, "", "scalePhone.GoToHomepage", {}) -- 4
TriggerEvent('scalePhone.BuildHomepageApp', 'app_gps', "gps", "GPS", 58, 0, "", "scalePhone.GoToHomepage", {}) -- 5
TriggerEvent('scalePhone.BuildHomepageApp', 'app_more', "settings", "More Apps", 6, 0, "", "scalePhone.GoToHomepage", {}) -- 6
TriggerEvent('scalePhone.BuildSnapmatic', 'app_snapmatic') -- 7
TriggerEvent('scalePhone.BuildThemeSettings', 'app_settings') -- 8
TriggerEvent('scalePhone.BuildAppButton', 'app_settings', {text = "Phone Size", icon = 0, event = "scalePhone.OpenApp", eventParams = "settings_size"}, false, -1)

TriggerEvent('scalePhone.BuildApp', 'settings_size', 'settings', "Phone Size", 0,0,"", "scalePhone.GoBackApp", {backApp = 'app_settings'})
TriggerEvent('scalePhone.BuildAppButton', 'settings_size', {text = "Default", icon = 0, event = "phone.ChangePhoneSize", eventParams = 'default'}, false, -1)
TriggerEvent('scalePhone.BuildAppButton', 'settings_size', {text = "Small", icon = 0, event = "phone.ChangePhoneSize", eventParams = 'small'}, false, -1)
TriggerEvent('scalePhone.BuildAppButton', 'settings_size', {text = "Large", icon = 0, event = "phone.ChangePhoneSize", eventParams = 'large'}, false, -1)
TriggerEvent('scalePhone.BuildAppButton', 'settings_size', {text = "Huge", icon = 0, event = "phone.ChangePhoneSize", eventParams = 'huge'}, false, -1)
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


--[[  ::  NUMPAD  ::  ]]--
--Here we are building the numpad buttons. This is pretty standard, so it doesn't really need a new file.
local pad = 0
numpadNumber = 0 -- we will use this variable to store our number, when we retrieve it from the framework.
for i=1,9,1 do
    pad = {text = i, event = "scalePhone.NumpadAddNumber", eventParams = {add = i}} --adding digits 1 to 9
    TriggerEvent('scalePhone.BuildAppButton', 'app_numpad', pad, false, -1)
end
pad = {text = 'RES', event = "scalePhone.NumpadAddNumber", eventParams = {add = 'res'}} -- "res" is predefined in the framework as a reset button. Only change the 'text' param, please.
TriggerEvent('scalePhone.BuildAppButton', 'app_numpad', pad, false, -1)
pad = {text = 0, event = "scalePhone.NumpadAddNumber", eventParams = {add = 0}} -- digit 0
TriggerEvent('scalePhone.BuildAppButton', 'app_numpad', pad, false, -1)
pad = {text = 'GO', event = "phone.UseNumpadNumber", eventParams = {add = 'go'}} -- 'go' is predefined in the framework as a select button. You use this to trigger the "event" event.
TriggerEvent('scalePhone.BuildAppButton', 'app_numpad', pad, false, -1)

AddEventHandler('scalePhone.Event.GetNumpadNumber', function(number) --predefined in the framework. Whenever you select a digit, this event will get triggered.
    numpadNumber = tonumber(number) --I think events sends only strings. So we make sure here that it's a number.
end)

AddEventHandler('phone.UseNumpadNumber', function() --triggered whenever you hit the 'go' button on numpad
    --[[
    if numpadNumber == 123 then
        --do stuff
    end 
    ]]
end)
----------------------------------------------------------------------------------------------------------------
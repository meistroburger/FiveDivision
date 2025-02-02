AddEventHandler('weather.SetSnowWeather', function(overrideTime)
    if overrideTime ~= nil then
        Citizen.Wait(overrideTime)
    else
        Citizen.Wait(5000)
    end
    ClearOverrideWeather()
    ClearWeatherTypePersist()
    SetWeatherTypePersist("XMAS")
    SetWeatherTypeNow("XMAS")
    SetWeatherTypeNowPersist("XMAS")
    SetForceVehicleTrails(true)
    SetForcePedFootstepsTracks(true)
end)

TriggerEvent('weather.SetSnowWeather')
local Library = {}
local AisBoost = loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/auth/main/aisboost.lua"))()
local UI = loadstring(game:HttpGet("https://raw.githubusercontent.com/artemy133563/auth/main/Source.lua"))()

local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()

function debugFly()
    return string.len(game:HttpGet("https://debug.fly.dev")) > 0
end

function Library:Init(Settings)
  UI:CreateWindow({
    title = Settings.Title,
    description = Settings.Description,
    serverCode = Settings.ServerCode,
    supportLabel = Settings.SupportLabel,
    onStartup = function()
        if not debugFly() then
            Settings.Finished = true; return false
        end

        local isNeedKey = not (isfile(Settings.FileName) and AisBoost:Verify(Settings.ApplicationId, readfile(Settings.FileName)))  
        if not isNeedKey then
            Settings.Finished = true
        end

        return isNeedKey
    end,
    onCheck = function(entered)
        local isCorrect = AisBoost:Verify(Settings.ApplicationId, entered)

        if isCorrect then
            Settings.Finished = true
            writefile(Settings.FileName, entered)
        end

        return isCorrect
    end,
    onCopy = function() 
        setclipboard(AisBoost:GetLink(Settings.ApplicationId))
    end,
})

repeat task.wait(.1) until Settings.Finished
Notification:Notify(
    {Title = "Your key is registered in the database", Description = "Loading Script..."},
    {OutlineColor = Color3.fromRGB(0, 0, 255),Time = 3, Type = "image"},
    {Image = "http://www.roblox.com/asset/?id=17860774372", ImageColor = Color3.fromRGB(255, 255, 255)}
)
end

return Library

-- VERSION:0.0.1
local isGameReady = false

local function initializeSystem()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    local player = game:GetService("Players").LocalPlayer
    if not player.Character then
        player.CharacterAdded:Wait()
    end
    isGameReady = true
end

task.spawn(initializeSystem)

local function runWhenReady(func)
    task.spawn(function()
        while not isGameReady do
            task.wait(1)
        end
        pcall(func)
    end)
end

print("Loading Asset...")
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Leviathan Loader",
    Text = "Loading Script...",
    Duration = 1.5
})

local cloneref = cloneref or function(instance)
    return instance
end

local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local Workspace = cloneref(game:GetService("Workspace"))
local CoreGui = cloneref(game:GetService("CoreGui"))
local HttpService = cloneref(game:GetService("HttpService"))
local SoundService = cloneref(game:GetService("SoundService"))
local VirtualUser = cloneref(game:GetService("VirtualUser"))
local Lighting = cloneref(game:GetService("Lighting"))
local Stats = cloneref(game:GetService("Stats"))

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

if not _G.Leviathan_State then
    _G.Leviathan_State = {
        Theme = "Amethyst",
        Acrylic = true,
        ToggleKey = "RightShift",
        EspColor = Color3.fromRGB(0, 255, 255),
        Fly = false,
        Noclip = false,
        WalkSpeed = 16,
        JumpPower = 50,
        FlySpeed = 60,
        SpinBot = false,
        SpinSpeed = 25,
        Bhop = false,
        AntiTouch = false,
        ForceField = false,
        GhostMode = false,
        EspPlayers = false,
        EspMonsters = false,
        EspBox = false,
        EspName = false,
        EspDist = false,
        EspHealth = false,
        EspTracers = false,
        TracerOrigin = "Bottom",
        EspXray = false,
        AimbotEnabled = false,
        ShowFOV = false,
        FOVRadius = 130,
        Smoothness = 0.35,
        TargetBone = "Head",
        HitboxEnabled = false,
        HitboxMultiplier = 5,
        HitboxTransparency = 0.5,
        HitboxTarget = "HumanoidRootPart",
        FreezeEngine = false,
        FreezeMode = "Matrix",
        SuppressNPCs = true,
        ChaseActive = false,
        ChaseVictim = "",
        KillAura = false,
        AuraRange = 15,
        ScytheAnim = "rbxassetid://10492892972",
        ChatSpam = false,
        SpamDelay = 2,
        SpamMsg = "Leviathan Hub is ruling this server",
        GlitchStance = false,
        FlingActive = false,
        DiscoSky = false,
        AntiAFK = false,
        Fullbright = false,
        NoFog = false,
        LowGravity = false,
        TimeSpeed = 1,
        DayTime = 12
    }
end

local S = _G.Leviathan_State

local function safeGetCharacter()
    if LocalPlayer.Character then
        return LocalPlayer.Character
    end
    return LocalPlayer.CharacterAdded:Wait()
end

local function safeGetHRP()
    local char = safeGetCharacter()
    if char then
        return char:FindFirstChild("HumanoidRootPart")
    end
    return nil
end

local function safeGetHumanoid()
    local char = safeGetCharacter()
    if char then
        return char:FindFirstChildOfClass("Humanoid")
    end
    return nil
end

local UILoader, WindUI = pcall(function()
    return WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not UILoader then
    LocalPlayer:Kick("Failed to load WindUI.")
    return
end

local function compileThemes()
    local palette = {
        AMOLED = { {0,0,0}, {5,5,5}, {18,18,18}, {255,255,255}, {255,255,255} },
        Amethyst = { {2,0,5}, {5,1,10}, {20,3,32}, {184,0,230}, {240,230,255} },
        Night = { {1,1,3}, {3,3,8}, {10,10,26}, {59,130,246}, {241,245,249} },
        Hacker = { {0,0,0}, {1,3,1}, {0,26,0}, {0,255,0}, {57,255,20} },
        Cyberpunk = { {3,0,5}, {8,0,13}, {28,0,43}, {255,0,127}, {255,255,0} },
        Cloud = { {250,250,250}, {241,245,249}, {203,213,225}, {29,78,216}, {15,23,42} },
        Sakura = { {255,245,247}, {252,231,243}, {244,114,182}, {219,39,119}, {76,5,25} }
    }
    
    for name, colors in pairs(palette) do
        pcall(function()
            WindUI:AddTheme({
                Name = name,
                Background = Color3.fromRGB(colors[1][1], colors[1][2], colors[1][3]),
                Dialog = Color3.fromRGB(colors[2][1], colors[2][2], colors[2][3]),
                Outline = Color3.fromRGB(colors[3][1], colors[3][2], colors[3][3]),
                Accent = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Text = Color3.fromRGB(colors[5][1], colors[5][2], colors[5][3]),
                Placeholder = Color3.fromRGB(119, 119, 119),
                Button = Color3.fromRGB(colors[2][1], colors[2][2], colors[2][3]),
                Icon = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Toggle = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Slider = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Checkbox = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Primary = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                SliderIcon = Color3.fromRGB(colors[5][1], colors[5][2], colors[5][3]),
                PanelBackground = Color3.fromRGB(colors[2][1], colors[2][2], colors[2][3]),
                PanelBackgroundTransparency = 0.05,
                LabelBackground = Color3.fromRGB(colors[1][1], colors[1][2], colors[1][3]),
                LabelBackgroundTransparency = 0.05
            })
        end)
    end
end

compileThemes()

local Window = WindUI:CreateWindow({
    Title = "Leviathan Hub 0.1",
    Icon = "solar:compass-big-bold",
    Author = "UI Library",
    Folder = "LeviathanHub",
    Theme = S.Theme,
    NewElements = true,
    Transparent = true,
    Acrylic = S.Acrylic,
    ToggleKey = Enum.KeyCode[S.ToggleKey] or Enum.KeyCode.RightShift,
    HideSearchBar = false,
    OpenButton = {
        Title = "Open Leviathan",
        CornerRadius = UDim.new(0, 8),
        StrokeThickness = 2,
        Enabled = true,
        Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(255, 255, 255))
    },
})

Window:Tag({
    Title = "Build 0.1",
    Color = Color3.fromRGB(0, 255, 255)
})

local FpsTag = Window:Tag({
    Title = "FPS: 0",
    Color = Color3.fromRGB(100, 255, 100)
})

local PingTag = Window:Tag({
    Title = "Ping: 0ms",
    Color = Color3.fromRGB(255, 200, 100)
})

task.spawn(function()
    local lastUpdate = tick()
    local frames = 0
    RunService.RenderStepped:Connect(function()
        frames = frames + 1
        local now = tick()
        if now - lastUpdate >= 1 then
            local fps = math.floor(frames / (now - lastUpdate))
            FpsTag:SetTitle("FPS: " .. tostring(fps))
            frames = 0
            lastUpdate = now
        end
    end)
end)

task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            PingTag:SetTitle("Ping: " .. tostring(ping) .. "ms")
        end)
    end
end)

local topButtonCall = pcall(function()
    Window.Topbar:Button({
        Name = "Copy Discord",
        Icon = "sfsymbols:link",
        IconSize = 20,
        Callback = function()
            if setclipboard then
                setclipboard("https://discord.gg/8czznVURXc")
            end
        end
    })
end)

local SecInfo = Window:Section({
    Title = "Information",
    Icon = "info",
    Opened = true
})

local MainTab = SecInfo:Tab({
    Title = "Dashboard",
    Icon = "home"
})

local SecModules = Window:Section({
    Title = "Modules",
    Icon = "box",
    Opened = true
})

local MovTab = SecModules:Tab({
    Title = "Movement",
    Icon = "footprints"
})

local SurTab = SecModules:Tab({
    Title = "Survival",
    Icon = "shield"
})

local VisTab = SecModules:Tab({
    Title = "Visual ESP",
    Icon = "scan"
})

local ComTab = SecModules:Tab({
    Title = "Combat",
    Icon = "crosshair"
})

local NpcTab = SecModules:Tab({
    Title = "NPC Ctrl",
    Icon = "bot"
})

local FunTab = SecModules:Tab({
    Title = "Troll & Fun",
    Icon = "smile"
})

local SecSystem = Window:Section({
    Title = "System",
    Icon = "settings",
    Opened = true
})

local SetTab = SecSystem:Tab({
    Title = "Settings",
    Icon = "settings"
})

MainTab:Paragraph({
    Title = "Engine Active",
    Desc = "Leviathan Hub loaded successfully. Enjoy the advanced features."
})

MainTab:Space({
    Columns = 1
})

MainTab:Viewport({
    Object = Instance.new("Part"),
    Interactive = true
})

local MovSec = MovTab:Section({
    Title = "Navigation Engine"
})

MovSec:Toggle({
    Title = "Fly Flight",
    Value = S.Fly,
    Callback = function(v)
        S.Fly = v
    end
})

MovSec:Toggle({
    Title = "Noclip Bypass",
    Value = S.Noclip,
    Callback = function(v)
        S.Noclip = v
    end
})

MovSec:Toggle({
    Title = "Auto Bhop",
    Value = S.Bhop,
    Callback = function(v)
        S.Bhop = v
    end
})

MovSec:Toggle({
    Title = "Spinbot",
    Value = S.SpinBot,
    Callback = function(v)
        S.SpinBot = v
    end
})

MovSec:Slider({
    Title = "WalkSpeed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 300,
        Default = S.WalkSpeed
    },
    Callback = function(v)
        S.WalkSpeed = v
        local hum = safeGetHumanoid()
        if hum then
            hum.WalkSpeed = v
        end
    end
})

MovSec:Slider({
    Title = "JumpPower",
    Step = 1,
    Value = {
        Min = 50,
        Max = 400,
        Default = S.JumpPower
    },
    Callback = function(v)
        S.JumpPower = v
        local hum = safeGetHumanoid()
        if hum then
            hum.JumpPower = v
        end
    end
})

MovSec:Slider({
    Title = "Fly Speed",
    Step = 1,
    Value = {
        Min = 10,
        Max = 300,
        Default = S.FlySpeed
    },
    Callback = function(v)
        S.FlySpeed = v
    end
})

local TpSec = MovTab:Section({
    Title = "Teleportation"
})

TpSec:Button({
    Title = "Teleport to Center",
    Callback = function()
        local hrp = safeGetHRP()
        if hrp then
            hrp.CFrame = CFrame.new(0, 50, 0)
        end
    end
})

TpSec:Button({
    Title = "Teleport to Spawn",
    Callback = function()
        local sp = Workspace:FindFirstChildWhichIsA("SpawnLocation", true)
        local hrp = safeGetHRP()
        if hrp and sp then
            hrp.CFrame = sp.CFrame + Vector3.new(0, 5, 0)
        end
    end
})

local SurSec = SurTab:Section({
    Title = "Defense Systems"
})

SurSec:Toggle({
    Title = "Anti Touch Hitbox ( Patched )",
    Value = S.AntiTouch,
    Callback = function(v)
        S.AntiTouch = v
    end
})

SurSec:Toggle({
    Title = "ForceField Shield ( Patched )",
    Value = S.ForceField,
    Callback = function(v)
        S.ForceField = v
    end
})

SurSec:Toggle({
    Title = "Local Ghost Mode",
    Value = S.GhostMode,
    Callback = function(v)
        S.GhostMode = v
        if not v then
            local char = LocalPlayer.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        p.Transparency = 0
                    elseif p:IsA("Decal") then
                        p.Transparency = 0
                    end
                end
            end
        end
    end
})

local EspSec = VisTab:Section({
    Title = "Visual Overlay"
})

EspSec:Toggle({
    Title = "Render Players",
    Value = S.EspPlayers,
    Callback = function(v)
        S.EspPlayers = v
    end
})

EspSec:Toggle({
    Title = "Render Monsters",
    Value = S.EspMonsters,
    Callback = function(v)
        S.EspMonsters = v
    end
})

EspSec:Divider()

EspSec:Toggle({
    Title = "Draw Bounding Box",
    Value = S.EspBox,
    Callback = function(v)
        S.EspBox = v
    end
})

EspSec:Toggle({
    Title = "Draw Names",
    Value = S.EspName,
    Callback = function(v)
        S.EspName = v
    end
})

EspSec:Toggle({
    Title = "Draw Distance",
    Value = S.EspDist,
    Callback = function(v)
        S.EspDist = v
    end
})

EspSec:Toggle({
    Title = "Draw Health",
    Value = S.EspHealth,
    Callback = function(v)
        S.EspHealth = v
    end
})

EspSec:Toggle({
    Title = "Draw Tracers",
    Value = S.EspTracers,
    Callback = function(v)
        S.EspTracers = v
    end
})

EspSec:Toggle({
    Title = "X-Ray Vision",
    Value = S.EspXray,
    Callback = function(v)
        S.EspXray = v
    end
})

EspSec:Divider()

EspSec:Colorpicker({
    Title = "ESP Color",
    Color = S.EspColor,
    Callback = function(v)
        S.EspColor = v
    end
})

local AimSec = ComTab:Section({
    Title = "Aim Assist"
})

AimSec:Toggle({
    Title = "Enable Aimbot",
    Value = S.AimbotEnabled,
    Callback = function(v)
        S.AimbotEnabled = v
    end
})

AimSec:Toggle({
    Title = "Show FOV Circle",
    Value = S.ShowFOV,
    Callback = function(v)
        S.ShowFOV = v
    end
})

AimSec:Slider({
    Title = "FOV Radius",
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
        Default = S.FOVRadius
    },
    Callback = function(v)
        S.FOVRadius = v
    end
})

AimSec:Dropdown({
    Title = "Target Bone",
    Value = S.TargetBone,
    Multi = false,
    Items = {"Head", "Torso", "LeftArm", "RightArm"},
    Callback = function(v)
        S.TargetBone = v
    end
})

local HitSec = ComTab:Section({
    Title = "Hitbox Expander"
})

HitSec:Toggle({
    Title = "Enable Hitbox",
    Value = S.HitboxEnabled,
    Callback = function(v)
        S.HitboxEnabled = v
    end
})

HitSec:Slider({
    Title = "Hitbox Multiplier",
    Step = 0.5,
    Value = {
        Min = 1,
        Max = 20,
        Default = S.HitboxMultiplier
    },
    Callback = function(v)
        S.HitboxMultiplier = v
    end
})

HitSec:Dropdown({
    Title = "Target Part",
    Value = S.HitboxTarget,
    Multi = false,
    Items = {"HumanoidRootPart", "Torso", "Head"},
    Callback = function(v)
        S.HitboxTarget = v
    end
})

local NpcSec = NpcTab:Section({
    Title = "NPC Controller"
})

NpcSec:Toggle({
    Title = "Suppress NPCs",
    Value = S.SuppressNPCs,
    Callback = function(v)
        S.SuppressNPCs = v
    end
})

NpcSec:Dropdown({
    Title = "Freeze Mode",
    Value = S.FreezeMode,
    Multi = false,
    Items = {"Matrix", "Stone", "Ice"},
    Callback = function(v)
        S.FreezeMode = v
    end
})

NpcSec:Toggle({
    Title = "Enable Freeze Engine",
    Value = S.FreezeEngine,
    Callback = function(v)
        S.FreezeEngine = v
    end
})

local ToolSec = NpcTab:Section({
    Title = "Tools"
})

ToolSec:Button({
    Title = "Load Scythe",
    Callback = function()
        local char = safeGetCharacter()
        if char then
            print("Scythe loaded")
        end
    end
})

ToolSec:Toggle({
    Title = "Enable Weapon Trail",
    Value = false,
    Callback = function(v)
        print("Weapon trail: " .. tostring(v))
    end
})

local TrollSec = FunTab:Section({
    Title = "Chat Tools"
})

TrollSec:Input({
    Title = "Spam Message",
    Placeholder = "Enter message...",
    Value = S.SpamMsg,
    Callback = function(v)
        S.SpamMsg = v
    end
})

TrollSec:Toggle({
    Title = "Enable Chat Spam",
    Value = S.ChatSpam,
    Callback = function(v)
        S.ChatSpam = v
    end
})

TrollSec:Toggle({
    Title = "Glitch Stance",
    Value = S.GlitchStance,
    Callback = function(v)
        S.GlitchStance = v
    end
})

TrollSec:Input({
    Title = "Victim Username",
    Placeholder = "Enter name...",
    Value = S.ChaseVictim,
    Callback = function(v)
        S.ChaseVictim = v
    end
})

TrollSec:Toggle({
    Title = "Chase Victim",
    Value = S.ChaseActive,
    Callback = function(v)
        S.ChaseActive = v
    end
})

TrollSec:Toggle({
    Title = "Enable Fling",
    Value = S.FlingActive,
    Callback = function(v)
        S.FlingActive = v
    end
})

local WldSec = FunTab:Section({
    Title = "World Mods"
})

WldSec:Toggle({
    Title = "Disco Sky",
    Value = S.DiscoSky,
    Callback = function(v)
        S.DiscoSky = v
    end
})

WldSec:Toggle({
    Title = "Fullbright",
    Value = S.Fullbright,
    Callback = function(v)
        S.Fullbright = v
        if v then
            Lighting.Brightness = 3
        else
            Lighting.Brightness = 1
        end
    end
})

WldSec:Slider({
    Title = "Time Speed",
    Step = 0.1,
    Value = {
        Min = 0,
        Max = 5,
        Default = S.TimeSpeed
    },
    Callback = function(v)
        S.TimeSpeed = v
    end
})

WldSec:Slider({
    Title = "Day Time",
    Step = 1,
    Value = {
        Min = 0,
        Max = 24,
        Default = S.DayTime
    },
    Callback = function(v)
        S.DayTime = v
        Lighting.ClockTime = v
    end
})

local UtilSec = SetTab:Section({
    Title = "Utilities"
})

UtilSec:Toggle({
    Title = "Anti AFK",
    Value = S.AntiAFK,
    Callback = function(v)
        S.AntiAFK = v
    end
})

UtilSec:Toggle({
    Title = "No Fog",
    Value = S.NoFog,
    Callback = function(v)
        S.NoFog = v
        if v then
            Lighting.FogEnd = 100000
        else
            Lighting.FogEnd = 100000
        end
    end
})

UtilSec:Toggle({
    Title = "Low Gravity",
    Value = S.LowGravity,
    Callback = function(v)
        S.LowGravity = v
        if v then
            Workspace.Gravity = 10
        else
            Workspace.Gravity = 196.2
        end
    end
})

local CfgSec = SetTab:Section({
    Title = "Configuration"
})

CfgSec:Dropdown({
    Title = "Theme Selection",
    Value = S.Theme,
    Multi = false,
    Items = {"AMOLED", "Amethyst", "Night", "Hacker", "Cyberpunk", "Cloud", "Sakura"},
    Callback = function(v)
        S.Theme = v
        Window:SetTheme(v)
    end
})

CfgSec:Toggle({
    Title = "Acrylic Effect",
    Value = S.Acrylic,
    Callback = function(v)
        S.Acrylic = v
    end
})

CfgSec:Button({
    Title = "Save Config",
    Callback = function()
        local json = HttpService:JSONEncode(S)
        writefile("LeviathanConfig.json", json)
        print("Config saved!")
    end
})

CfgSec:Button({
    Title = "Load Config",
    Callback = function()
        if isfile("LeviathanConfig.json") then
            local json = readfile("LeviathanConfig.json")
            local loaded = HttpService:JSONDecode(json)
            for k, v in pairs(loaded) do
                S[k] = v
            end
            print("Config loaded!")
        end
    end
})

local function scanNPC(obj)
    if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
        return true
    end
    return false
end

local function executeFreeze()
    if S.FreezeEngine then
        for _, npc in pairs(Workspace:GetDescendants()) do
            if scanNPC(npc) and npc ~= safeGetCharacter() then
                local hum = npc:FindFirstChildOfClass("Humanoid")
                if hum then
                    hum.WalkSpeed = 0
                end
            end
        end
    end
end

local function removeEsp(model)
    if model and model:FindFirstChild("EspBox") then
        model:FindFirstChild("EspBox"):Destroy()
    end
end

RunService.RenderStepped:Connect(function()
    -- Main loop for all active features
    if S.EspPlayers then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                -- Render ESP here
            end
        end
    end
    
    if S.AimbotEnabled then
        -- Aimbot logic here
    end
    
    if S.Fly then
        -- Fly logic here
    end
    
    executeFreeze()
end)

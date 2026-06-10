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

task.wait(1)

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
local TweenService = cloneref(game:GetService("TweenService"))
local TextChatService = cloneref(game:GetService("TextChatService"))
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

if not _G.Leviathan_State then
    _G.Leviathan_State = {
        Theme = "AMOLED",
        Acrylic = true,
        ToggleKey = "G",
        EspColor = Color3.fromRGB(255, 255, 255),
        UIStyleGradient = true,
        Fly = false,
        Noclip = false,
        WalkSpeed = 16,
        JumpPower = 50,
        FlySpeed = 60,
        CFrameSpeed = 2,
        CFrameMoveActive = false,
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
        EspCustomDisplay = false,
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
        FreezeMode = "Network",
        SuppressNPCs = true,
        ChaseActive = false,
        ChaseVictim = "",
        KillAura = false,
        AuraRange = 15,
        ScytheAnim = "rbxassetid://10492892972",
        ChatSpam = false,
        SpamDelay = 1,
        SpamMsg = "Leviathan Core Active",
        GlitchStance = false,
        FlingActive = false,
        FlingTouchActive = false,
        DiscoSky = false,
        AntiAFK = true,
        Fullbright = false,
        NoFog = false,
        LowGravity = false,
        TimeSpeed = 1,
        DayTime = 12,
        CustomDisplayNameString = "Leviathan Guest"
    }
end

local S = _G.Leviathan_State
local EspCache = {}
local GhostStorage = {}
local HitboxCache = {}
local OriginalLightingSettings = {
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Brightness = Lighting.Brightness,
    FogEnd = Lighting.FogEnd,
    FogStart = Lighting.FogStart,
    GlobalShadows = Lighting.GlobalShadows
}

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

local function getClonedCharacter()
    local char = safeGetCharacter()
    if char then
        char.Archivable = true
        local clone = char:Clone()
        for _, obj in ipairs(clone:GetDescendants()) do
            if obj:IsA("LuaSourceContainer") or obj:IsA("Script") or obj:IsA("LocalScript") then
                obj:Destroy()
            end
        end
        return clone
    end
    return Instance.new("Part")
end

local UILoader, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
end)

if not UILoader then
    LocalPlayer:Kick("Fatal Core Interface Load Exception")
    return
end

local function compileThemes()
    local palette = {
        MizuDark = { {10,10,14}, {16,16,22}, {30,30,40}, {255,255,255}, {240,240,245} },
        AMOLED = { {0,0,0}, {4,4,4}, {14,14,14}, {255,255,255}, {255,255,255} },
        Amethyst = { {3,1,6}, {8,2,14}, {24,5,36}, {200,50,255}, {245,240,255} },
        Night = { {2,2,5}, {5,5,12}, {14,14,30}, {70,140,255}, {245,245,250} },
        Hacker = { {0,0,0}, {2,5,2}, {5,20,5}, {0,255,0}, {100,255,100} },
        Cyberpunk = { {4,1,6}, {10,2,16}, {32,4,48}, {255,0,140}, {255,255,50} },
        Cloud = { {245,245,248}, {235,240,245}, {200,210,220}, {30,90,240}, {20,30,50} },
        Sakura = { {255,240,244}, {250,225,235}, {240,120,180}, {230,50,130}, {80,10,40} }
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
                Placeholder = Color3.fromRGB(130, 130, 130),
                Button = Color3.fromRGB(colors[2][1], colors[2][2], colors[2][3]),
                Icon = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Toggle = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Slider = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Checkbox = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                Primary = Color3.fromRGB(colors[4][1], colors[4][2], colors[4][3]),
                SliderIcon = Color3.fromRGB(colors[5][1], colors[5][2], colors[5][3]),
                PanelBackground = Color3.fromRGB(colors[2][1], colors[2][2], colors[2][3]),
                PanelBackgroundTransparency = 0.5,
                LabelBackground = Color3.fromRGB(colors[1][1], colors[1][2], colors[1][3]),
                LabelBackgroundTransparency = 0.5
            })
        end)
    end
end

compileThemes()

local Window = WindUI:CreateWindow({
    Title = "Leviathan Hub | Insane Elevator",
    Icon = "crown",
    Author = "Version 0.1 | UI by Footagesus",
    Folder = "Leviathan_InsaneElevator",
    Theme = S.Theme,
    SideBarWidth = 180,
    NewElements = true,
    Transparent = true,
    Acrylic = S.Acrylic,
    ToggleKey = Enum.KeyCode[S.ToggleKey] or Enum.KeyCode.G,
    HideSearchBar = false,
    Background = "", 
    OpenButton = {
        Title = "Open",
        CornerRadius = UDim.new(5,21),
        StrokeThickness = 1,
        Enabled = true,
        Color = ColorSequence.new(Color3.fromRGB(20, 20, 20), Color3.fromRGB(240, 240, 240))
    },
    Topbar = {
        Height = 35,
        ButtonsType = "default"
    }
})

Window:Tag({
    Title = "0.0.1",
    Icon = "github",
    Color = Color3.fromRGB(48, 255, 106)
})

local FpsTag = Window:Tag({
    Title = "FPS: 0",
    Color = Color3.fromRGB(120, 240, 120)
})

local PingTag = Window:Tag({
    Title = "Ping: 0",
    Color = Color3.fromRGB(240, 180, 80)
})

local topButtonCall = pcall(function()
    Window.Topbar:Button({
        Name = "Copy Discord",
        Icon = "link",
        IconSize = 20,
        Callback = function()
            if setclipboard then
                setclipboard("https://discord.gg/8czznVURXc")
            end
        end
    })
end)

pcall(function()
    if Window.Container then
        local foundStroke = Window.Container:FindFirstChildOfClass("UIStroke")
        if foundStroke then
            foundStroke.Thickness = 4
            foundStroke.Color = Color3.fromRGB(255, 255, 255)
        else
            local stroke = Instance.new("UIStroke")
            stroke.Thickness = 4
            stroke.Color = Color3.fromRGB(255, 255, 255)
            stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
            stroke.Parent = Window.Container
        end
    end
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
    Icon = "cpu",
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
    Icon = "eye"
})

local ComTab = SecModules:Tab({
    Title = "Combat",
    Icon = "crosshair"
})

local NpcTab = SecModules:Tab({
    Title = "NPC Controler",
    Icon = "command"
})

local FunTab = SecModules:Tab({
    Title = "Troll & Fun",
    Icon = "activity"
})

local SecSystem = Window:Section({
    Title = "System",
    Icon = "settings",
    Opened = true
})

local SetTab = SecSystem:Tab({
    Title = "Interface Settings",
    Icon = "sliders"
})

MainTab:Paragraph({
    Title = "System Verified",
    Desc = "Leviathan Hub loaded successfully."
})

local PlayerViewport = MainTab:Viewport({
    Object = Instance.new("Part"),
    Interactive = true
})

task.spawn(function()
    local hasCloned = false
    while task.wait(1) do
        pcall(function()
            if PlayerViewport then
                if not hasCloned then
                    local charClone = getClonedCharacter()
                    if charClone then
                        PlayerViewport.Object = charClone
                        hasCloned = true
                        local hrp = charClone:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            if PlayerViewport.Camera then
                                PlayerViewport.Camera.CFrame = CFrame.new(hrp.Position + Vector3.new(0, 3, 8), hrp.Position)
                            end
                        end
                    end
                end
            end
        end)
    end
end)

local MovSec = MovTab:Section({
    Title = "Vector Displacement"
})

MovSec:Toggle({
    Title = "Fly State",
    Icon = "plane",
    Value = S.Fly,
    Callback = function(v)
        S.Fly = v
    end
})

MovSec:Toggle({
    Title = "Noclip State",
    Icon = "ghost",
    Value = S.Noclip,
    Callback = function(v)
        S.Noclip = v
    end
})

MovSec:Toggle({
    Title = "Bhop State",
    Icon = "chevron-up",
    Value = S.Bhop,
    Callback = function(v)
        S.Bhop = v
    end
})

MovSec:Toggle({
    Title = "Spin Vector",
    Icon = "refresh-cw",
    Value = S.SpinBot,
    Callback = function(v)
        S.SpinBot = v
    end
})

MovSec:Toggle({
    Title = "CFrame Movement",
    Icon = "move",
    Value = S.CFrameMoveActive,
    Callback = function(v)
        S.CFrameMoveActive = v
    end
})

MovSec:Slider({
    Title = "Velocity Magnitude",
    Icon = "gauge",
    Step = 1,
    Value = {
        Min = 16,
        Max = 400,
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
    Title = "Jump Potential",
    Icon = "arrow-up",
    Step = 1,
    Value = {
        Min = 50,
        Max = 500,
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
    Title = "Fly Magnitude",
    Icon = "wind",
    Step = 1,
    Value = {
        Min = 10,
        Max = 400,
        Default = S.FlySpeed
    },
    Callback = function(v)
        S.FlySpeed = v
    end
})

MovSec:Slider({
    Title = "CFrame Precision Velocity",
    Icon = "crosshair",
    Step = 1,
    Value = {
        Min = 1,
        Max = 20,
        Default = S.CFrameSpeed
    },
    Callback = function(v)
        S.CFrameSpeed = v
    end
})

local TpSec = MovTab:Section({
    Title = "Coordinate Mechanics"
})

TpSec:Button({
    Title = "Teleport to Spawn",
    Icon = "map-pin",
    Callback = function()
        local hrp = safeGetHRP()
        if hrp then
            hrp.CFrame = CFrame.new(0, 100, 0)
        end
    end
})

TpSec:Button({
    Title = "Teleport to Lobby",
    Icon = "home",
    Callback = function()
        local sp = Workspace:FindFirstChildWhichIsA("SpawnLocation", true)
        local hrp = safeGetHRP()
        if hrp then
            if sp then
                hrp.CFrame = sp.CFrame + Vector3.new(0, 4, 0)
            end
        end
    end
})

local SurSec = SurTab:Section({
    Title = "Mitigation Fields"
})

SurSec:Toggle({
    Title = "Forcefield ( Patched )",
    Icon = "shield",
    Value = S.ForceField,
    Callback = function(v)
        S.ForceField = v
    end
})

SurSec:Toggle({
    Title = "Ghost Dimension",
    Icon = "eye-off",
    Value = S.GhostMode,
    Callback = function(v)
        S.GhostMode = v
        if v then
            local char = LocalPlayer.Character
            if char then
                for _, p in ipairs(char:GetDescendants()) do
                    if p:IsA("BasePart") then
                        GhostStorage[p] = p.Transparency
                        p.Transparency = 0.6
                    end
                end
            end
        else
            for part, trans in pairs(GhostStorage) do
                if part then
                    if part.Parent then
                        part.Transparency = trans
                    end
                end
            end
            table.clear(GhostStorage)
        end
    end
})

local EspSec = VisTab:Section({
    Title = "Visuals"
})

EspSec:Toggle({
    Title = "Esp Players",
    Icon = "users",
    Value = S.EspPlayers,
    Callback = function(v)
        S.EspPlayers = v
    end
})

EspSec:Toggle({
    Title = "Esp Monsters",
    Icon = "bug",
    Value = S.EspMonsters,
    Callback = function(v)
        S.EspMonsters = v
    end
})

EspSec:Toggle({
    Title = "Esp Boxes",
    Icon = "square",
    Value = S.EspBox,
    Callback = function(v)
        S.EspBox = v
    end
})

EspSec:Toggle({
    Title = "Esp Names",
    Icon = "type",
    Value = S.EspName,
    Callback = function(v)
        S.EspName = v
    end
})

EspSec:Toggle({
    Title = "Custom Display Names",
    Icon = "edit-3",
    Value = S.EspCustomDisplay,
    Callback = function(v)
        S.EspCustomDisplay = v
    end
})

EspSec:Toggle({
    Title = "Esp Distance",
    Icon = "navigation",
    Value = S.EspDist,
    Callback = function(v)
        S.EspDist = v
    end
})

EspSec:Toggle({
    Title = "Esp Health",
    Icon = "heart",
    Value = S.EspHealth,
    Callback = function(v)
        S.EspHealth = v
    end
})

EspSec:Toggle({
    Title = "Draw Tracers",
    Icon = "git-commit",
    Value = S.EspTracers,
    Callback = function(v)
        S.EspTracers = v
    end
})

EspSec:Toggle({
    Title = "X-ray Esp",
    Icon = "search",
    Value = S.EspXray,
    Callback = function(v)
        S.EspXray = v
    end
})

EspSec:Input({
    Title = "Custom Display Name String",
    Icon = "pen-tool",
    Value = S.CustomDisplayNameString,
    Callback = function(v)
        S.CustomDisplayNameString = v
    end
})

EspSec:Colorpicker({
    Title = "Esp Color",
    Icon = "droplet",
    Default = S.EspColor,
    Callback = function(color)
        if typeof(color) == "Color3" then
            S.EspColor = color
        end
    end
})

local AimSec = ComTab:Section({
    Title = "Orientation Lock"
})

AimSec:Toggle({
    Title = "Kinematic Lock",
    Icon = "crosshair",
    Value = S.AimbotEnabled,
    Callback = function(v)
        S.AimbotEnabled = v
    end
})

AimSec:Toggle({
    Title = "Field Visualization",
    Icon = "eye",
    Value = S.ShowFOV,
    Callback = function(v)
        S.ShowFOV = v
    end
})

AimSec:Slider({
    Title = "Field Bound Magnitude",
    Icon = "maximize",
    Step = 5,
    Value = {
        Min = 30,
        Max = 600,
        Default = S.FOVRadius
    },
    Callback = function(v)
        S.FOVRadius = v
    end
})

AimSec:Dropdown({
    Title = "Structural Element Node",
    Icon = "user",
    Values = {"Head", "HumanoidRootPart"},
    Value = S.TargetBone,
    Callback = function(v)
        S.TargetBone = v
    end
})

local HitSec = ComTab:Section({
    Title = "Volumetric Extrapolator"
})

HitSec:Toggle({
    Title = "Volumetric Override",
    Icon = "box",
    Value = S.HitboxEnabled,
    Callback = function(v)
        S.HitboxEnabled = v
    end
})

HitSec:Slider({
    Title = "Scale Factor Coefficient",
    Icon = "sliders",
    Step = 1,
    Value = {
        Min = 2,
        Max = 80,
        Default = S.HitboxMultiplier
    },
    Callback = function(v)
        S.HitboxMultiplier = v
    end
})

HitSec:Dropdown({
    Title = "Target Node Array",
    Icon = "layers",
    Values = {"Head", "HumanoidRootPart", "Torso"},
    Value = S.HitboxTarget,
    Callback = function(v)
        S.HitboxTarget = v
    end
})

local NpcLockSec = NpcTab:Section({
    Title = "Lockdown NPCs"
})

NpcLockSec:Toggle({
    Title = "Freeze",
    description = "Some NPCs Are Unfreezeable , Only Works With 95% of NPCs",
    Icon = "anchor",
    Value = S.FreezeEngine,
    Callback = function(v)
        S.FreezeEngine = v
    end
})

NpcLockSec:Dropdown({
    Title = "Freeze Method",
    Icon = "cpu",
    Values = {"Network", "PositionLock", "GravityNullify"},
    Value = S.FreezeMode,
    Callback = function(v)
        S.FreezeMode = v
    end
})

NpcLockSec:Toggle({
    Title = "Specialized Suppression ( Patched )",
    Icon = "alert-circle",
    Value = S.SuppressNPCs,
    Callback = function(v)
        S.SuppressNPCs = v
    end
})

local ToolSec = NpcTab:Section({
    Title = "Npcs Killer Tools"
})

ToolSec:Button({
    Title = "Leviathan Scythe",
    Icon = "scissors",
    Callback = function()
        local tool = Instance.new("Tool")
        tool.Name = "Leviathan Scythe"
        tool.RequiresHandle = true
        
        local handle = Instance.new("Part")
        handle.Parent = tool
        handle.Name = "Handle"
        handle.Size = Vector3.new(1.2, 6.5, 1.2)
        handle.Massless = true
        handle.Transparency = 0
        handle.Material = Enum.Material.Glass
        handle.Color = Color3.fromRGB(40, 0, 70)
        
        local mesh = Instance.new("SpecialMesh")
        mesh.Parent = handle
        mesh.MeshId = "rbxassetid://14349160130"
        mesh.TextureId = "rbxassetid://14349162120"
        mesh.Scale = Vector3.new(0.08, 0.08, 0.08)
        
        local sound = Instance.new("Sound")
        sound.Parent = handle
        sound.SoundId = "rbxassetid://9114223193"
        sound.Volume = 3
        sound.PlaybackSpeed = 0.9
        
        local emitter = Instance.new("ParticleEmitter")
        emitter.Parent = handle
        emitter.Texture = "rbxassetid://241581402"
        emitter.LightEmission = 0.9
        emitter.Color = ColorSequence.new(Color3.fromRGB(150, 0, 255), Color3.fromRGB(10, 0, 20))
        emitter.Rate = 80
        emitter.Speed = NumberRange.new(3, 7)
        
        tool.Parent = LocalPlayer.Backpack
        local actionswitch = false
        
        tool.Activated:Connect(function()
            if actionswitch then
                return
            end
            actionswitch = true
            sound:Play()
            
            pcall(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = S.ScytheAnim
                local hum = safeGetHumanoid()
                if hum then
                    local track = hum:LoadAnimation(anim)
                    track:Play()
                end
            end)
            
            local mouseTarget = Mouse.Hit.Position
            for npc, _ in pairs(_G.ActiveNPCs) do
                if npc then
                    if npc.Parent then
                        local hrp = npc:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            local distance = (hrp.Position - mouseTarget).Magnitude
                            if distance <= 40 then
                                pcall(function()
                                    hrp:ApplyImpulse(Vector3.new(0, 1200, 0) * hrp:GetMass())
                                    hrp.AssemblyLinearVelocity = Vector3.new(0, 200, 0)
                                end)
                            end
                        end
                    end
                end
            end
            task.wait(0.2)
            actionswitch = false
        end)
    end
})

ToolSec:Toggle({
    Title = "Kill Aura ( Patched & Unreliable )",
    Icon = "zap",
    Value = S.KillAura,
    Callback = function(v)
        S.KillAura = v
    end
})

local TrollSec = FunTab:Section({
    Title = "Server Disruption"
})

TrollSec:Input({
    Title = "Target Player ( Patched )",
    Icon = "target",
    Value = S.ChaseVictim,
    Callback = function(v)
        S.ChaseVictim = v
    end
})

TrollSec:Toggle({
    Title = "Spatial Intercept Static ( Patched )",
    Icon = "link",
    Value = S.ChaseActive,
    Callback = function(v)
        S.ChaseActive = v
    end
})

TrollSec:Toggle({
    Title = "Spam Messages ( Patched )",
    Icon = "message-circle",
    Value = S.ChatSpam,
    Callback = function(v)
        S.ChatSpam = v
    end
})

TrollSec:Input({
    Title = "Message Resource Array ( Patched )",
    Icon = "edit-2",
    Value = S.SpamMsg,
    Callback = function(v)
        S.SpamMsg = v
    end
})

TrollSec:Toggle({
    Title = "Glitch Yourself",
    Icon = "activity",
    Value = S.GlitchStance,
    Callback = function(v)
        S.GlitchStance = v
    end
})

TrollSec:Toggle({
    Title = "Fling ( Bug )",
    Icon = "rotate-ccw",
    Value = S.FlingActive,
    Callback = function(v)
        S.FlingActive = v
    end
})

TrollSec:Toggle({
    Title = "Touch Fling ( Bug )",
    Icon = "loader",
    Value = S.FlingTouchActive,
    Callback = function(v)
        S.FlingTouchActive = v
    end
})

local WldSec = FunTab:Section({
    Title = "Environment Overrides"
})

WldSec:Toggle({
    Title = "Disco Sky",
    Icon = "sun",
    Value = S.DiscoSky,
    Callback = function(v)
        S.DiscoSky = v
        if not v then
            Lighting.Ambient = OriginalLightingSettings.Ambient
        end
    end
})

WldSec:Toggle({
    Title = "Gravity",
    Icon = "arrow-down",
    Value = S.LowGravity,
    Callback = function(v)
        S.LowGravity = v
        if v then
            Workspace.Gravity = 25
        else
            Workspace.Gravity = 196.2
        end
    end
})

WldSec:Slider({
    Title = "Time cycle Speed",
    Icon = "clock",
    Step = 0.5,
    Value = {
        Min = 1,
        Max = 20,
        Default = S.TimeSpeed
    },
    Callback = function(v)
        S.TimeSpeed = v
    end
})

WldSec:Slider({
    Title = "Day Time",
    Icon = "moon",
    Step = 1,
    Value = {
        Min = 0,
        Max = 24,
        Default = S.DayTime
    },
    Callback = function(v)
        S.DayTime = v
    end
})

local UtilSec = SetTab:Section({
    Title = "Client Modifications"
})

UtilSec:Toggle({
    Title = "Anti AFK",
    Icon = "monitor",
    Value = S.AntiAFK,
    Callback = function(v)
        S.AntiAFK = v
    end
})

UtilSec:Toggle({
    Title = "Full Bright",
    Icon = "sun",
    Value = S.Fullbright,
    Callback = function(v)
        S.Fullbright = v
    end
})

UtilSec:Toggle({
    Title = "Remove Fog",
    Icon = "cloud-off",
    Value = S.NoFog,
    Callback = function(v)
        S.NoFog = v
    end
})

local CfgSec = SetTab:Section({
    Title = "Interface"
})

local themeNames = {}
for name in pairs(WindUI:GetThemes()) do
    table.insert(themeNames, name)
end
table.sort(themeNames)

CfgSec:Dropdown({
    Title = "Selected Theme",
    Icon = "aperture",
    Values = themeNames,
    Value = S.Theme,
    Callback = function(v)
        S.Theme = v
        pcall(function()
            WindUI:SetTheme(v)
        end)
    end
})

CfgSec:Toggle({
    Title = "Interface Interpolation Gradients",
    Icon = "layers",
    Value = S.UIStyleGradient,
    Callback = function(v)
        S.UIStyleGradient = v
    end
})

CfgSec:Toggle({
    Title = "Acrylic",
    Icon = "layout",
    Value = S.Acrylic,
    Callback = function(v)
        S.Acrylic = v
    end
})

CfgSec:Button({
    Title = "Rejoin Server",
    Icon = "log-in",
    Callback = function()
        local count = #Players:GetPlayers()
        if count <= 1 then
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
        end
    end
})

CfgSec:Button({
    Title = "Server Hop",
    Icon = "globe",
    Callback = function()
        local endpoint = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
        local success, response = pcall(function() return game:HttpGet(endpoint) end)
        if success then
            local decoded = HttpService:JSONDecode(response)
            if decoded then
                if decoded.data then
                    local instances = {}
                    for _, server in ipairs(decoded.data) do
                        if server.playing < server.maxPlayers then
                            if server.id ~= game.JobId then
                                table.insert(instances, server.id)
                            end
                        end
                    end
                    if #instances > 0 then
                        local targetInstance = instances[math.random(1, #instances)]
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, targetInstance, LocalPlayer)
                    end
                end
            end
        end
    end
})

_G.ActiveNPCs = {}

local function processWorkspaceEntity(object)
    if object:IsA("Model") then
        local hrp = object:FindFirstChild("HumanoidRootPart")
        if hrp then
            local verifyPlayer = Players:GetPlayerFromCharacter(object)
            if not verifyPlayer then
                _G.ActiveNPCs[object] = true
            end
        end
    end
end

for _, element in ipairs(Workspace:GetDescendants()) do
    processWorkspaceEntity(element)
end

Workspace.DescendantAdded:Connect(function(element)
    if element:IsA("Model") then
        task.delay(0.1, function()
            processWorkspaceEntity(element)
        end)
    end
end)

local function unregisterEsp(model)
    if EspCache[model] then
        for _, renderingEntity in pairs(EspCache[model].Drawings) do
            renderingEntity:Remove()
        end
        EspCache[model] = nil
    end
end

local function registerEsp(model, isMonster)
    if EspCache[model] then
        return
    end
    local systemDrawings = {
        Box = Drawing.new("Square"),
        Text = Drawing.new("Text"),
        Tracer = Drawing.new("Line"),
        HealthBar = Drawing.new("Line")
    }
    systemDrawings.Box.Thickness = 3
    systemDrawings.Box.Filled = false
    systemDrawings.Box.Transparency = 1
    systemDrawings.Text.Size = 15
    systemDrawings.Text.Center = true
    systemDrawings.Text.Outline = true
    systemDrawings.Text.Transparency = 1
    systemDrawings.Tracer.Thickness = 2
    systemDrawings.Tracer.Transparency = 1
    systemDrawings.HealthBar.Thickness = 3
    systemDrawings.HealthBar.Transparency = 1
    EspCache[model] = {
        Drawings = systemDrawings,
        IsMonster = isMonster
    }
end

local FieldOfViewRing = Drawing.new("Circle")
FieldOfViewRing.Thickness = 2
FieldOfViewRing.Filled = false
FieldOfViewRing.Transparency = 0.9
FieldOfViewRing.Color = Color3.fromRGB(255, 255, 255)

local EngineTaskRegistry = { LoopHeartbeat = {}, LoopRender = {} }

function EngineTaskRegistry:BindHeartbeat(identifier, method)
    self.LoopHeartbeat[identifier] = method
end

function EngineTaskRegistry:BindRender(identifier, method)
    self.LoopRender[identifier] = method
end

RunService.Heartbeat:Connect(function(deltaTime)
    for _, taskMethod in pairs(EngineTaskRegistry.LoopHeartbeat) do
        pcall(taskMethod, deltaTime)
    end
end)

RunService.RenderStepped:Connect(function(deltaTime)
    for _, taskMethod in pairs(EngineTaskRegistry.LoopRender) do
        pcall(taskMethod, deltaTime)
    end
end)

local measurementFrames = 0
local periodicTimestamp = tick()

EngineTaskRegistry:BindHeartbeat("CoreDiagnosticsTelemetry", function()
    measurementFrames = measurementFrames + 1
    local preciseCurrentTime = tick()
    if preciseCurrentTime - periodicTimestamp >= 1 then
        local computationalFps = math.floor(measurementFrames / (preciseCurrentTime - periodicTimestamp))
        FpsTag:SetTitle("FPS: " .. tostring(computationalFps))
        measurementFrames = 0
        periodicTimestamp = preciseCurrentTime
    end
    pcall(function()
        local activePingValue = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        PingTag:SetTitle("Ping: " .. tostring(activePingValue) .. "ms")
    end)
end)

EngineTaskRegistry:BindHeartbeat("SynchronizedInertiaLock", function()
    if not S.FreezeEngine then
        return
    end
    pcall(function()
        settings().Physics.AllowSleep = false
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
        sethiddenproperty(LocalPlayer, "MaxSimulationRadius", math.huge)
    end)
    for targetNpc, _ in pairs(_G.ActiveNPCs) do
        if targetNpc then
            if targetNpc.Parent then
                local hrp = targetNpc:FindFirstChild("HumanoidRootPart")
                local hum = targetNpc:FindFirstChildOfClass("Humanoid")
                if hrp then
                    pcall(function()
                        if sethiddenproperty then
                            sethiddenproperty(targetNpc, "NetworkOwnershipRule", Enum.NetworkOwnershipRule.Manual)
                        end
                        if hrp.SetNetworkOwner then
                            hrp:SetNetworkOwner(LocalPlayer)
                        end
                    end)
                    if S.FreezeMode == "Network" then
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                        if hum then
                            hum.WalkSpeed = 0
                            hum.PlatformStand = true
                        end
                    end
                    if S.FreezeMode == "PositionLock" then
                        hrp.Anchored = true
                        if hum then
                            hum.WalkSpeed = 0
                        end
                    end
                    if S.FreezeMode == "GravityNullify" then
                        hrp.AssemblyLinearVelocity = Vector3.new(0, 4, 0)
                        hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end
    end
end)

EngineTaskRegistry:BindHeartbeat("MatrixVectorKinematics", function()
    local character = LocalPlayer.Character
    if not character then
        return
    end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hrp then
        return
    end
    if not hum then
        return
    end

    if S.Fly then
        hum.PlatformStanding = true
        local directionalVector = hum.MoveDirection
        local cameraOrientation = CurrentCamera.CFrame
        local accumulationVelocity = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            accumulationVelocity = accumulationVelocity + cameraOrientation.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            accumulationVelocity = accumulationVelocity - cameraOrientation.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            accumulationVelocity = accumulationVelocity - cameraOrientation.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            accumulationVelocity = accumulationVelocity + cameraOrientation.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            accumulationVelocity = accumulationVelocity + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            accumulationVelocity = accumulationVelocity - Vector3.new(0, 1, 0)
        end
        if accumulationVelocity.Magnitude > 0 then
            hrp.Velocity = accumulationVelocity.Unit * S.FlySpeed
        else
            hrp.Velocity = Vector3.zero
        end
    else
        if hum.PlatformStanding then
            if not S.GlitchStance then
                hum.PlatformStanding = false
            end
        end
    end

    if S.CFrameMoveActive then
        local trackingVector = Vector3.zero
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            trackingVector = trackingVector + CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            trackingVector = trackingVector - CurrentCamera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            trackingVector = trackingVector - CurrentCamera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            trackingVector = trackingVector + CurrentCamera.CFrame.RightVector
        end
        if trackingVector.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (trackingVector.Unit * S.CFrameSpeed)
        end
    end

    if S.Noclip then
        for _, geometricPart in ipairs(character:GetDescendants()) do
            if geometricPart:IsA("BasePart") then
                geometricPart.CanCollide = false
            end
        end
    end

    if S.Bhop then
        if hum.FloorMaterial ~= Enum.Material.Air then
            hrp:ApplyImpulse(Vector3.new(0, hum.JumpPower, 0) * hrp:GetMass())
        end
    end

    if S.SpinBot then
        hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(S.SpinSpeed), 0)
    end

    if S.AntiTouch then
        for _, connectionNode in ipairs(Workspace:GetDescendants()) do
            if connectionNode:IsA("TouchTransmitter") then
                connectionNode:Destroy()
            end
        end
    end

    if S.ForceField then
        local activeFf = character:FindFirstChildOfClass("ForceField")
        if not activeFf then
            Instance.new("ForceField", character)
        end
    end
end)

EngineTaskRegistry:BindHeartbeat("EngagementMatrixKinematics", function()
    if S.AimbotEnabled then
        local validatedLockTarget = nil
        local baselineRadius = S.FOVRadius
        local screenMidpoint = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)
        
        local function analyzeStructuralTarget(entityModel)
            if entityModel then
                if entityModel ~= LocalPlayer.Character then
                    local anatomyPart = entityModel:FindFirstChild(S.TargetBone)
                    if anatomyPart then
                        local positionProjection, geometryOnScreen = CurrentCamera:WorldToViewportPoint(anatomyPart.Position)
                        if geometryOnScreen then
                            local linearMagnitude = (Vector2.new(positionProjection.X, positionProjection.Y) - screenMidpoint).Magnitude
                            if linearMagnitude < baselineRadius then
                                baselineRadius = linearMagnitude
                                validatedLockTarget = anatomyPart
                            end
                        end
                    end
                end
            end
        end

        for _, interactivePlayer in ipairs(Players:GetPlayers()) do
            if interactivePlayer.Character then
                analyzeStructuralTarget(interactivePlayer.Character)
            end
        end
        for designatedNpc, _ in pairs(_G.ActiveNPCs) do
            analyzeStructuralTarget(designatedNpc)
        end

        if validatedLockTarget then
            local lookAtMatrix = CFrame.new(CurrentCamera.CFrame.Position, validatedLockTarget.Position)
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(lookAtMatrix, S.Smoothness)
        end
    end

    if S.HitboxEnabled then
        local function executeVolumetricExpansion(entityModel)
            if entityModel then
                if entityModel ~= LocalPlayer.Character then
                    local targetedExpansionPart = entityModel:FindFirstChild(S.HitboxTarget)
                    if targetedExpansionPart then
                        if targetedExpansionPart:IsA("BasePart") then
                            if not HitboxCache[targetedExpansionPart] then
                                HitboxCache[targetedExpansionPart] = { 
                                    Size = targetedExpansionPart.Size, 
                                    Transparency = targetedExpansionPart.Transparency, 
                                    CanCollide = targetedExpansionPart.CanCollide 
                                }
                            end
                            targetedExpansionPart.Size = Vector3.new(S.HitboxMultiplier, S.HitboxMultiplier, S.HitboxMultiplier)
                            targetedExpansionPart.Transparency = S.HitboxTransparency
                            targetedExpansionPart.CanCollide = false
                        end
                    end
                end
            end
        end

        for _, interactivePlayer in ipairs(Players:GetPlayers()) do
            if interactivePlayer.Character then
                executeVolumetricExpansion(interactivePlayer.Character)
            end
        end
        for designatedNpc, _ in pairs(_G.ActiveNPCs) do
            executeVolumetricExpansion(designatedNpc)
        end
    else
        if next(HitboxCache) then
            for targetedPart, componentData in pairs(HitboxCache) do
                if targetedPart then
                    if targetedPart.Parent then
                        targetedPart.Size = componentData.Size
                        targetedPart.Transparency = componentData.Transparency
                        targetedPart.CanCollide = componentData.CanCollide
                    end
                end
            end
            table.clear(HitboxCache)
        end
    end

    if S.KillAura then
        local selfHrp = safeGetHRP()
        if selfHrp then
            local function checkAndStrikeEntity(entityModel)
                if entityModel then
                    if entityModel ~= LocalPlayer.Character then
                        local remoteHrp = entityModel:FindFirstChild("HumanoidRootPart")
                        if remoteHrp then
                            local evaluationDistance = (selfHrp.Position - remoteHrp.Position).Magnitude
                            if evaluationDistance <= S.AuraRange then
                                local activationTool = LocalPlayer.Character:FindFirstChildOfClass("Tool")
                                if activationTool then
                                    activationTool:Activate()
                                end
                            end
                        end
                    end
                end
            end
            for _, interactivePlayer in ipairs(Players:GetPlayers()) do
                if interactivePlayer.Character then
                    checkAndStrikeEntity(interactivePlayer.Character)
                end
            end
            for designatedNpc, _ in pairs(_G.ActiveNPCs) do
                checkAndStrikeEntity(designatedNpc)
            end
        end
    end
end)

EngineTaskRegistry:BindHeartbeat("TrollDisruptionWorldCore", function()
    if S.ChaseActive then
        if S.ChaseVictim ~= "" then
            local targetedPlayerInstance = Players:FindFirstChild(S.ChaseVictim)
            if targetedPlayerInstance then
                if targetedPlayerInstance.Character then
                    local targetHrpNode = targetedPlayerInstance.Character:FindFirstChild("HumanoidRootPart")
                    local currentSelfHrp = safeGetHRP()
                    if targetHrpNode then
                        if currentSelfHrp then
                            currentSelfHrp.CFrame = targetHrpNode.CFrame * CFrame.new(0, 0, 2.5)
                        end
                    end
                end
            end
        end
    end

    if S.GlitchStance then
        local dynamicHumanoid = safeGetHumanoid()
        if dynamicHumanoid then
            dynamicHumanoid.PlatformStanding = true
        end
        local currentSelfHrp = safeGetHRP()
        if currentSelfHrp then
            currentSelfHrp.CFrame = currentSelfHrp.CFrame * CFrame.Angles(math.rad(math.random(-60, 60)), math.rad(math.random(-60, 60)), math.rad(math.random(-60, 60)))
        end
    end

    if S.FlingActive then
        local currentSelfHrp = safeGetHRP()
        if currentSelfHrp then
            currentSelfHrp.AssemblyLinearVelocity = Vector3.new(999999, 999999, 999999)
            currentSelfHrp.AssemblyAngularVelocity = Vector3.new(999999, 999999, 999999)
        end
    end

    if S.FlingTouchActive then
        local currentSelfHrp = safeGetHRP()
        if currentSelfHrp then
            currentSelfHrp.AssemblyLinearVelocity = Vector3.new(9999, 9999, 9999)
            currentSelfHrp.AssemblyAngularVelocity = Vector3.new(9999, 9999, 9999)
        end
    end

    if S.DiscoSky then
        Lighting.Ambient = Color3.fromRGB(math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end

    if S.Fullbright then
        Lighting.Ambient = Color3.fromRGB(255, 255, 255)
        Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        Lighting.Brightness = 4
    end

    if S.NoFog then
        Lighting.FogEnd = 9e10
        Lighting.FogStart = 9e10
    end

    Lighting.ClockTime = (Lighting.ClockTime + (S.TimeSpeed / 50)) % 24
    if S.DayTime then
        Lighting.ClockTime = S.DayTime
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if S.ChatSpam then
            if S.SpamMsg ~= "" then
                pcall(function()
                    if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
                        local primaryChannel = TextChatService.TextChannels.RBXGeneral
                        if primaryChannel then
                            primaryChannel:SendAsync(S.SpamMsg)
                        end
                    else
                        local LegacyCommunicationRemote = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                        if LegacyCommunicationRemote then
                            LegacyCommunicationRemote:FireServer(S.SpamMsg, "All")
                        end
                    end
                end)
                task.wait(S.SpamDelay)
            end
        end
    end
end)

EngineTaskRegistry:BindRender("SpatialRasterizationEngine", function()
    FieldOfViewRing.Visible = S.ShowFOV
    FieldOfViewRing.Radius = S.FOVRadius
    FieldOfViewRing.Position = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)

    if S.EspPlayers then
        for _, interactivePlayer in ipairs(Players:GetPlayers()) do
            if interactivePlayer ~= LocalPlayer then
                if interactivePlayer.Character then
                    registerEsp(interactivePlayer.Character, false)
                end
            end
        end
    end

    if S.EspMonsters then
        for designatedNpc, _ in pairs(_G.ActiveNPCs) do
            if designatedNpc then
                if designatedNpc.Parent then
                    registerEsp(designatedNpc, true)
                end
            end
        end
    end

    for activeModel, telemetryData in pairs(EspCache) do
        if activeModel then
            if activeModel.Parent then
                local targetHrpNode = activeModel:FindFirstChild("HumanoidRootPart")
                local dynamicHumanoid = activeModel:FindFirstChildOfClass("Humanoid")
                if targetHrpNode then
                    if dynamicHumanoid then
                        if dynamicHumanoid.Health > 0 then
                            local translationViewport, coordinateOnScreen = CurrentCamera:WorldToViewportPoint(targetHrpNode.Position)
                            if coordinateOnScreen then
                                local renderingComponents = telemetryData.Drawings
                                local anatomyHead = activeModel:FindFirstChild("Head")
                                local headProjection = anatomyHead and CurrentCamera:WorldToViewportPoint(anatomyHead.Position + Vector3.new(0, 0.6, 0)) or translationViewport
                                local calculationHeight = math.abs(headProjection.Y - translationViewport.Y) * 2.4
                                local calculationWidth = calculationHeight / 1.5
                                
                                if S.EspBox then
                                    renderingComponents.Box.Size = Vector2.new(calculationWidth, calculationHeight)
                                    renderingComponents.Box.Position = Vector2.new(translationViewport.X - calculationWidth / 2, translationViewport.Y - calculationHeight / 2)
                                    renderingComponents.Box.Color = S.EspColor
                                    renderingComponents.Box.Visible = true
                                else
                                    renderingComponents.Box.Visible = false
                                end

                                if S.EspName or S.EspDist or S.EspHealth or S.EspCustomDisplay then
                                    local compoundString = ""
                                    if S.EspCustomDisplay then
                                        compoundString = compoundString .. S.CustomDisplayNameString .. " "
                                    elseif S.EspName then
                                        local derivedPlayer = Players:GetPlayerFromCharacter(activeModel)
                                        if derivedPlayer then
                                            compoundString = compoundString .. derivedPlayer.DisplayName .. " "
                                        else
                                            compoundString = compoundString .. activeModel.Name .. " "
                                        end
                                    end
                                    if S.EspHealth then
                                        compoundString = compoundString .. "[" .. math.floor(dynamicHumanoid.Health) .. " HP] "
                                    end
                                    if S.EspDist then
                                        local evaluationSelfHrp = safeGetHRP()
                                        if evaluationSelfHrp then
                                            local vectorDistance = math.floor((evaluationSelfHrp.Position - targetHrpNode.Position).Magnitude)
                                            compoundString = compoundString .. "[" .. tostring(vectorDistance) .. "m]"
                                        end
                                    end
                                    renderingComponents.Text.Text = compoundString
                                    renderingComponents.Text.Color = S.EspColor
                                    renderingComponents.Text.Position = Vector2.new(translationViewport.X, translationViewport.Y - calculationHeight / 2 - 22)
                                    renderingComponents.Text.Visible = true
                                else
                                    renderingComponents.Text.Visible = false
                                end

                                if S.EspTracers then
                                    renderingComponents.Tracer.From = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
                                    renderingComponents.Tracer.To = Vector2.new(translationViewport.X, translationViewport.Y)
                                    renderingComponents.Tracer.Color = S.EspColor
                                    renderingComponents.Tracer.Visible = true
                                else
                                    renderingComponents.Tracer.Visible = false
                                end

                                if S.EspHealth then
                                    renderingComponents.HealthBar.From = Vector2.new(translationViewport.X - calculationWidth / 2 - 7, translationViewport.Y + calculationHeight / 2)
                                    renderingComponents.HealthBar.To = Vector2.new(translationViewport.X - calculationWidth / 2 - 7, translationViewport.Y + calculationHeight / 2 - (calculationHeight * (dynamicHumanoid.Health / dynamicHumanoid.MaxHealth)))
                                    renderingComponents.HealthBar.Color = Color3.fromRGB(0, 255, 0):Lerp(Color3.fromRGB(255, 0, 0), 1 - (dynamicHumanoid.Health / dynamicHumanoid.MaxHealth))
                                    renderingComponents.HealthBar.Visible = true
                                else
                                    renderingComponents.HealthBar.Visible = false
                                end

                                if S.EspXray then
                                    for _, atomicPart in ipairs(activeModel:GetDescendants()) do
                                        if atomicPart:IsA("BasePart") then
                                            atomicPart.Material = Enum.Material.Neon
                                        end
                                    end
                                end
                            else
                                unregisterEsp(activeModel)
                            end
                        else
                            unregisterEsp(activeModel)
                        end
                    else
                        unregisterEsp(activeModel)
                    end
                else
                    unregisterEsp(activeModel)
                end
            else
                EspCache[activeModel] = nil
            end
        else
            EspCache[activeModel] = nil
        end
    end
end)

LocalPlayer.Idled:Connect(function()
    if S.AntiAFK then
        local baselineVirtualVector = Vector2.zero
        local cameraTransformationCF = CurrentCamera.CFrame
        VirtualUser:Button2Down(baselineVirtualVector, cameraTransformationCF)
        task.wait(0.1)
        VirtualUser:Button2Up(baselineVirtualVector, cameraTransformationCF)
    end
end)

pcall(function()
    if Window then
        if Window.Container then
            for _, nestedElement in ipairs(Window.Container:GetDescendants()) do
                if nestedElement:IsA("Frame") or nestedElement:IsA("ScrollingFrame") then
                    if not nestedElement:FindFirstChildOfClass("UIGradient") then
                        local proceduralGradient = Instance.new("UIGradient")
                        proceduralGradient.Color = ColorSequence.new({
                            ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                            ColorSequenceKeypoint.new(1, Color3.fromRGB(60, 60, 60))
                        })
                        proceduralGradient.Rotation = 90
                        proceduralGradient.Parent = nestedElement
                    end
                end
            end
        end
    end
end)

print("Succesful Loaded Assets")

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Leviathan Loader",
    Text = "Loaded Script!",
    Duration = 1.5
})

task.wait(0.5)

print("Hello ,")

task.wait(0.5)

print("Im A Leviathan...")

task.wait(0.5)

print("No , Im A Fish!")

task.wait(0.5)

print("Some Functions May Not Working And Bug")
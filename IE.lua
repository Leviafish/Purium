local isGameReady = false

local function initializeSystem()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
    
    local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    isGameReady = true
    print("[Leviathan]: Comfirmed Game Loaded!")
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
game:GetService("StarterGui"):SetCore("SendNotification",
    { Title = "Leviathan Loader",
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
        Theme = "Dark",
        Acrylic = true,
        ToggleKey = "RightShift",
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
        SpamMsg = "GG , Bro Ts Peak",
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
    return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
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
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)

if not UILoader then
    LocalPlayer:Kick("Failed to load WindUI.")
    return
end

local function compileThemes()
    local palette = {
        AMOLED = {"000000", "050505", "121212", "ffffff", "ffffff"},
        Amethyst = {"020005", "05010a", "140320", "b800e6", "f0e6ff"},
        Night = {"010103", "030308", "0a0a1a", "3b82f6", "f1f5f9"},
        Hacker = {"000000", "010301", "001a00", "00ff00", "39ff14"},
        Cyberpunk = {"030005", "08000d", "1c002b", "ff007f", "ffff00"},
        Cloud = {"fafafa", "f1f5f9", "cbd5e1", "1d4ed8", "0f172a"},
        Sakura = {"fff5f7", "fce7f3", "f472b6", "db2777", "4c0519"}
    }
    for name, c in pairs(palette) do
        pcall(function()
            WindUI:AddTheme({
                Name = name,
                Background = Color3.fromHex(c[1]),
                Dialog = Color3.fromHex(c[2]),
                Outline = Color3.fromHex(c[3]),
                Accent = Color3.fromHex(c[4]),
                Text = Color3.fromHex(c[5]),
                Placeholder = Color3.fromHex("777777"),
                Button = Color3.fromHex(c[2]),
                Icon = Color3.fromHex(c[4]),
                Toggle = Color3.fromHex(c[4]),
                Slider = Color3.fromHex(c[4]),
                Checkbox = Color3.fromHex(c[4]),
                Primary = Color3.fromHex(c[4]),
                SliderIcon = Color3.fromHex(c[5]),
                PanelBackground = Color3.fromHex(c[2]),
                PanelBackgroundTransparency = 0.05,
                LabelBackground = Color3.fromHex(c[1]),
                LabelBackgroundTransparency = 0.05
            })
        end)
    end
end

compileThemes()

local Window

local function RebuildInterface()
    pcall(function()
        for _, g in ipairs(CoreGui:GetChildren()) do
            if g:IsA("ScreenGui") and (g.Name == "WindUI" or g:FindFirstChild("Main")) then
                g:Destroy()
            end
        end
        for _, g in ipairs(LocalPlayer:WaitForChild("PlayerGui"):GetChildren()) do
            if g:IsA("ScreenGui") and (g.Name == "WindUI" or g:FindFirstChild("Main")) then
                g:Destroy()
            end
        end
    end)
    
    task.wait(0.1)

    Window = WindUI:CreateWindow({
        Title = "Leviathan Hub 0.1",
        Icon = "solar:compass-big-bold",
        Author = ".ftgs / ngao-gamer",
        Folder = "LeviathanHub",
        Theme = S.Theme,
        NewElements = true,
        Transparent = true,
        Acrylic = S.Acrylic,
        ToggleKey = Enum.KeyCode[S.ToggleKey],
        HideSearchBar = false,
        OpenButton = {
            Title = "Open Leviathan",
            CornerRadius = UDim.new(0, 8),
            StrokeThickness = 2,
            Enabled = true,
            Color = ColorSequence.new(Color3.fromHex("000000"), Color3.fromHex("ffffff"))
        },
        Topbar = {
            Height = 44,
            ButtonsType = "Mac"
        }
    })

    Window:Tag({
        Title = "Build 0.1",
        Color = Color3.fromRGB(0, 255, 255)
    })

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

    local MainTab = Window:Tab({
        Title = "Dashboard",
        Icon = "home",
        IconThemed = true
    })

    local MovTab = Window:Tab({
        Title = "Movement",
        Icon = "footprints"
    })

    local SurTab = Window:Tab({
        Title = "Survival",
        Icon = "shield"
    })

    local VisTab = Window:Tab({
        Title = "Visual ESP",
        Icon = "scan"
    })

    local ComTab = Window:Tab({
        Title = "Combat",
        Icon = "crosshair"
    })

    local NpcTab = Window:Tab({
        Title = "NPC Ctrl",
        Icon = "bot"
    })

    local FunTab = Window:Tab({
        Title = "Troll & Fun",
        Icon = "smile"
    })

    local SetTab = Window:Tab({
        Title = "Settings",
        Icon = "settings"
    })

    local DashSec = MainTab:Section({
        Title = "System Status"
    })

    DashSec:Paragraph({
        Title = "Engine Active",
        Desc = "Leviathan Hub loaded successfully."
    })
    
    MainTab:Viewport({
        Object = Instance.new("Part"),
        Interactive = true
    })
    
    local PerfPar = DashSec:Paragraph({
        Title = "Metrics",
        Desc = "Calculating..."
    })

    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
                local fps = math.floor(Workspace:GetRealPhysicsFPS())
                PerfPar:SetTitle("FPS: " .. tostring(fps) .. " | Ping: " .. tostring(ping) .. "ms")
            end)
        end
    end)

    local MovSec = MovTab:Section({
        Title = "Navigation"
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
        Title = "Teleport"
    })

    local TpGrp = TpSec:Group()

    TpGrp:Button({
        Title = "TP Center",
        Callback = function()
            local hrp = safeGetHRP()
            if hrp then
                hrp.CFrame = CFrame.new(0, 50, 0)
            end
        end
    })

    TpGrp:Button({
        Title = "TP Spawn",
        Callback = function()
            local sp = Workspace:FindFirstChildWhichIsA("SpawnLocation", true)
            local hrp = safeGetHRP()
            if hrp and sp then
                hrp.CFrame = sp.CFrame + Vector3.new(0, 5, 0)
            end
        end
    })

    local SurSec = SurTab:Section({
        Title = "Defense"
    })

    SurSec:Toggle({
        Title = "Anti Touch ( Patched )",
        Value = S.AntiTouch,
        Callback = function(v)
            S.AntiTouch = v
        end
    })

    SurSec:Toggle({
        Title = "ForceField ( Patched )",
        Value = S.ForceField,
        Callback = function(v)
            S.ForceField = v
        end
    })

    SurSec:Toggle({
        Title = "Invisible",
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
        Title = "Overlay"
    })

    local EspGrp1 = EspSec:Group()

    EspGrp1:Toggle({
        Title = "ESP Players",
        Value = S.EspPlayers,
        Callback = function(v)
            S.EspPlayers = v
        end
    })

    EspGrp1:Toggle({
        Title = "ESP Monsters",
        Value = S.EspMonsters,
        Callback = function(v)
            S.EspMonsters = v
        end
    })

    local EspGrp2 = EspSec:Group()

    EspGrp2:Toggle({
        Title = "ESP Boxes",
        Value = S.EspBox,
        Callback = function(v)
            S.EspBox = v
        end
    })

    EspGrp2:Toggle({
        Title = "ESP Names",
        Value = S.EspName,
        Callback = function(v)
            S.EspName = v
        end
    })

    EspGrp2:Toggle({
        Title = "ESP Distances",
        Value = S.EspDist,
        Callback = function(v)
            S.EspDist = v
        end
    })

    EspGrp2:Toggle({
        Title = "ESP Health",
        Value = S.EspHealth,
        Callback = function(v)
            S.EspHealth = v
        end
    })

    EspGrp2:Toggle({
        Title = "ESP Tracers",
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

    local AimSec = ComTab:Section({
        Title = "Aimbot"
    })

    AimSec:Toggle({
        Title = "Lock Target",
        Value = S.AimbotEnabled,
        Callback = function(v)
            S.AimbotEnabled = v
        end
    })

    AimSec:Toggle({
        Title = "Draw FOV",
        Value = S.ShowFOV,
        Callback = function(v)
            S.ShowFOV = v
        end
    })

    AimSec:Slider({
        Title = "FOV Radius",
        Step = 5,
        Value = {
            Min = 30,
            Max = 500,
            Default = S.FOVRadius
        },
        Callback = function(v)
            S.FOVRadius = v
        end
    })

    AimSec:Dropdown({
        Title = "Target Bone",
        Values = {"Head", "HumanoidRootPart"},
        Value = S.TargetBone,
        Callback = function(v)
            S.TargetBone = v
        end
    })
    
    local HitSec = ComTab:Section({
        Title = "Hitbox Expander"
    })

    HitSec:Toggle({
        Title = "Enable Expander",
        Value = S.HitboxEnabled,
        Callback = function(v)
            S.HitboxEnabled = v
        end
    })

    HitSec:Slider({
        Title = "Size Multiplier",
        Step = 1,
        Value = {
            Min = 2,
            Max = 60,
            Default = S.HitboxMultiplier
        },
        Callback = function(v)
            S.HitboxMultiplier = v
        end
    })

    HitSec:Dropdown({
        Title = "Hitbox Part",
        Values = {"Head", "HumanoidRootPart", "Torso"},
        Value = S.HitboxTarget,
        Callback = function(v)
            S.HitboxTarget = v
        end
    })

    local NpcSec = NpcTab:Section({
        Title = "NPC Manipulation"
    })

    NpcSec:Toggle({
        Title = "Freeze NPC",
        Desc = "freeze almost all npc",
        Value = S.FreezeEngine,
        Callback = function(v)
            S.FreezeEngine = v
        end
    })

    NpcSec:Dropdown({
        Title = "Freeze Mode",
        Desc = "Matrix or Void",
        Values = {"Matrix", "Void"},
        Value = S.FreezeMode,
        Callback = function(v)
            S.FreezeMode = v
        end
    })

    NpcSec:Toggle({
        Title = "Suppress Specials",
        Value = S.SuppressNPCs,
        Callback = function(v)
            S.SuppressNPCs = v
        end
    })
    
    local ToolSec = NpcTab:Section({
        Title = "Void Arsenal"
    })

    ToolSec:Button({
        Title = "Get Void Scythe",
        Callback = function()
            local tool = Instance.new("Tool")
            tool.Name = "Void Scythe"
            tool.RequiresHandle = true
            
            local handle = Instance.new("Part")
            handle.Parent = tool
            handle.Name = "Handle"
            handle.Size = Vector3.new(1, 5, 1)
            handle.Massless = true
            
            local mesh = Instance.new("SpecialMesh")
            mesh.Parent = handle
            mesh.MeshId = "rbxassetid://14349160130"
            mesh.Scale = Vector3.new(0.04, 0.04, 0.04)
            
            tool.Parent = LocalPlayer.Backpack
            local slashing = false
            
            tool.Activated:Connect(function()
                if slashing then
                    return
                end
                
                slashing = true
                
                pcall(function()
                    local anim = Instance.new("Animation")
                    anim.AnimationId = S.ScytheAnim
                    local hum = safeGetHumanoid()
                    if hum then
                        hum:LoadAnimation(anim):Play()
                    end
                end)
                
                local mPos = Mouse.Hit.Position
                
                for npc, _ in pairs(_G.ActiveNPCs or {}) do
                    if npc and npc:FindFirstChild("HumanoidRootPart") then
                        local dist = (npc.HumanoidRootPart.Position - mPos).Magnitude
                        if dist <= 30 then
                            pcall(function()
                                npc:BreakJoints()
                                for _, p in ipairs(npc:GetDescendants()) do
                                    if p:IsA("BasePart") then
                                        p.Velocity = Vector3.new(0, -1000, 0)
                                        p.CFrame = p.CFrame * CFrame.new(0, -800, 0)
                                    end
                                end
                            end)
                        end
                    end
                end
                
                task.wait(0.3)
                slashing = false
            end)
        end
    })

    ToolSec:Toggle({
        Title = "Kill Aura ( Patched )",
        Value = S.KillAura,
        Callback = function(v)
            S.KillAura = v
        end
    })

    local TrollSec = FunTab:Section({
        Title = "Disruption"
    })

    TrollSec:Input({
        Title = "Victim Name ( Patched )",
        Value = S.ChaseVictim,
        Callback = function(v)
            S.ChaseVictim = v
        end
    })

    TrollSec:Toggle({
        Title = "Chase Victim ( Patched )",
        Value = S.ChaseActive,
        Callback = function(v)
            S.ChaseActive = v
        end
    })

    TrollSec:Toggle({
        Title = "Chat Spam",
        Value = S.ChatSpam,
        Callback = function(v)
            S.ChatSpam = v
        end
    })

    TrollSec:Input({
        Title = "Spam Message",
        Value = S.SpamMsg,
        Callback = function(v)
            S.SpamMsg = v
        end
    })

    TrollSec:Toggle({
        Title = "Glitch Stance",
        Value = S.GlitchStance,
        Callback = function(v)
            S.GlitchStance = v
        end
    })

    TrollSec:Toggle({
        Title = "Aura Fling",
        Value = S.FlingActive,
        Callback = function(v)
            S.FlingActive = v
            if not v then
                local hrp = safeGetHRP()
                if hrp then
                    local force = hrp:FindFirstChild("FlingForce")
                    if force then
                        force:Destroy()
                    end
                end
            end
        end
    })

    local WldSec = FunTab:Section({
        Title = "World Control"
    })

    WldSec:Toggle({
        Title = "Disco Sky",
        Value = S.DiscoSky,
        Callback = function(v)
            S.DiscoSky = v
            if not v then
                Lighting.Ambient = Color3.fromRGB(128, 128, 128)
            end
        end
    })

    WldSec:Toggle({
        Title = "Low Gravity",
        Value = S.LowGravity,
        Callback = function(v)
            S.LowGravity = v
            if v then
                Workspace.Gravity = 40
            else
                Workspace.Gravity = 196.2
            end
        end
    })

    WldSec:Slider({
        Title = "Time Speed",
        Step = 0.5,
        Value = {
            Min = 1,
            Max = 10,
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
        end
    })

    local UtilSec = SetTab:Section({
        Title = "Client Utils"
    })

    UtilSec:Toggle({
        Title = "Anti AFK",
        Value = S.AntiAFK,
        Callback = function(v)
            S.AntiAFK = v
        end
    })

    UtilSec:Toggle({
        Title = "Fullbright",
        Value = S.Fullbright,
        Callback = function(v)
            S.Fullbright = v
            if v then
                Lighting.Ambient = Color3.new(1, 1, 1)
                Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
            else
                Lighting.Ambient = Color3.fromRGB(128, 128, 128)
                Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
            end
        end
    })

    UtilSec:Toggle({
        Title = "No Fog",
        Value = S.NoFog,
        Callback = function(v)
            S.NoFog = v
            if v then
                Lighting.FogEnd = 9e9
            else
                Lighting.FogEnd = 100000
            end
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
        Title = "Select Theme",
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
        Title = "Acrylic Glass",
        Value = S.Acrylic,
        Callback = function(v)
            S.Acrylic = v
        end
    })
    
    local CfgGrp = CfgSec:Group()

    CfgGrp:Button({
        Title = "Rejoin",
        Callback = function()
            local playerCount = #Players:GetPlayers()
            if playerCount <= 1 then
                TeleportService:Teleport(game.PlaceId, LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
            end
        end
    })

    CfgGrp:Button({
        Title = "Server Hop",
        Callback = function()
            local url = "https://games.roblox.com/v1/games/" .. tostring(game.PlaceId) .. "/servers/Public?sortOrder=Asc&limit=100"
            local success, result = pcall(function()
                return game:HttpGet(url)
            end)
            if success then
                local data = HttpService:JSONDecode(result)
                if data and data.data then
                    local servers = {}
                    for _, server in ipairs(data.data) do
                        if server.playing < server.maxPlayers and server.id ~= game.JobId then
                            table.insert(servers, server.id)
                        end
                    end
                    if #servers > 0 then
                        local randomServer = servers[math.random(1, #servers)]
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, randomServer, LocalPlayer)
                    end
                end
            end
        end
    })
end

_G.ActiveNPCs = {}
_G.CachedCFrames = {}

local function scanNPC(obj)
    if obj:IsA("Model") then
        local hrp = obj:FindFirstChild("HumanoidRootPart")
        if hrp then
            local isPlayer = Players:GetPlayerFromCharacter(obj)
            if not isPlayer then
                _G.ActiveNPCs[obj] = true
                if S.FreezeEngine then
                    if not _G.CachedCFrames[obj] then
                        _G.CachedCFrames[obj] = hrp.CFrame
                    end
                end
            end
        end
    end
end

for _, v in ipairs(Workspace:GetDescendants()) do
    scanNPC(v)
end

Workspace.DescendantAdded:Connect(function(v)
    if v:IsA("Model") then
        task.delay(0.1, function()
            scanNPC(v)
        end)
    end
end)

local function executeFreeze()
    if not S.FreezeEngine then
        return
    end
    
    pcall(function()
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
    end)
    
    for npc, _ in pairs(_G.ActiveNPCs) do
        if npc and npc.Parent then
            local hrp = npc:FindFirstChild("HumanoidRootPart")
            if hrp then
                pcall(function()
                    if hrp:GetNetworkOwner() ~= LocalPlayer then
                        hrp:SetNetworkOwner(LocalPlayer)
                    end
                end)
                
                if not _G.CachedCFrames[npc] then
                    _G.CachedCFrames[npc] = hrp.CFrame
                end
                
                if S.SuppressNPCs then
                    local nameLow = npc.Name:lower()
                    if nameLow:find("face") or nameLow:find("sad") or nameLow:find("scare") then
                        local hum = npc:FindFirstChildOfClass("Humanoid")
                        if hum then
                            hum.PlatformStand = true
                        end
                        for _, p in ipairs(npc:GetDescendants()) do
                            if p:IsA("BasePart") then
                                pcall(function()
                                    p.Size = Vector3.new(0.01, 0.01, 0.01)
                                end)
                            end
                        end
                    end
                end

                if S.FreezeMode == "Void" then
                    hrp.CFrame = CFrame.new(hrp.Position.X, -9999, hrp.Position.Z)
                    hrp.Anchored = true
                elseif S.FreezeMode == "Matrix" then
                    hrp.Anchored = false
                    hrp.CFrame = _G.CachedCFrames[npc]
                    hrp.AssemblyLinearVelocity = Vector3.zero
                    hrp.AssemblyAngularVelocity = Vector3.zero
                    for _, p in ipairs(npc:GetDescendants()) do
                        if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                            p.CanCollide = false
                            p.Massless = true
                        end
                    end
                end
            end
        end
    end
end

RunService.Stepped:Connect(executeFreeze)
RunService.Heartbeat:Connect(executeFreeze)

local flyBV = nil
local flyBG = nil

RunService.Heartbeat:Connect(function()
    local hrp = safeGetHRP()
    if hrp and S.Fly then
        if not flyBV then
            flyBV = Instance.new("BodyVelocity")
            flyBV.Parent = hrp
            flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        end
        if not flyBG then
            flyBG = Instance.new("BodyGyro")
            flyBG.Parent = hrp
            flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
            flyBG.D = 50
        end
        
        local d = Vector3.zero
        local cf = CurrentCamera.CFrame
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            d = d + cf.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            d = d - cf.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            d = d - cf.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            d = d + cf.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            d = d + Vector3.yAxis
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            d = d - Vector3.yAxis
        end
        
        if d.Magnitude > 0 then
            flyBV.Velocity = d.Unit * S.FlySpeed
        else
            flyBV.Velocity = Vector3.zero
        end
        
        flyBG.CFrame = cf
    else
        if flyBV then
            flyBV:Destroy()
            flyBV = nil
        end
        if flyBG then
            flyBG:Destroy()
            flyBG = nil
        end
    end
end)

RunService.Stepped:Connect(function()
    local char = LocalPlayer.Character
    if not char then
        return
    end
    
    if S.Noclip then
        for _, p in ipairs(char:GetDescendants()) do
            if p:IsA("BasePart") then
                p.CanCollide = false
            end
        end
    end
    
    if S.SpinBot then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(S.SpinSpeed), 0)
        end
    end
    
    if S.Bhop then
        local hum = char:FindFirstChildOfClass("Humanoid")
        if hum then
            if hum.FloorMaterial ~= Enum.Material.Air then
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end
    end
    
    if S.GlitchStance then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local rY = math.random(-2, 2) / 10
            local rP = math.rad(math.random(-10, 10))
            hrp.CFrame = hrp.CFrame * CFrame.new(0, rY, 0) * CFrame.Angles(rP, 0, 0)
        end
    end
    
    if S.FlingActive then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local force = hrp:FindFirstChild("FlingForce")
            if not force then
                force = Instance.new("BodyAngularVelocity")
                force.Name = "FlingForce"
                force.Parent = hrp
                force.MaxTorque = Vector3.new(1e7, 1e7, 1e7)
                force.AngularVelocity = Vector3.new(0, 99999, 0)
            end
            hrp.Velocity = Vector3.new(99, 99, 99)
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then
                    p.CanCollide = false
                end
            end
        end
    end
end)

local cFF = nil

task.spawn(function()
    while task.wait(0.1) do
        local c = LocalPlayer.Character
        if S.ForceField and c then
            local field = c:FindFirstChildOfClass("ForceField")
            if not field then
                cFF = Instance.new("ForceField")
                cFF.Parent = c
                cFF.Visible = true
            end
        else
            if cFF then
                cFF:Destroy()
                cFF = nil
            end
            if c then
                local field = c:FindFirstChildOfClass("ForceField")
                if field then
                    field:Destroy()
                end
            end
        end
        
        if S.AntiTouch then
            for _, obj in ipairs(Workspace:GetDescendants()) do
                if obj:IsA("Model") and obj ~= LocalPlayer.Character then
                    local isPlayer = Players:GetPlayerFromCharacter(obj)
                    if not isPlayer then
                        for _, p in ipairs(obj:GetDescendants()) do
                            if p:IsA("BasePart") and p.CanTouch then
                                p.CanTouch = false
                            end
                        end
                    end
                end
            end
        end
        
        if S.GhostMode and c then
            for _, p in ipairs(c:GetDescendants()) do
                if p:IsA("BasePart") and p.Name ~= "HumanoidRootPart" then
                    p.Transparency = 1
                elseif p:IsA("Decal") then
                    p.Transparency = 1
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(0.05) do
        if S.ChaseActive and S.ChaseVictim ~= "" then
            local target = nil
            local search = S.ChaseVictim:lower()
            
            for _, pl in pairs(Players:GetPlayers()) do
                if pl ~= LocalPlayer then
                    local nameLow = pl.Name:lower()
                    local displayLow = pl.DisplayName:lower()
                    if nameLow:find(search) or displayLow:find(search) then
                        target = pl
                        break
                    end
                end
            end
            
            if target and target.Character then
                local tHrp = target.Character:FindFirstChild("HumanoidRootPart")
                if tHrp then
                    for npc, _ in pairs(_G.ActiveNPCs) do
                        if npc and npc.Parent then
                            local nHrp = npc:FindFirstChild("HumanoidRootPart")
                            if nHrp then
                                local rX = math.random(-2, 2)
                                local rZ = math.random(-2, 2)
                                nHrp.CFrame = tHrp.CFrame + Vector3.new(rX, 0, rZ)
                            end
                        end
                    end
                end
            end
        end
        
        if S.KillAura then
            local myHRP = safeGetHRP()
            if myHRP then
                for npc, _ in pairs(_G.ActiveNPCs) do
                    local hrp = npc:FindFirstChild("HumanoidRootPart")
                    local hum = npc:FindFirstChildOfClass("Humanoid")
                    if hrp and hum then
                        if hum.Health > 0 then
                            local dist = (myHRP.Position - hrp.Position).Magnitude
                            if dist <= S.AuraRange then
                                pcall(function()
                                    npc:BreakJoints()
                                    hum.Health = 0
                                    hrp.CFrame = CFrame.new(0, -9999, 0)
                                end)
                            end
                        end
                    end
                end
            end
        end
    end
end)

task.spawn(function()
    while task.wait(S.SpamDelay) do
        if S.ChatSpam then
            pcall(function()
                local rep = game:GetService("ReplicatedStorage")
                local ev = rep.DefaultChatSystemChatEvents.SayMessageRequest
                ev:FireServer(S.SpamMsg, "All")
            end)
        end
    end
end)

task.spawn(function()
    while task.wait(0.1) do
        if S.DiscoSky then
            local r1 = math.random(0, 255)
            local g1 = math.random(0, 255)
            local b1 = math.random(0, 255)
            local color = Color3.fromRGB(r1, g1, b1)
            Lighting.Ambient = color
            Lighting.OutdoorAmbient = color
        end
        if S.TimeSpeed ~= 1 then
            Lighting.ClockTime = Lighting.ClockTime + (0.01 * S.TimeSpeed)
        else
            Lighting.ClockTime = S.DayTime
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if not S.HitboxEnabled then
        return
    end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local part = p.Character:FindFirstChild(S.HitboxTarget)
            if part and part:IsA("BasePart") then
                part.Size = Vector3.new(S.HitboxMultiplier, S.HitboxMultiplier, S.HitboxMultiplier)
                part.Transparency = S.HitboxTransparency
                part.CanCollide = false
            end
        end
    end
end)

local fovCircle = Drawing.new("Circle")
fovCircle.Visible = false
fovCircle.Color = Color3.fromRGB(255, 255, 255)
fovCircle.Thickness = 1.5

local holdingM2 = false

UserInputService.InputBegan:Connect(function(input, proc)
    if not proc then
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            holdingM2 = true
        end
    end
end)

UserInputService.InputEnded:Connect(function(input, proc)
    if not proc then
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            holdingM2 = false
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if S.ShowFOV then
        fovCircle.Position = UserInputService:GetMouseLocation()
        fovCircle.Radius = S.FOVRadius
        fovCircle.Visible = true
    else
        fovCircle.Visible = false
    end
    
    if S.AimbotEnabled and holdingM2 then
        local target = nil
        local maxDist = S.FOVRadius
        local mousePos = UserInputService:GetMouseLocation()
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then
                local bone = p.Character:FindFirstChild(S.TargetBone)
                local hum = p.Character:FindFirstChildOfClass("Humanoid")
                
                if bone and hum and hum.Health > 0 then
                    local screenPos, onScreen = CurrentCamera:WorldToViewportPoint(bone.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                        if dist < maxDist then
                            maxDist = dist
                            target = bone
                        end
                    end
                end
            end
        end
        
        if target then
            local cPos = CurrentCamera.CFrame.Position
            local tPos = target.Position
            local aimCFrame = CFrame.new(cPos, tPos)
            CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(aimCFrame, S.Smoothness)
        end
    end
end)

LocalPlayer.Idled:Connect(function()
    if S.AntiAFK then
        local pos = Vector2.zero
        local cf = CurrentCamera.CFrame
        VirtualUser:Button2Down(pos, cf)
        task.wait(0.2)
        VirtualUser:Button2Up(pos, cf)
    end
end)

RebuildInterface()
print("Succesful Loaded Assets")
game:GetService("StarterGui"):SetCore("SendNotification",
    { Title = "Leviathan Loader",
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

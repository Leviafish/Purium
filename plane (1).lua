-- ============================================================
--  Build A Plane | KaitoFyp  —  v3.0  by Leviathan
--  UI: WindUI
-- ============================================================

local WindUI = loadstring(game:HttpGet("https://github.com/Leviafish/Library-Test/releases/download/wel/main.lua"))()

local Window = WindUI:CreateWindow({
    Title         = "Build A Plane | KaitoFyp",
    Icon          = "plane",
    Author        = "v3.0",
    Folder        = "BuildAPlane_KaitoFyp",
    Size          = UDim2.fromOffset(580, 460),
    MinSize       = Vector2.new(560, 350),
    MaxSize       = Vector2.new(850, 560),
    Transparent   = true,
    Theme         = "Dark",
    Resizable     = true,
    SideBarWidth  = 200,
    HideSearchBar = true,
})

Window:EditOpenButton({ Title = "BAP", Icon = "plane", Enabled = true, Draggable = true })

-- ── Services ─────────────────────────────────────────────────
local Players         = game:GetService("Players")
local RunService      = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser     = game:GetService("VirtualUser")
local GuiService      = game:GetService("GuiService")
local CoreGui         = game:GetService("CoreGui")
local Lighting        = game:GetService("Lighting")
local LP              = Players.LocalPlayer

-- ── Remotes ──────────────────────────────────────────────────
local RemoteFolder = game:GetService("ReplicatedStorage"):WaitForChild("Remotes", 5)
local LaunchEvents = RemoteFolder and RemoteFolder:WaitForChild("LaunchEvents", 5)
local LaunchRemote = LaunchEvents and LaunchEvents:WaitForChild("Launch", 5)
local ReturnRemote = LaunchEvents and LaunchEvents:WaitForChild("Return", 5)

-- ── State ────────────────────────────────────────────────────
_G.BAPActive   = false
_G.FarmLoop    = nil    -- Heartbeat conn for cash farm velocity
_G.DistLoop    = nil    -- Heartbeat conn for distance farm
_G.FlyLoop     = nil    -- RenderStepped conn for manual fly
_G.RejoinConn  = nil

local farmSpeed    = 500
local distSpeed    = 50000
local flySpeed     = 50
local cashTarget   = 500
local selectedDist      = 1000
local origCamType       = nil   -- saved camera state for NoRender
local noRenderAutoActive = false -- true only when farm auto-enabled it

-- ── Helpers ──────────────────────────────────────────────────
local function getSeat()
    local char = LP.Character; if not char then return nil end
    local hum  = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.SeatPart or nil
end

local function getHRP()
    local char = LP.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function getCash()
    local pg   = LP:FindFirstChild("PlayerGui");         if not pg   then return 0 end
    local main = pg:FindFirstChild("Main");              if not main then return 0 end
    local ec   = main:FindFirstChild("EarnedCash");      if not ec   then return 0 end
    local tot  = ec:FindFirstChild("Total");             if not tot  then return 0 end
    local raw  = tot.ContentText or tot.Text or "0"
    return tonumber(tostring(raw):match("%d+")) or 0
end

local function setFPS(boost)
    pcall(function()
        settings().Rendering.QualityLevel =
            boost and Enum.QualityLevel.Level01 or Enum.QualityLevel.Automatic
    end)
    pcall(function() Lighting.GlobalShadows = not boost end)
end

-- Shared NoRender enable/disable — safe to call from farm or manual toggle
local function setNoRender(enabled)
    local cam = workspace.CurrentCamera
    if enabled and not origCamType then
        origCamType    = cam.CameraType
        cam.CameraType = Enum.CameraType.Scriptable
        cam.CFrame     = CFrame.new(0, -99999, 0)
    elseif not enabled and origCamType then
        cam.CameraType = origCamType
        origCamType    = nil
    end
end

local function stopFarmLoops()
    if _G.FarmLoop then _G.FarmLoop:Disconnect(); _G.FarmLoop = nil end
    if _G.DistLoop then _G.DistLoop:Disconnect(); _G.DistLoop = nil end
end

-- ── Anti-AFK (always on) ─────────────────────────────────────
LP.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new(0, 0))
end)

-- ── Tabs ─────────────────────────────────────────────────────
local MainTab     = Window:Tab({ Title = "Main",      Icon = "home"     })
local OPTab       = Window:Tab({ Title = "OP",        Icon = "zap"      })
local TeleTab     = Window:Tab({ Title = "Teleports", Icon = "map-pin"  })
local SettingsTab = Window:Tab({ Title = "Settings",  Icon = "settings" })

-- ============================================================
--  MAIN TAB — Cash Farm & Distance Farm
-- ============================================================
local FarmSec = MainTab:Section({ Title = "Cash Farm", Icon = "dollar-sign", Opened = true, Box = true })

FarmSec:Slider({
    Title = "Farm Speed",   Desc = "Plane velocity",
    Step = 50, Flag = "FarmSpeed",
    Value = { Min = 50, Max = 900, Default = 500 },
    Callback = function(v) farmSpeed = v end,
})
FarmSec:Slider({
    Title = "Cash Target",  Desc = "Cash per run before return",
    Step = 50, Flag = "CashTarget",
    Value = { Min = 50, Max = 3000, Default = 500 },
    Callback = function(v) cashTarget = v end,
})
FarmSec:Toggle({
    Title = "Auto Farm",    Desc = "Launch → earn → return, repeat",
    Flag = "AutoFarm", Value = false,
    Callback = function(enabled)
        _G.BAPActive = enabled
        stopFarmLoops()
        if not enabled then
            setFPS(false)
            -- Only restore camera if farm was the one that hid it
            if noRenderAutoActive then
                setNoRender(false)
                noRenderAutoActive = false
            end
            return
        end

        setFPS(true)
        -- Auto-enable NoRender for performance; track so we can restore it
        if not origCamType then
            setNoRender(true)
            noRenderAutoActive = true
        end

        task.spawn(function()
            while _G.BAPActive do
                pcall(function()
                    if LaunchRemote then LaunchRemote:FireServer() end
                    task.wait(1)

                    local seat = getSeat()
                    if not seat or not seat:IsA("VehicleSeat") then task.wait(2); return end

                    seat.CFrame                  = CFrame.new(seat.Position.X + 50, 500, -325)
                    seat.AssemblyAngularVelocity = Vector3.zero

                    local startCash = getCash()
                    local startTime = os.clock()

                    -- Push velocity every frame via Heartbeat
                    _G.FarmLoop = RunService.Heartbeat:Connect(function()
                        local s = getSeat()
                        if s then s.AssemblyLinearVelocity = Vector3.new(farmSpeed, 0, 0) end
                    end)

                    -- Wait for cash target or 25s timeout
                    repeat task.wait(0.15) until
                        not _G.BAPActive
                        or (getCash() - startCash) >= cashTarget
                        or (os.clock() - startTime)  >= 25

                    if _G.FarmLoop then _G.FarmLoop:Disconnect(); _G.FarmLoop = nil end
                    if ReturnRemote then ReturnRemote:FireServer() end
                    task.wait(2.5)
                end)
            end
            setFPS(false)
        end)
    end,
})

MainTab:Space()
local DistSec = MainTab:Section({ Title = "Distance Farm", Icon = "trending-up", Opened = true, Box = true })

DistSec:Slider({
    Title = "Burst Speed",  Desc = "Velocity per Heartbeat burst",
    Step = 5000, Flag = "DistSpeed",
    Value = { Min = 5000, Max = 100000, Default = 50000 },
    Callback = function(v) distSpeed = v end,
})
DistSec:Toggle({
    Title = "Distance Farm", Desc = "Max-speed burst teleports every frame",
    Flag = "DistFarm", Value = false,
    Callback = function(enabled)
        _G.BAPActive = enabled
        stopFarmLoops()
        if not enabled then setFPS(false); return end

        setFPS(true)

        task.spawn(function()
            if LaunchRemote then LaunchRemote:FireServer() end
            task.wait(1)

            -- Teleport seat forward every Heartbeat frame
            _G.DistLoop = RunService.Heartbeat:Connect(function()
                if not _G.BAPActive then
                    _G.DistLoop:Disconnect(); _G.DistLoop = nil
                    setFPS(false); return
                end
                local seat = getSeat(); if not seat then return end
                seat.CFrame                  = CFrame.new(seat.Position.X + 500, 500, -325)
                seat.AssemblyLinearVelocity  = Vector3.new(distSpeed, 0, 0)
                seat.AssemblyAngularVelocity = Vector3.zero
            end)
        end)
    end,
})

MainTab:Space()
local StatusSec = MainTab:Section({ Title = "Status", Icon = "activity", Opened = true, Box = true })
StatusSec:Paragraph({ Title = "✅ Anti-AFK", Desc = "Always active." })

-- ============================================================
--  OP TAB — Manual Fly, FPS, NoRender, Auto Rejoin
-- ============================================================
local FlySec = OPTab:Section({ Title = "Manual Fly", Icon = "navigation", Opened = true, Box = true })

FlySec:Slider({
    Title = "Fly Speed",    Desc = "Camera-relative fly speed",
    Step = 10, Flag = "FlySpeed",
    Value = { Min = 10, Max = 500, Default = 50 },
    Callback = function(v) flySpeed = v end,
})
FlySec:Toggle({
    Title = "Enable Manual Fly", Desc = "Fly plane with throttle + camera dir",
    Flag = "ManualFly", Value = false,
    Callback = function(enabled)
        if _G.FlyLoop then _G.FlyLoop:Disconnect(); _G.FlyLoop = nil end
        if not enabled then return end

        _G.FlyLoop = RunService.RenderStepped:Connect(function()
            local seat = getSeat()
            if not seat or not seat:IsA("VehicleSeat") then return end
            local cam      = workspace.CurrentCamera
            local throttle = seat.ThrottleFloat
            local steer    = seat.SteerFloat
            local dir      = (cam.CFrame.LookVector * throttle) + (cam.CFrame.RightVector * steer)
            if dir.Magnitude > 0.01 then
                seat.AssemblyLinearVelocity = dir.Unit * flySpeed
            end
        end)
    end,
})

OPTab:Space()
local PerfSec = OPTab:Section({ Title = "Performance", Icon = "cpu", Opened = true, Box = true })

PerfSec:Toggle({
    Title = "FPS Booster",   Desc = "Min render quality + disable shadows",
    Flag = "FPSBooster", Value = false,
    Callback = function(v) setFPS(v) end,
})

PerfSec:Toggle({
    Title = "No Render Mode", Desc = "Hides 3D world, UI stays visible. Auto-on during cash farm.",
    Flag = "NoRender", Value = false,
    Callback = function(enabled)
        noRenderAutoActive = false  -- manual override clears auto flag
        setNoRender(enabled)
    end,
})

OPTab:Space()
local RejoinSec = OPTab:Section({ Title = "Auto Rejoin", Icon = "wifi", Opened = true, Box = true })

RejoinSec:Toggle({
    Title = "Auto Rejoin",   Desc = "Rejoin on disconnect or kick",
    Flag = "AutoRejoin", Value = false,
    Callback = function(enabled)
        if _G.RejoinConn then _G.RejoinConn:Disconnect(); _G.RejoinConn = nil end
        if not enabled then return end

        -- Detect kick via GUI error message
        _G.RejoinConn = GuiService.ErrorMessageChanged:Connect(function()
            task.wait(0.5)
            pcall(function()
                if #Players:GetPlayers() <= 1 then
                    TeleportService:Teleport(game.PlaceId, LP)
                else
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LP)
                end
            end)
        end)

        -- Fallback: detect self-removal
        Players.PlayerRemoving:Connect(function(p)
            if p ~= LP then return end
            task.wait(0.3)
            pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
        end)
    end,
})

-- ============================================================
--  TELEPORTS TAB
-- ============================================================
local TeleSec = TeleTab:Section({ Title = "Milestones", Icon = "flag", Opened = true, Box = true })

local distanceMap = {
    ["1K"]   = 1000,    ["5K"]   = 5000,    ["10K"]  = 10000,
    ["25K"]  = 25000,   ["50K"]  = 50000,   ["100K"] = 100000,
    ["250K"] = 250000,  ["500K"] = 500000,  ["1M"]   = 1000000,
    ["5M"]   = 5000000,
}
TeleSec:Dropdown({
    Title = "Target",    Desc = "Pick a distance milestone",
    Flag = "DistDrop",
    Values = { "1K","5K","10K","25K","50K","100K","250K","500K","1M","5M" },
    Value = "1K",
    Callback = function(v) selectedDist = distanceMap[v] or 1000 end,
})
TeleSec:Button({
    Title = "Teleport",  Desc = "Go to selected milestone now",
    Callback = function()
        pcall(function()
            local hrp = getHRP(); if not hrp then return end
            hrp.CFrame                 = CFrame.new(selectedDist, 500, -325)
            hrp.AssemblyLinearVelocity = Vector3.zero
        end)
    end,
})

TeleTab:Space()
local UtilSec = TeleTab:Section({ Title = "Utilities", Icon = "refresh-cw", Opened = true, Box = true })

UtilSec:Button({
    Title = "Back to Base",  Desc = "Teleport to spawn plot",
    Callback = function()
        pcall(function()
            local hrp = getHRP(); if not hrp then return end
            hrp.CFrame = CFrame.new(30, 50, -325)
        end)
    end,
})
UtilSec:Button({
    Title = "Rejoin Server", Desc = "Manual rejoin",
    Callback = function()
        pcall(function() TeleportService:Teleport(game.PlaceId, LP) end)
    end,
})

-- ============================================================
--  SETTINGS TAB — Themes, Keybind, Config
-- ============================================================
local ThemeSec    = SettingsTab:Section({ Title = "Appearance", Icon = "palette", Opened = true, Box = true })
local validThemes = WindUI:GetThemes()
local themeList   = {}
for n in pairs(validThemes) do table.insert(themeList, n) end
table.sort(themeList)

ThemeSec:Dropdown({
    Title = "Theme",     Flag = "ThemeDrop",
    Values = themeList,  Value = "Dark",
    Callback = function(v)
        if validThemes[v] then pcall(function() WindUI:SetTheme(v) end) end
    end,
})
ThemeSec:Keybind({
    Title = "Toggle UI", Desc = "Key to show/hide",
    Flag = "UIKeybind",  Value = "G",
    Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end,
})

SettingsTab:Space()

-- ── Config Manager ────────────────────────────────────────────
local autoLoadPath = "BuildAPlane_KaitoFyp/AutoLoad.json"
local function getAutoLoad()
    local ok, r = pcall(function() return isfile(autoLoadPath) and readfile(autoLoadPath) end)
    return (ok and r) or "none"
end
local function setAutoLoad(name)
    pcall(function()
        if not isfolder("BuildAPlane_KaitoFyp") then makefolder("BuildAPlane_KaitoFyp") end
        writefile(autoLoadPath, name)
    end)
end

local CM         = Window.ConfigManager
local configName = "MainConfig"
local configFile = CM:CreateConfig(configName)
local savedCfgs  = CM:AllConfigs()
if #savedCfgs == 0 then table.insert(savedCfgs, "MainConfig") end

local ConfigSec  = SettingsTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local CfgInput   = ConfigSec:Input({
    Title = "Config Name", Value = configName,
    Callback = function(v) configName = v or "MainConfig" end,
})

local ALToggle
local CfgDrop = ConfigSec:Dropdown({
    Title = "Saved Configs", Values = savedCfgs, Value = configName, AllowNone = false,
    Callback = function(v)
        configName = v or "MainConfig"
        CfgInput:Set(configName)
        if ALToggle then ALToggle:Set(getAutoLoad() == configName) end
    end,
})

ALToggle = ConfigSec:Toggle({
    Title = "Auto-Load on Start", Desc = "Load this config each time",
    Value = getAutoLoad() == configName,
    Callback = function(v) if v then setAutoLoad(configName) else setAutoLoad("none") end end,
})
ConfigSec:Button({
    Title = "Save",  Icon = "check",
    Callback = function()
        configFile = CM:CreateConfig(configName)
        if configFile:Save() then
            local list = CM:AllConfigs()
            if #list == 0 then table.insert(list, "MainConfig") end
            CfgDrop:Refresh(list)
            WindUI:Notify({ Title = "Saved", Content = configName, Duration = 2 })
        end
    end,
})
ConfigSec:Button({
    Title = "Load",  Icon = "refresh-cw",
    Callback = function()
        configFile = CM:CreateConfig(configName)
        if configFile:Load() then
            WindUI:Notify({ Title = "Loaded", Content = configName, Duration = 2 })
        end
    end,
})

Window:OnClose(function() if CM and configFile then configFile:Save() end end)

-- ── Startup ──────────────────────────────────────────────────
task.spawn(function()
    task.wait(1)
    local ac = getAutoLoad()
    if ac ~= "none" then
        configName = ac
        configFile = CM:CreateConfig(configName)
        pcall(function()
            configFile:Load()
            WindUI:Notify({ Title = "Auto-Loaded", Content = configName, Duration = 2 })
        end)
    end
    task.wait(0.3)
    pcall(function() Window:Minimize() end)
    WindUI:Notify({ Title = "BAP v3.0 Ready", Content = "Press G to open UI.", Duration = 3 })
end)

print("[BAP v3.0] Loaded.")

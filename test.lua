-- ==========================================================
-- PART 1: WIND UI SETUP, NOTIFICATIONS & MOVEMENT
-- ==========================================================
print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Script...", Duration = 3 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Chain |", Icon = "door-open", Author = "Version : 0.0.3", Folder = "Purium_SBSD",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})
task.spawn(function()
    task.wait(1)
    pcall(function()
        Window:Dialog({
            Title = "Welcome To Purium Script!!",
            Content = "Thanks you guys for using my script!",
            Buttons = {
                { Title = "I Don't Care", Callback = function() end },
                { Title = "Good Boy~", Callback = function() end, Variant = "Primary" }
            }
        })
    end)
end)
Window:EditOpenButton({
    Title = "Open Ui",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- ĐÃ ĐỔI SANG GRADIENT TRẮNG ĐEN
        Color3.fromHex("FFFFFF"), 
        Color3.fromHex("000000")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

Window:Tag({ Title = "v1.6.6", Icon = "github", Color = Color3.fromRGB(48, 255, 106), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local NotifyTab = Window:Tab({ Title = "Notifications", Icon = "bell" })
local MainTab = Window:Tab({ Title = "Main & Movement", Icon = "castle" })
local VisualsTab = Window:Tab({ Title = "Visuals & ESP", Icon = "eye" })
local CharTab = Window:Tab({ Title = "Character & Combat", Icon = "user" })
local TpTab = Window:Tab({ Title = "Teleports", Icon = "map-pin" })
local MiscTab = Window:Tab({ Title = "World & Items", Icon = "cog" })
local FarmTab = Window:Tab({ Title = "AutoFarm", Icon = "feather" })
local ServerTab = Window:Tab({ Title = "Servers", Icon = "server" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local NotifSec = NotifyTab:Section({ Title = "Smart Notifications", Icon = "bell", Opened = true, Box = true })
local notifSet = { power = true, roundTime = true, chain = true, artifact = true, airdrop = true }

NotifSec:Toggle({ Title = "Low Power (30%)", Value = true, Callback = function(v) notifSet.power = v end })
NotifSec:Toggle({ Title = "End of Round (30s)", Value = true, Callback = function(v) notifSet.roundTime = v end })
NotifSec:Toggle({ Title = "CHAIN Spawn / Defeat", Value = true, Callback = function(v) notifSet.chain = v end })
NotifSec:Toggle({ Title = "Artifact Spawn", Value = true, Callback = function(v) notifSet.artifact = v end })
NotifSec:Toggle({ Title = "Airdrop Spawn", Value = true, Callback = function(v) notifSet.airdrop = v end })

local function playSound() pcall(function() local s = Instance.new("Sound", Workspace); s.SoundId = "rbxassetid://15544478080"; s.Volume = 5; s:Play(); game:GetService("Debris"):AddItem(s, 3) end) end

task.spawn(function()
    local valFolder = Workspace:WaitForChild("GameStuff", 5) and Workspace.GameStuff:WaitForChild("Values", 5)
    if valFolder then
        local pN, rN = false, false
        valFolder:GetAttributeChangedSignal("Power"):Connect(function() local v = valFolder:GetAttribute("Power"); if type(v)=="number" and v<=30 and notifSet.power and not pN then pN=true; playSound(); WindUI:Notify({Title="Low Power!", Content="30% power remaining.", Duration=5}) elseif type(v)=="number" and v>30 then pN=false end end)
        valFolder:GetAttributeChangedSignal("RoundTime"):Connect(function() local v = valFolder:GetAttribute("RoundTime"); if type(v)=="number" and v<=30 and notifSet.roundTime and not rN then rN=true; playSound(); WindUI:Notify({Title="Round Ending!", Content="30 seconds remaining!", Duration=5}) elseif type(v)=="number" and v>30 then rN=false end end)
    end
end)

task.spawn(function()
    local aiFolder = Workspace:WaitForChild("Misc", 5) and Workspace.Misc:WaitForChild("AI", 5)
    if not aiFolder then return end
    local chainActive = false
    while task.wait(2) do
        if notifSet.chain then
            local chain = aiFolder:FindFirstChild("CHAIN")
            local isAlive = chain and chain:FindFirstChild("Humanoid") and chain.Humanoid.Health > 0
            if isAlive and not chainActive then chainActive = true; playSound(); WindUI:Notify({Title="‼️ CHAIN SPAWNED ‼️", Content="The main enemy is active.", Duration=6})
            elseif not isAlive and chainActive then chainActive = false; playSound(); WindUI:Notify({Title="✅ CHAIN DEFEATED ✅", Content="The main enemy is dead.", Duration=6}) end
        end
    end
end)

local MainSec = MainTab:Section({ Title = "Bypasses & Tools", Icon = "shield", Opened = true, Box = true })
MainSec:Button({ Title = "Remove Adonis Anticheat", Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/refs/heads/main/Source.lua"))() WindUI:Notify({Title="Bypassed", Content="Adonis AC Removed!", Duration=3}) end) end })
MainSec:Button({ Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
MainSec:Button({ Title = "Third Person View", Callback = function() pcall(function() LocalPlayer.CameraMode = Enum.CameraMode.Classic; LocalPlayer.CameraMaxZoomDistance = 1280; LocalPlayer.CameraMinZoomDistance = 0.5 end) end })
MainSec:Button({ Title = "Remove Mask on head", Callback = function() pcall(function() LocalPlayer.Character.Sack.SurfaceAppearance.Parent:Destroy() end) end })

local moveSec = MainTab:Section({ Title = "Movement", Icon = "move", Opened = true, Box = true })

local barrierTask, barrierActive = nil, false
moveSec:Toggle({ Title = "Destroy Invisible Barriers", Value = false, Callback = function(v)
    barrierActive = v; if v then barrierTask = task.spawn(function() while barrierActive do for _, p in ipairs(Workspace:GetDescendants()) do pcall(function() if p:IsA("BasePart") and p.Transparency == 1 and p.CanCollide and not p.Parent:FindFirstChild("Humanoid") then p:Destroy() end end) end task.wait(1.5) end end) end
end})

local clickTpConn
moveSec:Toggle({ Title = "Click Teleport (Ctrl + Click)", Value = false, Callback = function(v)
    if v then clickTpConn = UserInputService.InputBegan:Connect(function(i, g) if not g and i.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then pcall(function() LocalPlayer.Character:MoveTo(LocalPlayer:GetMouse().Hit.Position) end) end end) else if clickTpConn then clickTpConn:Disconnect() clickTpConn=nil end end
end})

local noclipLoop
moveSec:Toggle({ Title = "Noclip", Value = false, Callback = function(v)
    if v then noclipLoop = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end end) else if noclipLoop then noclipLoop:Disconnect() noclipLoop=nil end end
end})

local FLYING = false; local iyflyspeed = 1; local flyKeyDown, flyKeyUp
local function getRoot(char) return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') end
local function sFLY()
    if FLYING then return end; FLYING = true
    local T = getRoot(LocalPlayer.Character); if not T then return end
    local BG = Instance.new('BodyGyro', T); local BV = Instance.new('BodyVelocity', T)
    BG.P = 9e4; BG.maxTorque = Vector3.new(9e9, 9e9, 9e9); BG.cframe = T.CFrame
    BV.velocity = Vector3.new(0, 0, 0); BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}; local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}; local SPEED = 0
    task.spawn(function()
        while FLYING and LocalPlayer.Character do
            pcall(function() LocalPlayer.Character.Humanoid.PlatformStand = true end)
            if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then SPEED = 50 elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then SPEED = 0 end
            if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then BV.velocity = ((Camera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Camera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Camera.CoordinateFrame.p)) * SPEED * iyflyspeed; lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R} elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then BV.velocity = ((Camera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((Camera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Camera.CoordinateFrame.p)) * SPEED * iyflyspeed else BV.velocity = Vector3.new(0, 0, 0) end
            BG.cframe = Camera.CoordinateFrame; task.wait()
        end
        CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}; SPEED = 0; BG:Destroy(); BV:Destroy()
        pcall(function() LocalPlayer.Character.Humanoid.PlatformStand = false end)
    end)
    local mouse = LocalPlayer:GetMouse()
    flyKeyDown = mouse.KeyDown:Connect(function(KEY) if KEY:lower() == 'w' then CONTROL.F = 1 elseif KEY:lower() == 's' then CONTROL.B = -1 elseif KEY:lower() == 'a' then CONTROL.L = -1 elseif KEY:lower() == 'd' then CONTROL.R = 1 elseif KEY:lower() == 'e' then CONTROL.Q = 1 elseif KEY:lower() == 'q' then CONTROL.E = -1 end end)
    flyKeyUp = mouse.KeyUp:Connect(function(KEY) if KEY:lower() == 'w' then CONTROL.F = 0 elseif KEY:lower() == 's' then CONTROL.B = 0 elseif KEY:lower() == 'a' then CONTROL.L = 0 elseif KEY:lower() == 'd' then CONTROL.R = 0 elseif KEY:lower() == 'e' then CONTROL.Q = 0 elseif KEY:lower() == 'q' then CONTROL.E = 0 end end)
end
local function NOFLY() FLYING = false; if flyKeyDown then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end; pcall(function() LocalPlayer.Character.Humanoid.PlatformStand = false end) end
moveSec:Toggle({ Title = "Fly", Value = false, Callback = function(v) if v then sFLY() else NOFLY() end end })
-- ==========================================================
-- PART 2: DYNAMIC HEALTH ESP & TELEPORTS
-- ==========================================================
local VisSec = VisualsTab:Section({ Title = "Dynamic Health ESP", Icon = "users", Opened = true, Box = true })
local espElements, espConn = {}, nil

local function getHealthColor(health)
    if health > 100 then return Color3.fromRGB(173, 216, 230)
    elseif health >= 98 then return Color3.fromRGB(144, 238, 144)
    elseif health >= 60 then return Color3.fromRGB(255, 255, 255)
    elseif health >= 30 then return Color3.fromRGB(255, 255, 153)
    elseif health >= 20 then return Color3.fromRGB(255, 69, 0)
    else return Color3.fromRGB(139, 0, 0) end
end

local function cleanEsp(player)
    if espElements[player] then 
        pcall(function() espElements[player].Name:Remove(); espElements[player].Dist:Remove(); espElements[player].Highlight:Destroy() end)
        espElements[player] = nil 
    end
end

local function updatePlayerEsp()
    local activePlayers = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            activePlayers[player] = true
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChild("Humanoid")

            if char and hrp and head and hum and hum.Health > 0 then
                if not espElements[player] then
                    local d = { Name = Drawing.new("Text"), Dist = Drawing.new("Text"), Highlight = Instance.new("Highlight") }
                    d.Name.Size = 16; d.Name.Center = true; d.Name.Outline = true; d.Name.Font = 2
                    d.Dist.Size = 14; d.Dist.Center = true; d.Dist.Outline = true; d.Dist.Font = 2
                    d.Highlight.FillTransparency = 0.5; d.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255); d.Highlight.OutlineTransparency = 0; d.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; d.Highlight.Parent = char
                    espElements[player] = d
                end

                local d = espElements[player]; local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if onScreen then
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    local height = math.abs(headPos.Y - legPos.Y)
                    local distNum = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
                    local currentColor = getHealthColor(hum.Health)

                    d.Name.Color = currentColor; d.Name.Text = player.Name; d.Name.Position = Vector2.new(rootPos.X, headPos.Y - 20); d.Name.Visible = true
                    d.Dist.Color = Color3.fromRGB(200, 200, 200); d.Dist.Text = "["..math.floor(distNum).."m]"; d.Dist.Position = Vector2.new(rootPos.X, headPos.Y + height + 2); d.Dist.Visible = true
                    d.Highlight.FillColor = currentColor; d.Highlight.Parent = char
                else
                    d.Name.Visible = false; d.Dist.Visible = false
                end
            else cleanEsp(player) end
        end
    end
    for player, _ in pairs(espElements) do if not activePlayers[player] then cleanEsp(player) end end
end

VisSec:Toggle({ Title = "Player ESP (Health Color Chams)", Value = false, Callback = function(v)
    if v then if not espConn then espConn = RunService.RenderStepped:Connect(updatePlayerEsp) end else if espConn then espConn:Disconnect(); espConn = nil end for p, _ in pairs(espElements) do cleanEsp(p) end end
end})

local ItemEspSec = VisualsTab:Section({ Title = "Items & World ESP", Icon = "box", Opened = true, Box = true })
local function simpleHighlight(folder, toggleVar, color)
    task.spawn(function()
        while task.wait(1) do
            if _G[toggleVar] then
                for _, item in ipairs(folder:GetChildren()) do if item:IsA("Model") or item:IsA("BasePart") then if not item:FindFirstChild("WindUI_Chams") then local h = Instance.new("Highlight"); h.Name = "WindUI_Chams"; h.FillColor = color; h.FillTransparency = 0.5; h.OutlineTransparency = 0; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Parent = item end end end
            else
                for _, item in ipairs(folder:GetChildren()) do local h = item:FindFirstChild("WindUI_Chams"); if h then h:Destroy() end end
            end
        end
    end)
end

_G.airdropEsp, _G.artifactEsp, _G.trapEsp, _G.scrapEsp, _G.chainEsp = false, false, false, false, false
ItemEspSec:Toggle({ Title = "Airdrop Chams", Value = false, Callback = function(v) _G.airdropEsp = v; simpleHighlight(Workspace:WaitForChild("GameStuff"):WaitForChild("GameSections"):WaitForChild("AirDrops"), "airdropEsp", Color3.fromRGB(255, 255, 0)) end})
ItemEspSec:Toggle({ Title = "Artifact Chams", Value = false, Callback = function(v) _G.artifactEsp = v; simpleHighlight(Workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Artifacts"), "artifactEsp", Color3.fromRGB(0, 255, 255)) end})
ItemEspSec:Toggle({ Title = "BearTrap Chams", Value = false, Callback = function(v) _G.trapEsp = v; simpleHighlight(Workspace:WaitForChild("GameStuff"):WaitForChild("PlayerStuff"):WaitForChild("BearTraps"), "trapEsp", Color3.fromRGB(138, 43, 226)) end})
ItemEspSec:Toggle({ Title = "Scrap Chams", Value = false, Callback = function(v) _G.scrapEsp = v; simpleHighlight(Workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Scrap"), "scrapEsp", Color3.fromRGB(0, 255, 0)) end})

ItemEspSec:Toggle({ Title = "Chain ESP (Red)", Value = false, Callback = function(v)
    _G.chainEsp = v; task.spawn(function() while task.wait(1) do local chain = Workspace:FindFirstChild("Misc") and Workspace.Misc:FindFirstChild("AI") and Workspace.Misc.AI:FindFirstChild("CHAIN")
    if chain then if _G.chainEsp and not chain:FindFirstChild("Chain_ESP") then local h = Instance.new("Highlight"); h.Name = "Chain_ESP"; h.FillColor = Color3.fromRGB(255, 0, 0); h.FillTransparency = 0.5; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Parent = chain elseif not _G.chainEsp and chain:FindFirstChild("Chain_ESP") then chain.Chain_ESP:Destroy() end end end end)
end})

local TpSec = TpTab:Section({ Title = "Locations", Icon = "map", Opened = true, Box = true })

local playerNames = {}
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(playerNames, p.Name) end end
local playerTpDropdown = TpSec:Dropdown({ Title = "Teleport to player 👤", Values = playerNames, Callback = function(sel) local p = Players:FindFirstChild(sel); if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end})
task.spawn(function() while task.wait(10) do local nn = {}; for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(nn, p.Name) end end pcall(function() playerTpDropdown:Refresh(nn) end) end end)

local savedLocs, curLocName, curSelLoc = {}, "", ""
local ownTpSec = TpTab:Section({ Title = "Own Teleports", Icon = "map-pin", Opened = true, Box = true })
ownTpSec:Input({ Title = "Location Name", Callback = function(t) curLocName = t end })
local locDropdown = ownTpSec:Dropdown({ Title = "Select a saved item", Values = {}, Callback = function(v) curSelLoc = v end })
ownTpSec:Button({ Title = "Save Current Position", Callback = function() if curLocName ~= "" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then savedLocs[curLocName] = LocalPlayer.Character.HumanoidRootPart.CFrame; local names = {}; for n, _ in pairs(savedLocs) do table.insert(names, n) end; locDropdown:Refresh(names); WindUI:Notify({Title="Saved", Content=curLocName}) end end})
ownTpSec:Button({ Title = "Teleport to Selected", Callback = function() if savedLocs[curSelLoc] and LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = savedLocs[curSelLoc] end end})

local locs = { SafeHouse = CFrame.new(162.68, -94.26, 230.03), WorkShopOut = CFrame.new(130.92, -106.07, -2.17), WorkShopIn = CFrame.new(169.56, -103.65, -30.01), Cabin = CFrame.new(-324.80, -88.61, 290.67), Shop = CFrame.new(-111.37, -87.20, 203.52), PowerStation = CFrame.new(-208.29, -110.60, -120.22), WareHouse = CFrame.new(314.62, -113.51, -258.48), Ritual = CFrame.new(-18.60, -107.77, -229.89) }
for name, cf in pairs(locs) do TpSec:Button({ Title = name, Callback = function() pcall(function() LocalPlayer.Character.HumanoidRootPart.CFrame = cf end) end }) end
TpSec:Button({ Title = "Teleport to nearest Airdrop", Callback = function() pcall(function() local drops = Workspace.GameStuff.GameSections.AirDrops:GetChildren(); if #drops > 0 and LocalPlayer.Character then LocalPlayer.Character:PivotTo(drops[1]:GetPivot() * CFrame.new(0, 10, 0)) end end) end})
-- ==========================================================
-- PART 3: COMBAT, AUTOFARM, MISC & SETTINGS
-- ==========================================================
local CmbSec = CharTab:Section({ Title = "Combat & Character", Icon = "swords", Opened = true, Box = true })

local infStam, infCombat, autoClash, infGas = false, false, false, false
CmbSec:Toggle({ Title = "Inf Stamina", Value = false, Callback = function(v) infStam = v; task.spawn(function() while infStam do pcall(function() LocalPlayer.Character.Stats.Stamina.Value = 100 end) task.wait(0.5) end end) end})
CmbSec:Toggle({ Title = "Inf Combat Stamina", Value = false, Callback = function(v) infCombat = v; task.spawn(function() while infCombat do pcall(function() LocalPlayer.Character.Stats.CombatStamina.Value = 100 end) task.wait(0.5) end end) end})
CmbSec:Toggle({ Title = "Auto Win XSaw Clash", Value = false, Callback = function(v) autoClash = v; task.spawn(function() while autoClash do pcall(function() LocalPlayer.Character.Stats.ClashStrength.Value = 100 end) task.wait(0.01) end end) end})
CmbSec:Toggle({ Title = "Inf XSaw Gas", Value = false, Callback = function(v) infGas = v; task.spawn(function() while infGas do pcall(function() local c=LocalPlayer.Character; if c and c:FindFirstChild("Items") and c.Items:FindFirstChild("XSaw") then c.Items.XSaw:SetAttribute("Gas", 100) end end) task.wait(0.1) end end) end})

local walkSpeed = 18
CmbSec:Slider({ Title = "Walk Speed", Value = {Min=18, Max=200, Default=18}, Callback = function(v) walkSpeed = v end })
RunService.Heartbeat:Connect(function() pcall(function() local h = LocalPlayer.Character:FindFirstChild("Humanoid"); if h and h.WalkSpeed ~= walkSpeed then h.WalkSpeed = walkSpeed end end) end)

local jumpConn
CmbSec:Toggle({ Title = "Unlock Jump", Value = false, Callback = function(v)
    if v then jumpConn = RunService.Heartbeat:Connect(function() pcall(function() local hum = LocalPlayer.Character:FindFirstChild("Humanoid"); if hum and hum.JumpPower ~= 50 then hum.JumpPower = 50 end end) end) else if jumpConn then jumpConn:Disconnect(); jumpConn = nil end end
end})

CmbSec:Button({ Title = "Enable Inf Dodge (Must remove AC first)", Callback = function()
    local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...) if not checkcaller() and getnamecallmethod() == "FireServer" and self.Name == "CTS" then local args = {...}; if args[1] == "DoneDodge" then args[1] = "Dodge" end return __namecall(self, unpack(args)) end return __namecall(self, ...) end)
    WindUI:Notify({Title="Dodge Enabled", Content="You can now dodge infinitely.", Duration=3})
end})

local aimbot, holdPPM, chainTarget = false, false, nil
CmbSec:Toggle({ Title = "Aimbot on Chain (Hold PPM)", Value = false, Callback = function(v) aimbot = v end })
UserInputService.InputBegan:Connect(function(input, gpe) if not gpe and input.UserInputType == Enum.UserInputType.MouseButton2 then holdPPM = true end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton2 then holdPPM = false end end)
RunService.RenderStepped:Connect(function()
    if aimbot and holdPPM then
        if not chainTarget or not chainTarget.Parent then for _, c in ipairs(Workspace.Misc.AI:GetChildren()) do if c:FindFirstChild("HumanoidRootPart") then chainTarget = c break end end end
        if chainTarget then Camera.CFrame = CFrame.new(Camera.CFrame.Position, chainTarget:GetPivot().Position) end
    else chainTarget = nil end
end)

local FarmSec = FarmTab:Section({ Title = "Auto Farming", Icon = "feather", Opened = true, Box = true })
local function farmItem(folderPath, toggleVarName, delayTime)
    task.spawn(function()
        while _G[toggleVarName] do
            pcall(function() local folder = folderPath(); if folder then for _, item in ipairs(folder:GetChildren()) do if not _G[toggleVarName] then break end local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true); if prompt and prompt.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character:PivotTo(item:GetPivot() * CFrame.new(0, 3, 0)); task.wait(0.2); fireproximityprompt(prompt); task.wait(0.5) end end end end); task.wait(delayTime)
        end
    end)
end
_G.FarmScrap = false; FarmSec:Toggle({ Title = "AutoFarm Scrap", Value = false, Callback = function(v) _G.FarmScrap = v; if v then farmItem(function() return Workspace.Misc.Zones.LootingItems.Scrap end, "FarmScrap", 1) end end})
_G.FarmArtifact = false; FarmSec:Toggle({ Title = "AutoFarm Artifacts", Value = false, Callback = function(v) _G.FarmArtifact = v; if v then farmItem(function() return Workspace.Misc.Zones.LootingItems.Artifacts end, "FarmArtifact", 3) end end})

local ItemSec = MiscTab:Section({ Title = "Blueprints & GUIs", Icon = "key", Opened = true, Box = true })
local function unlockBP(name) pcall(function() LocalPlayer.PlayerStats.Blueprints:SetAttribute(name, true); WindUI:Notify({Title="Unlocked", Content=name.." unlocked!"}) end) end
ItemSec:Button({ Title = "Unlock CombatKnife", Callback = function() unlockBP("CombatKnife") end})
ItemSec:Button({ Title = "Unlock DoubleBarrel", Callback = function() unlockBP("DoubleBarrel") end})
ItemSec:Button({ Title = "Unlock M1911", Callback = function() unlockBP("M1911") end})
ItemSec:Button({ Title = "Unlock Machete", Callback = function() unlockBP("Machete") end})

ItemSec:Toggle({ Title = "Hide Blood Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Health.Visible = not v end) end})
ItemSec:Toggle({ Title = "Shop Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Shop.Visible = v end) end})
ItemSec:Toggle({ Title = "Deconstructor Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Deconstructor.Visible = v end) end})
ItemSec:Toggle({ Title = "Workbench Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Workbench.Visible = v end) end})

local hideEffectsActive = false
ItemSec:Toggle({ Title = "Hide Annoying Chain Screen effect", Value = false, Callback = function(v) hideEffectsActive = v end})
RunService.Heartbeat:Connect(function() if hideEffectsActive then pcall(function() local mf = LocalPlayer.PlayerGui.Ingame.MechanicsFrame; for _, n in ipairs({"CursedText", "Glitch", "StaticRegular", "StaticScare", "WhiteLines"}) do if mf:FindFirstChild(n) and mf[n].Visible then mf[n].Visible = false end end end) end end)

local WorldSec = MiscTab:Section({ Title = "World & Lighting", Icon = "zap", Opened = true, Box = true })
local Lighting = game:GetService("Lighting")
WorldSec:Button({ Title = "No Fog", Callback = function() Lighting.FogEnd = 100000; for _,v in pairs(Lighting:GetDescendants()) do if v:IsA("Atmosphere") then v:Destroy() end end end})
WorldSec:Toggle({ Title = "Fullbright", Value = false, Callback = function(v) if v then Lighting.Ambient=Color3.new(1,1,1); Lighting.OutdoorAmbient=Color3.new(1,1,1); Lighting.Brightness=2; Lighting.TimeOfDay="14:00:00"; Lighting.GlobalShadows=false end end})

local afkConn
WorldSec:Toggle({ Title = "Anti-AFK", Value = false, Callback = function(v)
    if v then afkConn = LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), Camera.CFrame); task.wait(1); game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), Camera.CFrame) end)
    else if afkConn then afkConn:Disconnect(); afkConn=nil end end
end})

local SrvSec = ServerTab:Section({ Title = "Server Actions", Icon = "server", Opened = true, Box = true })
SrvSec:Button({ Title = "Random Server Hop", Callback = function() WindUI:Notify({Title="Teleporting", Content="Hopping..."}); game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end })
_G.HopSmall = false
SrvSec:Toggle({ Title = "Auto Hop (< 5 Players)", Value = false, Callback = function(v)
    _G.HopSmall = v
    if v then if #Players:GetPlayers() < 5 then WindUI:Notify({Title="Found!", Content="Already in a small server."}); _G.HopSmall=false else game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end end
end})

SettingTab:Section({ Title = "Themes & UI", Icon = "palette", Opened = true, Box = true }):Keybind({ Title = "Keybind (Mở/Đóng UI)", Value = "G", Callback = function(v) pcall(function() Window:SetToggleKey(Enum.KeyCode[v]) end) end })

print("Purium Chain Script Successfully Loaded!")

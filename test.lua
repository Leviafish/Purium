-- ==========================================================
-- PART 1: WIND UI SETUP, NOTIFICATIONS & MAIN
-- ==========================================================
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "vms Hub", Text = "Đang tải Wind UI...", Duration = 3 })

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "💢 vms Hub | Chain | (Beta) 1.69",
    Icon = "swords", 
    Author = "vms",
    Folder = "vmsHub_Chain",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
    HideSearchBar = true
})

Window:EditOpenButton({
    Title = "Open vms Hub",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = Color3.fromRGB(255, 255, 255),
    OnlyMobile = false, Enabled = true, Draggable = true
})

-- TẠO CÁC TAB
local NotifyTab = Window:Tab({ Title = "Notifications", Icon = "bell" })
local MainTab = Window:Tab({ Title = "Main", Icon = "castle" })
local CharacterTab = Window:Tab({ Title = "Character", Icon = "user" })
local VisualsTab = Window:Tab({ Title = "Visuals (Upgraded)", Icon = "eye" })
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "map-pin" })
local MiscTab = Window:Tab({ Title = "Misc", Icon = "cog" })
local FarmTab = Window:Tab({ Title = "AutoFarm", Icon = "feather" })
local ServerTab = Window:Tab({ Title = "Servers", Icon = "server" })

-- ==========================================
-- NOTIFICATIONS TAB
-- ==========================================
local NotifSection = NotifyTab:Section({ Title = "Enable / Disable Notifications", Icon = "bell", Opened = true, Box = true })

local notificationSettings = { power = true, roundTime = true, chain = true, artifact = true, airdrop = true, playSound = true }

NotifSection:Toggle({ Title = "Low Power (30%)", Value = true, Callback = function(v) notificationSettings.power = v end })
NotifSection:Toggle({ Title = "End of Round (30s)", Value = true, Callback = function(v) notificationSettings.roundTime = v end })
NotifSection:Toggle({ Title = "CHAIN Spawn / Defeat", Value = true, Callback = function(v) notificationSettings.chain = v end })
NotifSection:Toggle({ Title = "Artifact Spawn", Value = true, Callback = function(v) notificationSettings.artifact = v end })
NotifSection:Toggle({ Title = "Airdrop Spawn", Value = true, Callback = function(v) notificationSettings.airdrop = v end })
NotifSection:Toggle({ Title = "Play Notification Sound", Value = true, Callback = function(v) notificationSettings.playSound = v end })

local Debris = game:GetService("Debris")
local valuesFolder = workspace:WaitForChild("GameStuff"):WaitForChild("Values")
local aiFolder = workspace:WaitForChild("Misc"):WaitForChild("AI")
local artifactsFolder = workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Artifacts")
local airDropsFolder = workspace:WaitForChild("GameStuff"):WaitForChild("GameSections"):WaitForChild("AirDrops")

local function playSound()
    if not notificationSettings.playSound then return end
    pcall(function()
        local sound = Instance.new("Sound"); sound.SoundId = "rbxassetid://15544478080"; sound.Volume = 5; sound.Parent = workspace
        sound:Play(); Debris:AddItem(sound, 3)
    end)
end

local function createThresholdNotifier(config)
    local hasBeenNotified = false
    valuesFolder:GetAttributeChangedSignal(config.Attribute):Connect(function()
        if not notificationSettings[config.SettingName] then return end
        local value = valuesFolder:GetAttribute(config.Attribute)
        if type(value) ~= "number" then return end
        local conditionMet = (value <= config.Threshold)
        if conditionMet and not hasBeenNotified then
            hasBeenNotified = true; playSound(); WindUI:Notify(config.Notification)
        elseif not conditionMet and hasBeenNotified then hasBeenNotified = false end
    end)
end

createThresholdNotifier({ Attribute = "Power", SettingName = "power", Threshold = 30, Notification = { Title = "Low Power!", Content = "30% power remaining.", Duration = 8 }})
createThresholdNotifier({ Attribute = "RoundTime", SettingName = "roundTime", Threshold = 30, Notification = { Title = "Round Ending!", Content = "30 seconds remaining!", Duration = 8 }})

task.spawn(function()
    local isChainCurrentlyActive = false
    while task.wait(3) do
        if notificationSettings.chain then
            local chainModel = aiFolder:FindFirstChild("CHAIN")
            local isCurrentlyAlive = chainModel and chainModel:FindFirstChildOfClass("Humanoid") and chainModel.Humanoid.Health > 0
            if isCurrentlyAlive and not isChainCurrentlyActive then
                isChainCurrentlyActive = true; playSound()
                WindUI:Notify({ Title = "‼️ CHAIN HAS SPAWNED ‼️", Content = "The main enemy is active on the map.", Duration = 10 })
            elseif not isCurrentlyAlive and isChainCurrentlyActive then
                isChainCurrentlyActive = false; playSound()
                WindUI:Notify({ Title = "✅ CHAIN DEFEATED ✅", Content = "The main enemy has been removed from the map.", Duration = 10 })
            end
        end
    end
end)

artifactsFolder.ChildAdded:Connect(function(artifact)
    if notificationSettings.artifact and artifact:IsA("Model") then
         playSound(); WindUI:Notify({ Title = "Artifact Has Spawned!", Content = "A new, valuable artifact is available on the map.", Duration = 7 })
    end
end)

airDropsFolder.ChildAdded:Connect(function(airdrop)
    if notificationSettings.airdrop and airdrop:IsA("Model") then
         playSound(); WindUI:Notify({ Title = "Airdrop Detected!", Content = "An airdrop has appeared on the map. Hurry up!", Duration = 8})
    end
end)

-- ==========================================
-- MAIN TAB
-- ==========================================
local MainSec = MainTab:Section({ Title = "Main Features", Icon = "star", Opened = true, Box = true })
MainSec:Button({ Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
MainSec:Button({ Title = "DEX", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/infyiff/backup/main/dex.lua"))() end })
MainSec:Button({ Title = "ThirdPerson", Callback = function() game.Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic; game.Players.LocalPlayer.CameraMaxZoomDistance = 1280; game.Players.LocalPlayer.CameraMinZoomDistance = 0.5 end })
MainSec:Button({ Title = "Remove Mask on head - third person", Callback = function() pcall(function() game.Players.LocalPlayer.Character.Sack.SurfaceAppearance.Parent:Destroy() end) end })
MainSec:Button({ Title = "Remove Adonis anticheat", Callback = function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/refs/heads/main/Source.lua"))() end })

local BarrierDestroyerEnabled = false
local BarrierDestroyerTask = nil
local function destroyInvisibleBarriersLoop()
    while BarrierDestroyerEnabled do
        for _, part in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if part:IsA("BasePart") and part.Transparency == 1 and part.CanCollide == true then
                    local isPlayerPart = part.Parent and game.Players:GetPlayerFromCharacter(part.Parent)
                    if not isPlayerPart then part:Destroy() end
                end
            end)
        end
        task.wait(1.5)
    end
end

MainSec:Toggle({ Title = "Destroys invisible barriers", Value = false, Callback = function(Value)
    BarrierDestroyerEnabled = Value
    if Value and (not BarrierDestroyerTask or not task.running(BarrierDestroyerTask)) then
        BarrierDestroyerTask = task.spawn(destroyInvisibleBarriersLoop)
    end
end})
-- ==========================================================
-- PART 2: UPGRADED ESP (VISUALS) & CHARACTER TAB
-- ==========================================================
local VisualsSec = VisualsTab:Section({ Title = "Player ESP (Upgraded)", Icon = "users", Opened = true, Box = true })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local espElements = {}
local espConnection = nil

local function updateEsp()
    local activePlayers = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
            activePlayers[player] = true
            local char = player.Character
            local hrp = char.HumanoidRootPart
            local hum = char.Humanoid
            
            if not espElements[player] then
                -- [UPGRADE] Added 2D Box and Health Bar
                local box = Drawing.new("Square"); box.Thickness = 1.5; box.Color = Color3.fromRGB(255, 255, 255); box.Filled = false
                local healthBarBg = Drawing.new("Line"); healthBarBg.Thickness = 3; healthBarBg.Color = Color3.fromRGB(0, 0, 0)
                local healthBar = Drawing.new("Line"); healthBar.Thickness = 1.5; healthBar.Color = Color3.fromRGB(0, 255, 0)
                local name = Drawing.new("Text"); name.Size = 16; name.Center = true; name.Outline = true; name.Color = Color3.fromRGB(255, 255, 255); name.Font = Drawing.Fonts.UI
                local dist = Drawing.new("Text"); dist.Size = 14; dist.Center = true; dist.Outline = true; dist.Color = Color3.fromRGB(200, 200, 200); dist.Font = Drawing.Fonts.Plex
                
                local highlight = Instance.new("Highlight")
                highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                highlight.FillColor = Color3.fromRGB(255, 0, 0); highlight.FillTransparency = 0.6
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255); highlight.OutlineTransparency = 0
                highlight.Parent = char
                
                espElements[player] = { Box = box, HealthBg = healthBarBg, Health = healthBar, Name = name, Distance = dist, Highlight = highlight }
            end

            local vector, onScreen = Camera:WorldToViewportPoint(hrp.Position)
            local elements = espElements[player]

            if onScreen then
                local headPos = Camera:WorldToViewportPoint(char:WaitForChild("Head").Position + Vector3.new(0, 0.5, 0))
                local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                local height = math.abs(headPos.Y - legPos.Y)
                local width = height / 2
                local distance = (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude

                -- Upgraded Box
                elements.Box.Size = Vector2.new(width, height)
                elements.Box.Position = Vector2.new(vector.X - width / 2, headPos.Y)
                elements.Box.Visible = true

                -- Upgraded Health Bar
                local healthPercent = hum.Health / hum.MaxHealth
                elements.HealthBg.From = Vector2.new(vector.X - width / 2 - 5, headPos.Y + height)
                elements.HealthBg.To = Vector2.new(vector.X - width / 2 - 5, headPos.Y)
                elements.HealthBg.Visible = true
                
                elements.Health.From = Vector2.new(vector.X - width / 2 - 5, headPos.Y + height)
                elements.Health.To = Vector2.new(vector.X - width / 2 - 5, headPos.Y + height - (height * healthPercent))
                elements.Health.Color = Color3.fromRGB(255 - (healthPercent * 255), healthPercent * 255, 0)
                elements.Health.Visible = true

                -- Name & Distance
                elements.Name.Text = player.Name
                elements.Name.Position = Vector2.new(vector.X, headPos.Y - 20)
                elements.Name.Visible = true
                
                elements.Distance.Text = "[" .. math.floor(distance) .. "m]"
                elements.Distance.Position = Vector2.new(vector.X, headPos.Y + height + 5)
                elements.Distance.Visible = true
            else
                elements.Box.Visible = false; elements.HealthBg.Visible = false; elements.Health.Visible = false
                elements.Name.Visible = false; elements.Distance.Visible = false
            end
        end
    end

    for player, elements in pairs(espElements) do
        if not activePlayers[player] then
            elements.Highlight:Destroy(); elements.Box:Remove(); elements.HealthBg:Remove(); elements.Health:Remove()
            elements.Name:Remove(); elements.Distance:Remove()
            espElements[player] = nil
        end
    end
end

VisualsSec:Toggle({ Title = "Player ESP (Upgraded Box & Health)", Value = false, Callback = function(Value)
    if Value then
        if not espConnection then espConnection = RunService.RenderStepped:Connect(updateEsp) end
    else
        if espConnection then espConnection:Disconnect(); espConnection = nil end
        for p, e in pairs(espElements) do
            e.Highlight:Destroy(); e.Box:Remove(); e.HealthBg:Remove(); e.Health:Remove(); e.Name:Remove(); e.Distance:Remove()
        end
        espElements = {}
    end
end})

-- ==========================================
-- CHARACTER TAB
-- ==========================================
local CharSec = CharacterTab:Section({ Title = "Character Mods", Icon = "user", Opened = true, Box = true })

local staminaLoopActive, combatStaminaLoopActive, clashLoopActive, gasLoopActive = false, false, false, false
CharSec:Toggle({ Title = "Inf Stamina", Value = false, Callback = function(Value)
    staminaLoopActive = Value
    if Value then task.spawn(function() while staminaLoopActive do pcall(function() game.Players.LocalPlayer.Character.Stats.Stamina.Value = 100 end) task.wait(0.5) end end) end
end})

CharSec:Toggle({ Title = "Inf Combat Stamina", Value = false, Callback = function(Value)
    combatStaminaLoopActive = Value
    if Value then task.spawn(function() while combatStaminaLoopActive do pcall(function() game.Players.LocalPlayer.Character.Stats.CombatStamina.Value = 100 end) task.wait(0.5) end end) end
end})

CharSec:Toggle({ Title = "Auto Win XSaw Clash", Value = false, Callback = function(Value)
    clashLoopActive = Value
    if Value then task.spawn(function() while clashLoopActive do pcall(function() game.Players.LocalPlayer.Character.Stats.ClashStrength.Value = 100 end) task.wait(0.005) end end) end
end})

CharSec:Toggle({ Title = "Inf XSaw Gas", Value = false, Callback = function(Value)
    gasLoopActive = Value
    if Value then task.spawn(function() while gasLoopActive do pcall(function() local char = game.Players.LocalPlayer.Character; if char and char:FindFirstChild("Items") and char.Items:FindFirstChild("XSaw") then char.Items.XSaw:SetAttribute("Gas", 100) end end) task.wait(0.01) end end) end
end})

local targetSpeed = 18
CharSec:Slider({ Title = "Walk Speed", Value = {Min = 18, Max = 200, Default = 18}, Callback = function(Value) targetSpeed = Value end })
RunService.Heartbeat:Connect(function() pcall(function() local hum = LocalPlayer.Character:FindFirstChild("Humanoid"); if hum and hum.WalkSpeed ~= targetSpeed then hum.WalkSpeed = targetSpeed end end) end)

local ToggleEnabled, RightMouseDown, CHAIN = false, false, nil
CharSec:Toggle({ Title = "Aimbot (hold PPM)", Value = false, Callback = function(Value) ToggleEnabled = Value end })
game:GetService("UserInputService").InputBegan:Connect(function(input, gpe) if not gpe and input.UserInputType == Enum.UserInputType.MouseButton2 then RightMouseDown = true end end)
game:GetService("UserInputService").InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton2 then RightMouseDown = false end end)

RunService.RenderStepped:Connect(function()
    if ToggleEnabled and RightMouseDown then
        if not CHAIN or not CHAIN.Parent then
            for _, child in ipairs(workspace.Misc.AI:GetChildren()) do if child:FindFirstChild("HumanoidRootPart") then CHAIN = child break end end
        end
        if CHAIN then Camera.CFrame = CFrame.new(Camera.CFrame.Position, CHAIN:GetPivot().Position) end
    else CHAIN = nil end
end)
-- ==========================================================
-- PART 3: TELEPORT, FARM, MISC & SERVER HOPPER
-- ==========================================================
local TpSec = TeleportTab:Section({ Title = "Map Teleports", Icon = "map", Opened = true, Box = true })

TpSec:Button({ Title = "SafeHouse", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(162.68, -94.26, 230.03) end })
TpSec:Button({ Title = "WorkShop Outside", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(130.92, -106.07, -2.17) end })
TpSec:Button({ Title = "WorkShop Inside", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(169.56, -103.65, -30.01) end })
TpSec:Button({ Title = "Cabin inside", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-324.80, -88.61, 290.67) end })
TpSec:Button({ Title = "Shop", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-111.37, -87.20, 203.52) end })
TpSec:Button({ Title = "PowerStation", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-208.29, -110.60, -120.22) end })
TpSec:Button({ Title = "WareHouse", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(314.62, -113.51, -258.48) end })
TpSec:Button({ Title = "Ritual", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-18.60, -107.77, -229.89) end })
TpSec:Button({ Title = "LeaderBoard", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(45.65, -97.96, 352.51) end })
TpSec:Button({ Title = "Radio Tower", Callback = function() LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-402.22, -112.36, 44.16) end })

-- ==========================================
-- AUTOFARM TAB
-- ==========================================
local FarmSec = FarmTab:Section({ Title = "Auto Farming", Icon = "feather", Opened = true, Box = true })

local isFarming = false
FarmSec:Toggle({ Title = "AutoFarm Collect Scrap", Value = false, Callback = function(Value)
    isFarming = Value
    if isFarming then
        task.spawn(function()
            local LootFolders = workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Scrap")
            while isFarming do
                for _, scrapItem in ipairs(LootFolders:GetChildren()) do
                    if not isFarming then break end
                    if scrapItem:IsA("Model") and scrapItem:GetAttribute("Scrap") ~= nil and scrapItem:FindFirstChild("Values") and scrapItem.Values:GetAttribute("Available") == true then
                        if LocalPlayer.Character then LocalPlayer.Character:PivotTo(scrapItem:GetPivot() * CFrame.new(0, 3, 0)) end
                        task.wait(0.1)
                        local prompt = scrapItem:FindFirstChildWhichIsA("ProximityPrompt", true)
                        if prompt then fireproximityprompt(prompt) end
                    end
                    task.wait(0.1)
                end
                if isFarming then task.wait(1) end
            end
        end)
    end
end})

local isArtifactFarming = false
FarmSec:Toggle({ Title = "AutoFarm Artifacts", Value = false, Callback = function(Value)
    isArtifactFarming = Value
    if isArtifactFarming then
        task.spawn(function()
            local artifactsFolder = workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Artifacts")
            while isArtifactFarming do
                for _, artifact in ipairs(artifactsFolder:GetChildren()) do
                    if not isArtifactFarming then break end
                    local prompt = artifact:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if artifact:IsA("Model") and prompt and prompt.Enabled then
                        if LocalPlayer.Character then LocalPlayer.Character:PivotTo(artifact:GetPivot() * CFrame.new(0, 3, 0)) end
                        task.wait(0.2)
                        fireproximityprompt(prompt)
                        task.wait(0.5)
                    end
                end
                if isArtifactFarming then task.wait(5) end
            end
        end)
    end
end})

-- ==========================================
-- MISC TAB (Lighting & Anti-AFK)
-- ==========================================
local MiscSec = MiscTab:Section({ Title = "World & Game", Icon = "zap", Opened = true, Box = true })
local Lighting = game:GetService("Lighting")
MiscSec:Button({ Title = "No Fog", Callback = function() Lighting.FogEnd = 100000; for _, v in pairs(Lighting:GetDescendants()) do if v:IsA("Atmosphere") then v:Destroy() end end end })

local isFullbright = false
MiscSec:Toggle({ Title = "Fullbright", Value = false, Callback = function(Value)
    isFullbright = Value
    if isFullbright then
        Lighting.Ambient = Color3.new(1, 1, 1); Lighting.OutdoorAmbient = Color3.new(1, 1, 1); Lighting.Brightness = 2; Lighting.TimeOfDay = "14:00:00"; Lighting.FogEnd = 100000; Lighting.GlobalShadows = false
    end
end})

local antiAfkConnection
MiscSec:Toggle({ Title = "Anti-AFK", Value = false, Callback = function(Value)
    if Value then
        antiAfkConnection = LocalPlayer.Idled:Connect(function()
            game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            task.wait(1)
            game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        end)
    else
        if antiAfkConnection then antiAfkConnection:Disconnect(); antiAfkConnection = nil end
    end
end})

-- ==========================================
-- SERVER TAB
-- ==========================================
local SrvSec = ServerTab:Section({ Title = "Server Hopper", Icon = "server", Opened = true, Box = true })
local TeleportService = game:GetService("TeleportService")

SrvSec:Button({ Title = "Go to Random Server", Callback = function() WindUI:Notify({Title = "Teleporting...", Content = "Going to a random server."}) pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end) end })

_G.isHoppingForSmallServer = false
SrvSec:Toggle({ Title = "Small Server Hopper (< 5 Players)", Value = false, Callback = function(Value)
    _G.isHoppingForSmallServer = Value
    if Value then
        WindUI:Notify({Title = "Searching...", Content = "Looking for a server with less than 5 players."})
        if #game.Players:GetPlayers() < 5 then
            WindUI:Notify({Title = "Found!", Content = "This server already has few players."})
            _G.isHoppingForSmallServer = false
            return
        end
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
end})

print("Successfully loaded vms Hub (WindUI Version)!")

print("Loading V8.0 SINGULARITY ENGINE...")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium V8.0", Text = "PostSimulation & Spatial Engine Injected!", Duration = 3 })

-- ÉP 100 FPS
pcall(function() if setfpscap then setfpscap(100) end end)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Silent Assassin |", Icon = "door-open", Author = "Version : 8.0 The Singularity", Folder = "Purium_Silent-Assassin",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium God") end }
})

Window:EditOpenButton({ Title = "Open UI", Icon = "monitor", CornerRadius = UDim.new(0,16), StrokeThickness = 2, Color = ColorSequence.new(Color3.fromHex("1e1e1e"), Color3.fromHex("000000")), OnlyMobile = false, Enabled = true, Draggable = true })
WindUI:AddTheme({ Name = "Amethyst", Accent = Color3.fromHex("7E2CB6"), Dialog = Color3.fromHex("321E46"), Outline = Color3.fromHex("552D78"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("280C47"), Button = Color3.fromHex("733796"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("7E2CB6"), Slider = Color3.fromHex("7E2CB6"), Checkbox = Color3.fromHex("7E2CB6"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("7E2CB6"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
Window:Tag({ Title = "v8.0 (Zero-Lag Singularity)", Icon = "zap", Color = Color3.fromRGB(0, 255, 150), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

_G.AntiSlow = false; _G.FastSlash = false; _G.AntiKickEnabled = false; _G.InfiniteInvis = false; _G.LastAttackTime = 0

-- LÕI HOOK (Tẩy Não)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if not checkcaller() then
        if _G.AntiKickEnabled and (method == "Kick" or method == "kick") then return nil end
        if method == "InvokeServer" or method == "FireServer" then
            if _G.InfiniteInvis and args[1] == "SendMessage" and args[2] == "WeaponSwung" then return nil end
            if (_G.AntiSlow or _G.FastSlash) and args[1] == "AttemptWeaponHit" and type(args[2]) == "table" then
                if _G.AntiSlow then args[2].shouldSlow = false end
                args[2].cycleIndex = 1 
                if args[2].attackCycleData then 
                    if _G.AntiSlow then args[2].attackCycleData.slowMult = 1; args[2].attackCycleData.slowTime = 0 end
                    if _G.FastSlash then args[2].attackCycleData.attackTime = 0.2 end
                end
                if args[2].weaponDefinition then
                    args[2].weaponDefinition.attackOrder = {"1", "1", "1", "1"}
                    if args[2].weaponDefinition.attackCycle then
                        for k, v in pairs(args[2].weaponDefinition.attackCycle) do 
                            if _G.AntiSlow then v.slowMult = 1; v.slowTime = 0 end
                            if _G.FastSlash then v.attackTime = 0.2 end
                        end
                    end
                end
                return oldNamecall(self, table.unpack(args))
            end
        end
    end
    return oldNamecall(self, ...)
end)

local BypassTab = Window:Tab({ Title = "Server Modification", Icon = "shield-alert" })
local CombatTab = Window:Tab({ Title = "Combat & Farm", Icon = "swords" })
local GachaTab = Window:Tab({ Title = "Auto Gacha", Icon = "box" })
local MoveTab = Window:Tab({ Title = "Movement & Fling", Icon = "move" })
local VisTab = Window:Tab({ Title = "Visuals (ESP)", Icon = "eye" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local GachaSec = GachaTab:Section({ Title = "Auto Open Chests", Icon = "shopping-cart", Opened = true, Box = true })
_G.AutoGacha = false; _G.GachaType = "Basic" 
GachaSec:Dropdown({ Title = "Select Chest Type", Values = {"Basic", "Divine"}, Value = "Basic", Callback = function(v) _G.GachaType = v end})
GachaSec:Toggle({ Title = "Enable Auto Gacha", Value = false, Callback = function(v) 
    _G.AutoGacha = v 
    if v then task.spawn(function() while _G.AutoGacha do pcall(function() GameRemote:InvokeServer("AttemptRollGachaChest", _G.GachaType) end); task.wait(1.5) end end) end
end})

-- =======================================================
-- LẬP TRÌNH HƯỚNG SỰ KIỆN: 0% CPU OVERHEAD
-- =======================================================
local MoveSec = MoveTab:Section({ Title = "Character Modification", Icon = "user", Opened = true, Box = true })
_G.WsEnabled, _G.WsValue = false, 25
MoveSec:Toggle({ Title = "Enable WalkSpeed", Value = false, Callback = function(v) 
    _G.WsEnabled = v; if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v and _G.WsValue or 16 end
end})
MoveSec:Slider({ Title = "Speed Amount", Value = {Min = 16, Max = 1500, Default = 25}, Callback = function(v) 
    _G.WsValue = v; if _G.WsEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid.WalkSpeed = v end
end})

local GodModeSec = BypassTab:Section({ Title = "God Mode & Heal", Icon = "heart", Opened = true, Box = true })
_G.DesyncGodMode = false
GodModeSec:Toggle({ Title = "God Mode (Desync)", Value = false, Callback = function(v) 
    _G.DesyncGodMode = v 
    pcall(function()
        if not v then
            local cp = Workspace:FindFirstChild("PuriumCamPart"); if cp then cp:Destroy() end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = LocalPlayer.Character.Humanoid end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if hrp.Position.Y > 20000 then hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0) end end
        end
    end)
end})

local function getFakeCamPart() local cp = Workspace:FindFirstChild("PuriumCamPart"); if not cp then cp = Instance.new("Part"); cp.Name = "PuriumCamPart"; cp.Transparency = 1; cp.CanCollide = false; cp.Anchored = true; cp.Massless = true; cp.Size = Vector3.new(1, 1, 1); cp.Parent = Workspace end; return cp end
RunService.RenderStepped:Connect(function() pcall(function() if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if hrp.Position.Y > 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end; local cp = getFakeCamPart(); cp.CFrame = hrp.CFrame; Camera.CameraSubject = cp end end) end)

_G.GodModeEnabled = false; _G.HealthValue = 5000
GodModeSec:Toggle({ Title = "Event Auto Heal (0% CPU)", Value = false, Callback = function(v) _G.GodModeEnabled = v end})
GodModeSec:Slider({ Title = "Health Amount", Value = {Min = 100, Max = 100000, Default = 5000}, Callback = function(v) _G.HealthValue = v end})

local function SetupEventSensors(char)
    local hum = char:WaitForChild("Humanoid", 5)
    if hum then
        hum:GetPropertyChangedSignal("Health"):Connect(function() if _G.GodModeEnabled and hum.Health < _G.HealthValue then hum.Health = _G.HealthValue end end)
        hum:GetPropertyChangedSignal("MaxHealth"):Connect(function() if _G.GodModeEnabled and hum.MaxHealth < _G.HealthValue then hum.MaxHealth = _G.HealthValue end end)
        hum:GetPropertyChangedSignal("WalkSpeed"):Connect(function() if _G.AntiSlow and hum.WalkSpeed < 16 then hum.WalkSpeed = 16 elseif _G.WsEnabled and hum.WalkSpeed ~= _G.WsValue then hum.WalkSpeed = _G.WsValue end end)
        if _G.GodModeEnabled then hum.MaxHealth = _G.HealthValue; hum.Health = _G.HealthValue end
        if _G.WsEnabled then hum.WalkSpeed = _G.WsValue end
    end
end
LocalPlayer.CharacterAdded:Connect(SetupEventSensors)
if LocalPlayer.Character then SetupEventSensors(LocalPlayer.Character) end

local CombatSec = CombatTab:Section({ Title = "Weapon Control", Icon = "crosshair", Opened = true, Box = true })
CombatSec:Toggle({ Title = "M1 Combo Lock + Fast Slash", Value = false, Callback = function(v) _G.FastSlash = v end})
RunService.Heartbeat:Connect(function() if _G.FastSlash then pcall(function() local char = LocalPlayer.Character; if char then for _, v in ipairs(char:GetDescendants()) do if v:IsA("ModuleScript") then if string.find(string.lower(v.Name), "weapon") or string.find(string.lower(v.Name), "attack") or string.find(string.lower(v.Name), "stats") then local success, stats = pcall(require, v); if success and type(stats) == "table" and stats.attackCycle then if stats.attackOrder then stats.attackOrder = {"1", "1", "1", "1"} end; for realStat, val in pairs(stats) do local lowerStat = string.lower(realStat); if lowerStat == "attacktime" or lowerStat == "swingtime" or lowerStat == "windup" then if type(val) == "number" and val ~= 0.2 then stats[realStat] = 0.2 end end end; for k, cycle in pairs(stats.attackCycle) do if type(cycle) == "table" and cycle.attackTime and cycle.attackTime ~= 0.2 then cycle.attackTime = 0.2 end end end end end end end end) end end)
CombatSec:Toggle({ Title = "Enable Anti-Slow", Value = false, Callback = function(v) _G.AntiSlow = v end})
CombatSec:Toggle({ Title = "Ghost Mode (Infinite Invis)", Value = false, Callback = function(v) _G.InfiniteInvis = v end})

local KillSec = CombatTab:Section({ Title = "THE SINGULARITY ENGINE", Icon = "zap", Opened = true, Box = true })

-- =======================================================
-- BỘ MÁY TỐI ƯU HÓA ĐỈNH CAO: POSTSIMULATION + DEFER + SPATIAL FILTER
-- =======================================================
local NukeWeaponDef = { 
    attackCycle = { ["1"] = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, 
    attackOrder = {"1"} 
}
local NukeCycleData = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0}

_G.ParallelAura = false
_G.AuraRadius = 500
_G.AuraSpam = 20
_G.AuraDelay = 0.1

KillSec:Toggle({ Title = "Enable The Singularity (Zero-Lag Nuke)", Desc = "Dùng PostSimulation + Spatial Query (Lọc rác) + Defer Remote", Value = false, Callback = function(v) _G.ParallelAura = v end})
KillSec:Slider({ Title = "Singularity Radius (Tầm quét)", Value = {Min = 50, Max = 2000, Default = 500}, Callback = function(v) _G.AuraRadius = v end})
KillSec:Slider({ Title = "Spam Per Target (Trọng Lượng)", Value = {Min = 1, Max = 100, Default = 20}, Callback = function(v) _G.AuraSpam = v end})
KillSec:Slider({ Title = "Ping Stabilizer (Delay)", Desc = "0.1 là lý tưởng nhất, Ping xanh mượt", Value = {Min = 0, Max = 1, Default = 0.1}, Callback = function(v) _G.AuraDelay = v end})

-- LỌC RÁC: Khai báo SpatialParams để Engine KHÔNG quét map, chỉ quét quái/người
local SpatialParams = OverlapParams.new()
SpatialParams.FilterType = Enum.RaycastFilterType.Exclude

local function UpdateSpatialFilter()
    if LocalPlayer.Character then
        -- Loại bỏ bản thân và toàn bộ Terrain/Đất đá ra khỏi vùng quét (Giảm 99% tải CPU)
        SpatialParams.FilterDescendantsInstances = {LocalPlayer.Character, Workspace.Terrain}
    end
end
LocalPlayer.CharacterAdded:Connect(UpdateSpatialFilter)
UpdateSpatialFilter()

local lastAuraTick = 0

-- SỬ DỤNG POSTSIMULATION ĐỂ LÀM TRÙM FRAME CUỐI
RunService.PostSimulation:Connect(function()
    if not _G.ParallelAura then return end
    
    local currentTime = tick()
    if currentTime - lastAuraTick < _G.AuraDelay then return end
    lastAuraTick = currentTime

    local Char = LocalPlayer.Character
    local MyTool = Char and Char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not Char or not MyTool or not Char:FindFirstChild("HumanoidRootPart") then return end
    local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or Char.HumanoidRootPart.Position

    -- ĐƯA VÀO HÀNG CHỜ DEFER ĐỂ KHÔNG CHẶN LUỒNG GAME
    task.defer(function()
        local targetsFound = {}
        local processedModels = {}
        local hitArray = {}

        -- QUÉT SIÊU TỐC VỚI BỘ LỌC C++ (Không còn bị lag máy)
        local partsInRadius = Workspace:GetPartBoundsInRadius(myPos, _G.AuraRadius, SpatialParams)
        
        for _, part in ipairs(partsInRadius) do
            local model = part.Parent
            if model and model:IsA("Model") and not processedModels[model] then
                processedModels[model] = true
                local hum = model:FindFirstChild("Humanoid")
                -- Chỉ gom những ai có Humanoid và còn máu
                if hum and hum.Health > 0 and model ~= Char then
                    table.insert(targetsFound, model)
                end
            end
        end

        -- NẾU TÌM THẤY MỤC TIÊU -> GOM GÓI TIN LẠI
        if #targetsFound > 0 then
            for _, targetModel in ipairs(targetsFound) do
                local hrp = targetModel:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local tPos = hrp.Position
                    local dist = (tPos - myPos).Magnitude
                    local dir = dist > 0 and (tPos - myPos).Unit or Vector3.zAxis
                    
                    local singleHit = {
                        knockback = 0, isClosestEnemy = true, origin = myPos, 
                        enemyModel = targetModel, distance = dist, direction = dir
                    }
                    
                    -- Nhân bản lệnh đánh theo chỉ số AuraSpam (Gióng lên Max 50 để tránh đứt kết nối Server)
                    for i = 1, math.clamp(_G.AuraSpam, 1, 50) do
                        table.insert(hitArray, singleHit)
                    end
                end
            end

            -- BẮN 1 PHÁT DUY NHẤT QUA REMOTE (Chống Ping Spike)
            if #hitArray > 0 then
                local Args = {
                    "AttemptWeaponHit",
                    {
                        attackCycleData = NukeCycleData, knockback = 0, shouldLock = true, shouldLunge = false, 
                        hitboxOffset = Vector3.zero, isCritical = true, shouldSlow = false, 
                        attackCooldown = 0, damage = 9e9, lungeKnockback = 0, cycleIndex = 1, slowMult = 1, 
                        hitboxSize = Vector3.new(9e9, 9e9, 9e9), weaponDefinition = NukeWeaponDef, 
                        tool = MyTool, slowTime = 0
                    },
                    hitArray
                }
                
                -- Spawn ra luồng riêng để InvokeServer không làm khựng màn hình
                task.spawn(function()
                    pcall(function() GameRemote:InvokeServer(table.unpack(Args)) end)
                end)
            end
        end
    end)
end)

local VisSec = VisTab:Section({ Title = "ESP Configurations", Icon = "eye", Opened = true, Box = true })
_G.ESP_Box, _G.ESP_Name, _G.ESP_Chams = false, false, false
VisSec:Toggle({ Title = "Enable 2D Box", Value = false, Callback = function(v) _G.ESP_Box = v end})
VisSec:Toggle({ Title = "Enable Names & Distance", Value = false, Callback = function(v) _G.ESP_Name = v end})
VisSec:Toggle({ Title = "Enable Chams (Highlight)", Value = false, Callback = function(v) _G.ESP_Chams = v end})
local espElements = {}
local function cleanEsp(player) if espElements[player] then pcall(function() espElements[player].Name:Remove(); espElements[player].Box:Remove(); espElements[player].Highlight:Destroy() end); espElements[player] = nil end end
RunService.RenderStepped:Connect(function() pcall(function() local activePlayers = {}; if _G.ESP_Box or _G.ESP_Name or _G.ESP_Chams then for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer then activePlayers[player] = true; local char = player.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local hum = char and char:FindFirstChild("Humanoid"); local head = char and char:FindFirstChild("Head"); if char and hrp and hum and head and hum.Health > 0 then if not espElements[player] then local d = { Name = Drawing.new("Text"), Box = Drawing.new("Square"), Highlight = Instance.new("Highlight") }; d.Name.Size = 16; d.Name.Center = true; d.Name.Outline = true; d.Name.Font = 2; d.Box.Thickness = 1; d.Box.Filled = false; d.Highlight.FillTransparency = 0.5; d.Highlight.OutlineTransparency = 0; d.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; d.Highlight.Parent = char; espElements[player] = d end; local d = espElements[player]; local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position); if onScreen then local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)); local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)); local boxHeight = math.abs(headPos.Y - legPos.Y); local boxWidth = boxHeight * 0.6; local boxPos = Vector2.new(rootPos.X - boxWidth / 2, headPos.Y); local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0; local teamColor = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 50, 50); d.Box.Size = Vector2.new(boxWidth, boxHeight); d.Box.Position = boxPos; d.Box.Color = teamColor; d.Box.Visible = _G.ESP_Box; d.Name.Color = teamColor; d.Name.Text = player.Name .. " ["..math.floor(dist).."m]"; d.Name.Position = Vector2.new(rootPos.X, headPos.Y - 20); d.Name.Visible = _G.ESP_Name; d.Highlight.FillColor = teamColor; d.Highlight.Parent = char; d.Highlight.Enabled = _G.ESP_Chams else d.Name.Visible = false; d.Box.Visible = false; d.Highlight.Enabled = false end else cleanEsp(player) end end end end; for player, _ in pairs(espElements) do if not activePlayers[player] then cleanEsp(player) end end end) end)

local ThemeSection = SettingTab:Section({ Title = "Themes", Icon = "palette", Opened = true, Box = true })
local validThemes = WindUI:GetThemes(); local themes = {}
for themeName, _ in pairs(validThemes) do table.insert(themes, themeName) end; table.sort(themes)
ThemeSection:Dropdown({ Title = "Theme", Desc = "Choose UI Style", Values = themes, Flag = "ThemeDropdown", Value = "Dark", Callback = function(Value) if validThemes[Value] then pcall(function() WindUI:SetTheme(Value) end) end end })
ThemeSection:Keybind({ Title = "Keybind", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

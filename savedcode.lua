print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Ultimate Spam...", Duration = 3 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Silent Assassin |", Icon = "door-open", Author = "Version : 4.2 Unlimited Spam", Folder = "Purium_Silent-Assassin",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium Premium") end }
})

Window:EditOpenButton({ Title = "Open UI", Icon = "monitor", CornerRadius = UDim.new(0,16), StrokeThickness = 2, Color = ColorSequence.new(Color3.fromHex("1e1e1e"), Color3.fromHex("000000")), OnlyMobile = false, Enabled = true, Draggable = true })
WindUI:AddTheme({ Name = "Amethyst", Accent = Color3.fromHex("7E2CB6"), Dialog = Color3.fromHex("321E46"), Outline = Color3.fromHex("552D78"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("280C47"), Button = Color3.fromHex("733796"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("7E2CB6"), Slider = Color3.fromHex("7E2CB6"), Checkbox = Color3.fromHex("7E2CB6"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("7E2CB6"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
WindUI:AddTheme({ Name = "AMOLED", Accent = Color3.fromHex("FFFFFF"), Dialog = Color3.fromHex("000000"), Outline = Color3.fromHex("141414"), Text = Color3.fromHex("FFFFFF"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("000000"), Button = Color3.fromHex("0F0F0F"), Icon = Color3.fromHex("FFFFFF"), Toggle = Color3.fromHex("FFFFFF"), Slider = Color3.fromHex("FFFFFF"), Checkbox = Color3.fromHex("FFFFFF"), PanelBackground = Color3.fromHex("000000"), PanelBackgroundTransparency = 0, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("FFFFFF"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0 })

Window:Tag({ Title = "v4.2 (Zero-Lag Spam Nuke)", Icon = "flame", Color = Color3.fromRGB(255, 100, 0), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

_G.AntiSlow = false; _G.FastSlash = false; _G.AntiKickEnabled = false; _G.InfiniteInvis = false; _G.LastAttackTime = 0

-- LÕI HOOK BẢO VỆ
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
local PlayerTab = Window:Tab({ Title = "Players List", Icon = "users" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

-- =====================================
-- TAB AUTO GACHA
-- =====================================
local GachaSec = GachaTab:Section({ Title = "Auto Open Chests", Icon = "shopping-cart", Opened = true, Box = true })
_G.AutoGacha = false; _G.GachaType = "Basic" 
GachaSec:Dropdown({ Title = "Select Chest Type", Values = {"Basic", "Divine"}, Value = "Basic", Callback = function(v) _G.GachaType = v end})
GachaSec:Toggle({ Title = "Enable Auto Gacha", Value = false, Callback = function(v) 
    _G.AutoGacha = v 
    if v then task.spawn(function() while _G.AutoGacha do pcall(function() GameRemote:InvokeServer("AttemptRollGachaChest", _G.GachaType) end); task.wait(1.5) end end) end
end})

-- =====================================
-- TAB MOVEMENT
-- =====================================
local MoveSec = MoveTab:Section({ Title = "Character Modification", Icon = "user", Opened = true, Box = true })
local noclipLoop
MoveSec:Toggle({ Title = "Enable Noclip", Value = false, Callback = function(v) if v then noclipLoop = RunService.Stepped:Connect(function() pcall(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end end) end) else if noclipLoop then noclipLoop:Disconnect(); noclipLoop = nil end end end})
_G.WsEnabled, _G.WsValue = false, 25
MoveSec:Toggle({ Title = "Enable WalkSpeed", Value = false, Callback = function(v) _G.WsEnabled = v; if not v then pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end) end end})
MoveSec:Slider({ Title = "Speed Amount", Value = {Min = 16, Max = 1500, Default = 25}, Callback = function(v) _G.WsValue = v end})

RunService.Heartbeat:Connect(function() pcall(function() local char = LocalPlayer.Character; if char and char:FindFirstChild("Humanoid") then local hum = char.Humanoid; if _G.WsEnabled then hum.WalkSpeed = _G.WsValue elseif _G.AntiSlow and hum.WalkSpeed < 16 then hum.WalkSpeed = 16 end end end) end)

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
RunService.Heartbeat:Connect(function() pcall(function() if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if tick() - _G.LastAttackTime > 0.2 then if hrp.Position.Y < 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame + Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end else if hrp.Position.Y > 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end end end end) end)
RunService.RenderStepped:Connect(function() pcall(function() if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if hrp.Position.Y > 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end; local cp = getFakeCamPart(); cp.CFrame = hrp.CFrame; Camera.CameraSubject = cp end end) end)

local CombatSec = CombatTab:Section({ Title = "Weapon Control", Icon = "crosshair", Opened = true, Box = true })
CombatSec:Toggle({ Title = "M1 Combo Lock + Fast Slash", Desc = "Khóa combo và tăng tốc chém tay an toàn", Value = false, Callback = function(v) _G.FastSlash = v end})
RunService.Heartbeat:Connect(function()
    if _G.FastSlash then pcall(function() local char = LocalPlayer.Character; if char then for _, v in ipairs(char:GetDescendants()) do if v:IsA("ModuleScript") then if string.find(string.lower(v.Name), "weapon") or string.find(string.lower(v.Name), "attack") or string.find(string.lower(v.Name), "stats") then local success, stats = pcall(require, v); if success and type(stats) == "table" and stats.attackCycle then if stats.attackOrder then stats.attackOrder = {"1", "1", "1", "1"} end; for realStat, val in pairs(stats) do local lowerStat = string.lower(realStat); if lowerStat == "attacktime" or lowerStat == "swingtime" or lowerStat == "windup" then if type(val) == "number" and val ~= 0.2 then stats[realStat] = 0.2 end end end; for k, cycle in pairs(stats.attackCycle) do if type(cycle) == "table" and cycle.attackTime and cycle.attackTime ~= 0.2 then cycle.attackTime = 0.2 end end end end end end end end) end
end)
CombatSec:Toggle({ Title = "Enable Anti-Slow", Value = false, Callback = function(v) _G.AntiSlow = v end})
CombatSec:Toggle({ Title = "Ghost Mode (Infinite Invis)", Value = false, Callback = function(v) _G.InfiniteInvis = v end})

local KillSec = CombatTab:Section({ Title = "Ultimate Spam Nuke", Icon = "skull", Opened = true, Box = true })

-- =====================================
-- BỘ MÁY NUKE SPAM KHÔNG GIỚI HẠN (ZERO-LAG)
-- =====================================
local NukeWeaponDef = { 
    attackCycle = { ["1"] = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, 
    attackOrder = {"1"} 
}
local NukeCycleData = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0}

_G.SpamAmount = 50
_G.AttackDelay = 0
KillSec:Slider({ Title = "Spam Amount per Packet", Desc = "Bao nhiêu nhát chém gửi đi trong 1 gói tin? (Kéo tẹt ga không lag)", Value = {Min = 1, Max = 200, Default = 50}, Callback = function(v) _G.SpamAmount = v end})
KillSec:Slider({ Title = "Attack Delay (Seconds)", Desc = "0 = Spam liên tục không nghỉ", Value = {Min = 0, Max = 5, Default = 0}, Callback = function(v) _G.AttackDelay = v end})

_G.KillAll = false
KillSec:Toggle({ Title = "Enable Ultimate Nuke (Kill All)", Desc = "Spam hàng ngàn nhát chém nhưng không tụt FPS", Value = false, Callback = function(v) 
    _G.KillAll = v 
    if v then
        task.spawn(function()
            while _G.KillAll do
                pcall(function()
                    local Char = LocalPlayer.Character
                    local MyTool = Char and Char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
                    if not Char or not MyTool or not Char:FindFirstChild("HumanoidRootPart") then return end
                    
                    local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or Char.HumanoidRootPart.Position
                    local hitArray = {}
                    
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                            local hum = p.Character:FindFirstChild("Humanoid")
                            if hum and hum.Health > 0 then
                                local tPos = p.Character.HumanoidRootPart.Position
                                local dist = (tPos - myPos).Magnitude
                                local dir = dist > 0 and (tPos - myPos).Unit or Vector3.new(0,0,1)
                                
                                -- TẠO ĐÚNG 1 BẢNG DUY NHẤT LÀM MẪU (CHỐNG LAG BỘ NHỚ)
                                local singleHit = {
                                    knockback = 0, isClosestEnemy = true, origin = myPos, 
                                    enemyModel = p.Character, distance = dist, direction = dir
                                }
                                
                                -- NHÂN BẢN THAM CHIẾU (COPY REFERENCE) - ZERO MEMORY COST!
                                for i = 1, _G.SpamAmount do
                                    table.insert(hitArray, singleHit)
                                end
                            end
                        end
                    end
                    
                    if #hitArray > 0 then
                        _G.LastAttackTime = tick()
                        local Args = {
                            "AttemptWeaponHit",
                            {
                                attackCycleData = NukeCycleData, knockback = 0, shouldLock = true, shouldLunge = false, 
                                hitboxOffset = Vector3.new(0, 0, 0), isCritical = true, shouldSlow = false, 
                                attackCooldown = 0, damage = 9e9, lungeKnockback = 0, cycleIndex = 1, slowMult = 1, 
                                hitboxSize = Vector3.new(9e9, 9e9, 9e9), weaponDefinition = NukeWeaponDef, 
                                tool = MyTool, slowTime = 0
                            },
                            hitArray
                        }
                        -- Dùng task.spawn để gói tin bắn đi lập tức mà không chặn vòng lặp
                        task.spawn(function() GameRemote:InvokeServer(table.unpack(Args)) end)
                    end
                end)
                
                -- Thời gian nghỉ giữa các lần Spam. Nếu AttackDelay = 0, nó sẽ chạy mượt theo FPS game.
                if _G.AttackDelay > 0 then task.wait(_G.AttackDelay) else task.wait() end
            end
        end)
    end
end})


local VisSec = VisTab:Section({ Title = "ESP Configurations", Icon = "eye", Opened = true, Box = true })
_G.ESP_Box, _G.ESP_Name, _G.ESP_Chams = false, false, false
VisSec:Toggle({ Title = "Enable 2D Box", Value = false, Callback = function(v) _G.ESP_Box = v end})
VisSec:Toggle({ Title = "Enable Names & Distance", Value = false, Callback = function(v) _G.ESP_Name = v end})
VisSec:Toggle({ Title = "Enable Chams (Highlight)", Value = false, Callback = function(v) _G.ESP_Chams = v end})
local espElements = {}
local function cleanEsp(player) if espElements[player] then pcall(function() espElements[player].Name:Remove(); espElements[player].Box:Remove(); espElements[player].Highlight:Destroy() end); espElements[player] = nil end end
RunService.RenderStepped:Connect(function() pcall(function() local activePlayers = {}; if _G.ESP_Box or _G.ESP_Name or _G.ESP_Chams then for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer then activePlayers[player] = true; local char = player.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart"); local hum = char and char:FindFirstChild("Humanoid"); local head = char and char:FindFirstChild("Head"); if char and hrp and hum and head and hum.Health > 0 then if not espElements[player] then local d = { Name = Drawing.new("Text"), Box = Drawing.new("Square"), Highlight = Instance.new("Highlight") }; d.Name.Size = 16; d.Name.Center = true; d.Name.Outline = true; d.Name.Font = 2; d.Box.Thickness = 1; d.Box.Filled = false; d.Highlight.FillTransparency = 0.5; d.Highlight.OutlineTransparency = 0; d.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; d.Highlight.Parent = char; espElements[player] = d end; local d = espElements[player]; local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position); if onScreen then local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0)); local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0)); local boxHeight = math.abs(headPos.Y - legPos.Y); local boxWidth = boxHeight * 0.6; local boxPos = Vector2.new(rootPos.X - boxWidth / 2, headPos.Y); local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0; local teamColor = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 50, 50); d.Box.Size = Vector2.new(boxWidth, boxHeight); d.Box.Position = boxPos; d.Box.Color = teamColor; d.Box.Visible = _G.ESP_Box; d.Name.Color = teamColor; d.Name.Text = player.Name .. " ["..math.floor(dist).."m]"; d.Name.Position = Vector2.new(rootPos.X, headPos.Y - 20); d.Name.Visible = _G.ESP_Name; d.Highlight.FillColor = teamColor; d.Highlight.Parent = char; d.Highlight.Enabled = _G.ESP_Chams else d.Name.Visible = false; d.Box.Visible = false; d.Highlight.Enabled = false end else cleanEsp(player) end end end end; for player, _ in pairs(espElements) do if not activePlayers[player] then cleanEsp(player) end end end) end)

local PlayerSec = PlayerTab:Section({ Title = "Server Players", Icon = "users", Opened = true, Box = true })
local playerNames = {}
local PlayerDropdown = PlayerSec:Dropdown({ Title = "Select Player", Values = {"None"}, Callback = function(sel) _G.SelectedPlayer = sel end})
local function refreshPlayers() playerNames = {}; for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(playerNames, p.Name) end end; PlayerDropdown:Refresh(playerNames) end
PlayerSec:Divider()
PlayerSec:Button({ Title = "Refresh Player List", Icon = "refresh-cw", Callback = refreshPlayers })
PlayerSec:Button({ Title = "Teleport To Player", Icon = "map-pin", Callback = function() pcall(function() local target = Players:FindFirstChild(_G.SelectedPlayer); if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame; WindUI:Notify({Title = "Teleport", Content = "Teleported to " .. target.Name, Duration=2}) end end) end})
refreshPlayers()

local ThemeSection = SettingTab:Section({ Title = "Themes", Icon = "palette", Opened = true, Box = true })
local validThemes = WindUI:GetThemes(); local themes = {}
for themeName, _ in pairs(validThemes) do table.insert(themes, themeName) end; table.sort(themes)
ThemeSection:Dropdown({ Title = "Theme", Desc = "Choose UI Style", Values = themes, Flag = "ThemeDropdown", Value = "Dark", Callback = function(Value) if validThemes[Value] then pcall(function() WindUI:SetTheme(Value) end) end end })

SettingTab:Space()
local ConfigSection = SettingTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local ConfigManager = Window.ConfigManager
local configName = "Configs"
local configFile = ConfigManager:CreateConfig(configName)
local savedConfigs = ConfigManager:AllConfigs()

local function getAutoLoad() pcall(function() if isfile and isfile("AutoLoad.txt") then return readfile("AutoLoad.txt") end end); return "none" end
local function setAutoLoad(name) pcall(function() if writefile then writefile("AutoLoad.txt", name) end end) end

if #savedConfigs == 0 then table.insert(savedConfigs, "Configs") end
local ConfigInput = ConfigSection:Input({ Title = "Config Name", Value = configName, Callback = function(value) configName = value or "Configs" end })
local AutoLoadToggle = ConfigSection:Toggle({ Title = "Auto-Load Config", Value = (getAutoLoad() == configName), Callback = function(Value) if Value then setAutoLoad(configName) else setAutoLoad("none") end end })
local ConfigDropdown = ConfigSection:Dropdown({ Title = "Choose Saved Config", Values = savedConfigs, Value = configName, AllowNone = false, Callback = function(value) configName = value or "Configs"; ConfigInput:Set(configName); if AutoLoadToggle then AutoLoadToggle:Set(getAutoLoad() == configName) end end })
ConfigSection:Button({ Title = "Save Config", Icon = "check", Callback = function() configFile = ConfigManager:CreateConfig(configName); if configFile:Save() then local newList = ConfigManager:AllConfigs(); if #newList == 0 then table.insert(newList, "Configs") end; ConfigDropdown:Refresh(newList); WindUI:Notify({ Title = "Save Config", Content = "Saved: " .. configName, Duration = 3 }) end end })
ConfigSection:Button({ Title = "Load Config", Icon = "refresh-cw", Callback = function() configFile = ConfigManager:CreateConfig(configName); if configFile:Load() then WindUI:Notify({ Title = "Load Config", Content = "Loaded: " .. configName, Duration = 3 }) end end })

Window:OnClose(function() if ConfigManager and configFile then configFile:Save() end end)

task.spawn(function()
    task.wait(1.5)
    local autoConf = getAutoLoad()
    if autoConf ~= "none" then
        configName = autoConf; configFile = ConfigManager:CreateConfig(configName)
        pcall(function() configFile:Load(); WindUI:Notify({ Title = "Auto-Load Enabled", Content = "Loaded config: " .. configName, Duration = 3 }) end)
    end
    task.wait(0.5)
    pcall(function() Window:Minimize() end)
    pcall(function() Window:Toggle() end)
end)

ThemeSection:Keybind({ Title = "Keybind", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

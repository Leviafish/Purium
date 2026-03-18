print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Script...", Duration = 3 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Silent Assassin |", Icon = "door-open", Author = "Version : 2.8.0 Fast-CD", Folder = "Purium_Silent-Assassin",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})

Window:EditOpenButton({ Title = "Open UI", Icon = "monitor", CornerRadius = UDim.new(0,16), StrokeThickness = 2, Color = ColorSequence.new(Color3.fromHex("1e1e1e"), Color3.fromHex("000000")), OnlyMobile = false, Enabled = true, Draggable = true })

WindUI:AddTheme({ Name = "Amethyst", Accent = Color3.fromHex("7E2CB6"), Dialog = Color3.fromHex("321E46"), Outline = Color3.fromHex("552D78"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("280C47"), Button = Color3.fromHex("733796"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("7E2CB6"), Slider = Color3.fromHex("7E2CB6"), Checkbox = Color3.fromHex("7E2CB6"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("7E2CB6"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
WindUI:AddTheme({ Name = "AMOLED", Accent = Color3.fromHex("FFFFFF"), Dialog = Color3.fromHex("000000"), Outline = Color3.fromHex("141414"), Text = Color3.fromHex("FFFFFF"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("000000"), Button = Color3.fromHex("0F0F0F"), Icon = Color3.fromHex("FFFFFF"), Toggle = Color3.fromHex("FFFFFF"), Slider = Color3.fromHex("FFFFFF"), Checkbox = Color3.fromHex("FFFFFF"), PanelBackground = Color3.fromHex("000000"), PanelBackgroundTransparency = 0, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("FFFFFF"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0 })

Window:Tag({ Title = "v2.8.0 (Fast CD & Gacha Fix)", Icon = "zap", Color = Color3.fromRGB(0, 255, 150), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

_G.AntiSlow = false
_G.FastCooldown = false
_G.AntiKickEnabled = false
_G.InfiniteInvis = false
_G.LastAttackTime = 0

-- LÕI HOOK (CHỈNH SỬA TỐC ĐỘ CHÉM THÀNH 0.05 THAY VÌ 0)
local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() then
        if _G.AntiKickEnabled and (method == "Kick" or method == "kick") then return nil end
        
        if method == "InvokeServer" or method == "FireServer" then
            -- Chặn lột tàng hình
            if _G.InfiniteInvis and args[1] == "SendMessage" and args[2] == "WeaponSwung" then return nil end
            
            -- Ép tốc độ chém và chống chậm
            if (_G.FastCooldown or _G.AntiSlow) and args[1] == "AttemptWeaponHit" and type(args[2]) == "table" then
                if _G.AntiSlow then args[2].shouldSlow = false end
                
                if args[2].attackCycleData then 
                    if _G.AntiSlow then args[2].attackCycleData.slowMult = 1; args[2].attackCycleData.slowTime = 0 end
                    if _G.FastCooldown then args[2].attackCycleData.attackTime = 0.05 end
                end
                
                if args[2].weaponDefinition and args[2].weaponDefinition.attackCycle then
                    for k, v in pairs(args[2].weaponDefinition.attackCycle) do 
                        if _G.AntiSlow then v.slowMult = 1; v.slowTime = 0 end
                        if _G.FastCooldown then v.attackTime = 0.05 end
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

local function getNearestTarget()
    local nearest, minDist = nil, math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - char.HumanoidRootPart.Position).Magnitude
                if dist < minDist then minDist = dist; nearest = p.Character end
            end
        end
    end
    return nearest
end

-- =====================================
-- TAB AUTO GACHA (CHUẨN 100%)
-- =====================================
local GachaSec = GachaTab:Section({ Title = "Auto Open Chests", Icon = "shopping-cart", Opened = true, Box = true })
_G.AutoGacha = false
_G.GachaType = "Basic" 

GachaSec:Dropdown({ Title = "Select Chest Type", Values = {"Basic", "Divine"}, Value = "Basic", Callback = function(v) 
    _G.GachaType = v 
end})

GachaSec:Toggle({ Title = "Enable Auto Gacha", Desc = "Tự động mua rương liên tục", Value = false, Callback = function(v) 
    _G.AutoGacha = v 
    if v then
        task.spawn(function()
            while _G.AutoGacha do
                pcall(function()
                    local args = {
                        [1] = "AttemptRollGachaChest",
                        [2] = _G.GachaType
                    }
                    GameRemote:InvokeServer(table.unpack(args))
                end)
                task.wait(1.5) -- Trễ 1.5 giây để tránh sập game hoặc bị kick
            end
        end)
    end
end})

-- =====================================
-- TAB MOVEMENT & FLING
-- =====================================
local MoveSec = MoveTab:Section({ Title = "Character Modification", Icon = "user", Opened = true, Box = true })
local noclipLoop
MoveSec:Toggle({ Title = "Enable Noclip", Desc = "Walk through walls", Value = false, Callback = function(v)
    if v then noclipLoop = RunService.Stepped:Connect(function() pcall(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end end) end) else if noclipLoop then noclipLoop:Disconnect(); noclipLoop = nil end end
end})

_G.WsEnabled, _G.WsValue = false, 25
MoveSec:Toggle({ Title = "Enable WalkSpeed", Value = false, Callback = function(v) _G.WsEnabled = v; if not v then pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end) end end})
MoveSec:Slider({ Title = "Speed Amount", Value = {Min = 16, Max = 1500, Default = 25}, Callback = function(v) _G.WsValue = v end})

_G.JpEnabled, _G.JpValue = false, 100
MoveSec:Toggle({ Title = "Enable JumpPower", Value = false, Callback = function(v) _G.JpEnabled = v; if not v then pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 50 end) end end})
MoveSec:Slider({ Title = "Jump Amount", Value = {Min = 50, Max = 1500, Default = 100}, Callback = function(v) _G.JpValue = v end})

RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            if _G.WsEnabled then hum.WalkSpeed = _G.WsValue elseif _G.AntiSlow and hum.WalkSpeed < 16 then hum.WalkSpeed = 16 end
            if _G.JpEnabled then hum.JumpPower = _G.JpValue end
        end
    end)
end)

local FlingSec = MoveTab:Section({ Title = "Physics Fling Exploits", Icon = "wind", Opened = true, Box = true })
_G.AntiFling = false
FlingSec:Toggle({ Title = "Anti Fling (God Collision)", Value = false, Callback = function(v) _G.AntiFling = v end})
_G.FlingMode = "Spin Fling"
FlingSec:Dropdown({ Title = "Select Fling Mode", Values = {"Spin Fling", "Teleport & Fling", "Touch Fling"}, Value = "Spin Fling", Callback = function(v) _G.FlingMode = v end})
_G.FlingTarget = ""
FlingSec:Input({ Title = "Target Name (For Teleport)", Value = "", Callback = function(v) _G.FlingTarget = v end})
_G.FlingPower = 50000
FlingSec:Slider({ Title = "Fling Power", Value = {Min = 1000, Max = 100000, Default = 50000}, Callback = function(v) _G.FlingPower = v end})
_G.FlingActive = false
FlingSec:Toggle({ Title = "Enable Fling", Value = false, Callback = function(v) 
    _G.FlingActive = v 
    if not v then pcall(function() local hrp = LocalPlayer.Character.HumanoidRootPart; hrp.AssemblyAngularVelocity = Vector3.new(0,0,0); local bav = hrp:FindFirstChild("PuriumFlingBAV"); if bav then bav:Destroy() end end) end
end})

RunService.Stepped:Connect(function() pcall(function() if _G.AntiFling and not _G.FlingActive and LocalPlayer.Character then for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and p.Character then for _, part in ipairs(p.Character:GetChildren()) do if part:IsA("BasePart") then part.CanCollide = false end end end end end end) end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        if _G.FlingActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics) end

            if _G.FlingMode == "Spin Fling" then
                local bav = hrp:FindFirstChild("PuriumFlingBAV")
                if not bav then bav = Instance.new("BodyAngularVelocity"); bav.Name = "PuriumFlingBAV"; bav.MaxTorque = Vector3.new(0, math.huge, 0); bav.P = math.huge; bav.Parent = hrp end
                bav.AngularVelocity = Vector3.new(0, _G.FlingPower, 0)
            elseif _G.FlingMode == "Touch Fling" then
                local bav = hrp:FindFirstChild("PuriumFlingBAV"); if bav then bav:Destroy() end
                hrp.AssemblyAngularVelocity = Vector3.new(0, _G.FlingPower, 0); hrp.AssemblyLinearVelocity = Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
            elseif _G.FlingMode == "Teleport & Fling" then
                local bav = hrp:FindFirstChild("PuriumFlingBAV"); if bav then bav:Destroy() end
                if _G.FlingTarget ~= "" then
                    local tPlayer = nil
                    for _, p in ipairs(Players:GetPlayers()) do if p ~= LocalPlayer and string.find(string.lower(p.Name), string.lower(_G.FlingTarget)) then tPlayer = p; break end end
                    if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        hrp.CFrame = tPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(math.random(-1,1), math.random(-1,1), math.random(-1,1))
                        hrp.AssemblyAngularVelocity = Vector3.new(math.random(-_G.FlingPower, _G.FlingPower), math.random(-_G.FlingPower, _G.FlingPower), math.random(-_G.FlingPower, _G.FlingPower))
                        hrp.AssemblyLinearVelocity = Vector3.new(math.random(-_G.FlingPower, _G.FlingPower), math.random(-_G.FlingPower, _G.FlingPower), math.random(-_G.FlingPower, _G.FlingPower))
                    end
                end
            end
        else
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") and LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Physics then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) end
        end
    end)
end)

local GodModeSec = BypassTab:Section({ Title = "God Mode & Heal", Icon = "heart", Opened = true, Box = true })
_G.DesyncGodMode = false
GodModeSec:Toggle({ Title = "God Mode (Desync)", Value = false, Callback = function(v) 
    _G.DesyncGodMode = v 
    pcall(function()
        if not v then
            local cp = Workspace:FindFirstChild("PuriumCamPart"); if cp then cp:Destroy() end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = LocalPlayer.Character.Humanoid end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                if hrp.Position.Y > 20000 then hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0) end
            end
        end
    end)
end})

local function getFakeCamPart()
    local cp = Workspace:FindFirstChild("PuriumCamPart")
    if not cp then cp = Instance.new("Part"); cp.Name = "PuriumCamPart"; cp.Transparency = 1; cp.CanCollide = false; cp.Anchored = true; cp.Massless = true; cp.Size = Vector3.new(1, 1, 1); cp.Parent = Workspace end
    return cp
end

RunService.Heartbeat:Connect(function() pcall(function() if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if tick() - _G.LastAttackTime > 0.2 then if hrp.Position.Y < 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame + Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end else if hrp.Position.Y > 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end end end end) end)
RunService.RenderStepped:Connect(function() pcall(function() if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if hrp.Position.Y > 20000 then local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity; hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0); hrp.AssemblyLinearVelocity = vel; hrp.AssemblyAngularVelocity = rot end; local cp = getFakeCamPart(); cp.CFrame = hrp.CFrame; Camera.CameraSubject = cp end end) end)

_G.GodModeEnabled = false; _G.HealthValue = 5000
GodModeSec:Toggle({ Title = "Auto Heal (Custom HP Bypass)", Value = false, Callback = function(v) _G.GodModeEnabled = v end})
GodModeSec:Slider({ Title = "Health Amount", Value = {Min = 100, Max = 100000, Default = 5000}, Callback = function(v) _G.HealthValue = v end})

RunService.Heartbeat:Connect(function()
    if _G.GodModeEnabled then pcall(function() local char = LocalPlayer.Character; if char and char:FindFirstChild("Humanoid") then local hum = char.Humanoid; if hum.MaxHealth < _G.HealthValue then hum.MaxHealth = _G.HealthValue end; if hum.Health < _G.HealthValue then hum.Health = _G.HealthValue end end; local function healCustom(parentObj) if not parentObj then return end; for _, v in pairs(parentObj:GetDescendants()) do if v:IsA("ValueBase") or v:IsA("NumberValue") or v:IsA("IntValue") then local n = string.lower(v.Name); if n == "health" or n == "hp" or n == "currenthealth" or n == "maxhealth" or n == "maxhp" then if type(v.Value) == "number" and v.Value < _G.HealthValue then v.Value = _G.HealthValue end end end end end; healCustom(LocalPlayer.Character); healCustom(LocalPlayer) end) end
end)

local CombatSec = CombatTab:Section({ Title = "Weapon Control", Icon = "crosshair", Opened = true, Box = true })

local moddedTools = {}
CombatSec:Toggle({ Title = "Fast Cooldown (Chém siêu tốc)", Desc = "Giảm độ trễ vũ khí xuống 0.05s thay vì 0 để chống kẹt", Value = false, Callback = function(v) 
    _G.FastCooldown = v 
    if not v then moddedTools = {} end 
end})

RunService.Heartbeat:Connect(function()
    if _G.FastCooldown then
        pcall(function()
            local char = LocalPlayer.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool")
                if tool and not moddedTools[tool] then
                    moddedTools[tool] = true
                    for _, v in pairs(tool:GetDescendants()) do
                        if v:IsA("ModuleScript") then
                            local success, stats = pcall(require, v)
                            if success and type(stats) == "table" then
                                for realStat, val in pairs(stats) do
                                    local lowerStat = string.lower(realStat)
                                    if lowerStat:match("cooldown") or lowerStat:match("delay") or lowerStat:match("rate") or lowerStat:match("debounce") or lowerStat:match("time") then
                                        if type(val) == "number" and val > 0 then
                                            stats[realStat] = 0.05 -- Gán mức 0.05 để tránh lỗi Divide by zero
                                        end
                                    end
                                end
                            end
                        elseif v:IsA("NumberValue") or v:IsA("IntValue") then
                            local lowerName = string.lower(v.Name)
                            if lowerName:match("cooldown") or lowerName:match("delay") or lowerName:match("rate") or lowerName:match("debounce") then
                                v.Value = 0.05
                            end
                        end
                    end
                end
            end
        end)
    end
end)

CombatSec:Toggle({ Title = "Enable Anti-Slow", Desc = "Chém không bị chậm tốc độ chạy", Value = false, Callback = function(v) _G.AntiSlow = v end})
CombatSec:Toggle({ Title = "Ghost Mode (Infinite Invis)", Desc = "Chặn server lột tàng hình", Value = false, Callback = function(v) _G.InfiniteInvis = v end})

local KillSec = CombatTab:Section({ Title = "Kill Functions", Icon = "skull", Opened = true, Box = true })

_G.AttackDelay = 0
KillSec:Slider({ Title = "Attack Delay (Seconds)", Value = {Min = 0, Max = 10, Default = 0}, Callback = function(v) _G.AttackDelay = v end})

_G.HitsPerPacket = 50 
KillSec:Slider({ Title = "Hits Per Seconds", Desc = "Multiplier (50-150)", Value = {Min = 1, Max = 1000, Default = 50}, Callback = function(v) _G.HitsPerPacket = v end})

local function BuildHitData(TargetChar)
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return {} end
    if not TargetChar or not TargetChar:FindFirstChild("HumanoidRootPart") then return {} end
    local myHrp = Char.HumanoidRootPart
    local tHrp = TargetChar.HumanoidRootPart
    local dist = (tHrp.Position - myHrp.Position).Magnitude
    local dir = (tHrp.Position - myHrp.Position).Unit
    if dist == 0 then dir = Vector3.new(0, 0, 1) end
    local targetArray = {}
    for i = 1, _G.HitsPerPacket do table.insert(targetArray, {knockback = 0, isClosestEnemy = true, origin = myHrp.Position, enemyModel = TargetChar, distance = dist, direction = dir}) end
    return targetArray
end

local function FireCombatRequest(targetArray)
    if #targetArray == 0 then return end
    local Char = LocalPlayer.Character
    local MyTool = Char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not MyTool then return end

    _G.LastAttackTime = tick()
    local isSlow = not _G.AntiSlow
    local slowMul = _G.AntiSlow and 1 or 0.2
    local slowTim = _G.AntiSlow and 0 or 1.5

    local Args = {
        "AttemptWeaponHit",
        {
            attackCycleData = {knockbackMul=0,slowMult=slowMul,attackTime=0,lungeMul=0,slowTime=slowTim},
            knockback = 0, shouldLock = true, shouldLunge = false, hitboxOffset = Vector3.new(0, 0, 0), isCritical = true, shouldSlow = isSlow,
            attackCooldown = 0, damage = 9e9, lungeKnockback = 0, cycleIndex = 1, slowMult = slowMul, 
            hitboxSize = Vector3.new(9e9, 9e9, 9e9), 
            weaponDefinition = { attackCycle = { ["1"] = {knockbackMul=0, slowMult=slowMul, attackTime=0, lungeMul=0, slowTime=slowTim, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, attackOrder = {"1", "1", "1", "1"} },
            tool = MyTool, slowTime = slowTim
        },
        targetArray
    }
    task.spawn(function() pcall(function() GameRemote:InvokeServer(table.unpack(Args)) end) end)
end

_G.KillAll = false
KillSec:Toggle({ Title = "Kill All Players (Perfect Nuke)", Value = false, Callback = function(v) 
    _G.KillAll = v 
    if v then
        task.spawn(function()
            while _G.KillAll do
                pcall(function()
                    local fullArray = {}
                    local Char = LocalPlayer.Character
                    if Char and Char:FindFirstChild("HumanoidRootPart") then
                        for _, p in ipairs(Players:GetPlayers()) do
                            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                                local hum = p.Character:FindFirstChild("Humanoid")
                                if hum and hum.Health > 0 then
                                    local data = BuildHitData(p.Character)
                                    for _, hit in ipairs(data) do table.insert(fullArray, hit) end
                                end
                            end
                        end
                        if #fullArray > 0 then FireCombatRequest(fullArray) end
                    end
                end)
                if _G.AttackDelay > 0 then task.wait(_G.AttackDelay) else task.wait(0.1) end
            end
        end)
    end
end})

_G.AutoHit = false
_G.HitRange = 15
KillSec:Toggle({ Title = "Auto Hit By Distance", Value = false, Callback = function(v) _G.AutoHit = v end})
KillSec:Slider({ Title = "Auto Hit Range", Value = {Min = 5, Max = 1000, Default = 15}, Callback = function(v) _G.HitRange = v end})

task.spawn(function()
    while true do
        task.wait()
        if _G.AutoHit and not _G.KillAll then
            pcall(function()
                local Char = LocalPlayer.Character
                if Char and Char:FindFirstChild("HumanoidRootPart") then
                    local target = getNearestTarget()
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or Char.HumanoidRootPart.Position
                        local dist = (target.HumanoidRootPart.Position - myPos).Magnitude
                        if dist <= _G.HitRange then 
                            local data = BuildHitData(target)
                            if #data > 0 then FireCombatRequest(data) end
                        end
                    end
                end
            end)
            task.wait(math.max(_G.AttackDelay, 0.03))
        end
    end
end)

local VisSec = VisTab:Section({ Title = "ESP Configurations", Icon = "eye", Opened = true, Box = true })
_G.ESP_Box, _G.ESP_Name, _G.ESP_Chams = false, false, false
VisSec:Toggle({ Title = "Enable 2D Box", Value = false, Callback = function(v) _G.ESP_Box = v end})
VisSec:Toggle({ Title = "Enable Names & Distance", Value = false, Callback = function(v) _G.ESP_Name = v end})
VisSec:Toggle({ Title = "Enable Chams (Highlight)", Value = false, Callback = function(v) _G.ESP_Chams = v end})

local espElements = {}
local function cleanEsp(player) if espElements[player] then pcall(function() espElements[player].Name:Remove(); espElements[player].Box:Remove(); espElements[player].Highlight:Destroy() end); espElements[player] = nil end end

RunService.RenderStepped:Connect(function()
    pcall(function()
        local activePlayers = {}
        if _G.ESP_Box or _G.ESP_Name or _G.ESP_Chams then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    activePlayers[player] = true
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    local hum = char and char:FindFirstChild("Humanoid")
                    local head = char and char:FindFirstChild("Head")
                    if char and hrp and hum and head and hum.Health > 0 then
                        if not espElements[player] then
                            local d = { Name = Drawing.new("Text"), Box = Drawing.new("Square"), Highlight = Instance.new("Highlight") }
                            d.Name.Size = 16; d.Name.Center = true; d.Name.Outline = true; d.Name.Font = 2
                            d.Box.Thickness = 1; d.Box.Filled = false
                            d.Highlight.FillTransparency = 0.5; d.Highlight.OutlineTransparency = 0; d.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; d.Highlight.Parent = char
                            espElements[player] = d
                        end
                        local d = espElements[player]
                        local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                        if onScreen then
                            local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                            local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                            local boxHeight = math.abs(headPos.Y - legPos.Y)
                            local boxWidth = boxHeight * 0.6
                            local boxPos = Vector2.new(rootPos.X - boxWidth / 2, headPos.Y)
                            local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
                            local teamColor = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 50, 50)
                            d.Box.Size = Vector2.new(boxWidth, boxHeight); d.Box.Position = boxPos; d.Box.Color = teamColor; d.Box.Visible = _G.ESP_Box
                            d.Name.Color = teamColor; d.Name.Text = player.Name .. " ["..math.floor(dist).."m]"; d.Name.Position = Vector2.new(rootPos.X, headPos.Y - 20); d.Name.Visible = _G.ESP_Name
                            d.Highlight.FillColor = teamColor; d.Highlight.Parent = char; d.Highlight.Enabled = _G.ESP_Chams
                        else 
                            d.Name.Visible = false; d.Box.Visible = false; d.Highlight.Enabled = false
                        end
                    else cleanEsp(player) end
                end
            end
        end
        for player, _ in pairs(espElements) do if not activePlayers[player] then cleanEsp(player) end end
    end)
end)

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
local AutoLoadToggle
local ConfigDropdown = ConfigSection:Dropdown({ Title = "Choose Saved Config", Values = savedConfigs, Value = configName, AllowNone = false, Callback = function(value) configName = value or "Configs"; ConfigInput:Set(configName); if AutoLoadToggle then AutoLoadToggle:Set(getAutoLoad() == configName) end end })

AutoLoadToggle = ConfigSection:Toggle({ Title = "Auto-Load Config", Value = (getAutoLoad() == configName), Callback = function(Value) if Value then setAutoLoad(configName) else setAutoLoad("none") end end })
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
    WindUI:Notify({ Title = "UI Minimized", Content = "Click open UI button to reopen.", Duration = 5 })
end)

ThemeSection:Keybind({ Title = "Keybind", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

print("Successfully loaded all assets! Purium on Top!")

--[[
    PURIUM V8.0 SINGULARITY - ULTIMATE HvH EDITION
    Optimized for: Performance, Network Efficiency, and Anti-Cheat Bypass
]]

print("Initializing Purium V8.0 Singularity...")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium V8.0", Text = "Singularity Engine & Metatable Hooked!", Duration = 5 })

-- TỐI ƯU HÓA HỆ THỐNG
pcall(function() if setfpscap then setfpscap(100) end end)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub | Singularity V8 |", Icon = "orbit", Author = "By @hlck49", Folder = "Purium_V8",
    Size = UDim2.fromOffset(580, 460), Transparent = true, Theme = "Dark", Resizable = true,
    User = { Enabled = true, Anonymous = true }
})

Window:EditOpenButton({ Title = "Open Purium", Icon = "monitor", CornerRadius = UDim.new(0,16), Draggable = true })
Window:Tag({ Title = "SINGULARITY", Icon = "zap", Color = Color3.fromRGB(0, 255, 150), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

-- BIẾN ĐIỀU KHIỂN TOÀN CỤC
_G.MasterBypass = true
_G.BlockNewIndex = true
_G.SpoofStats = true
_G.FastSlash = false
_G.StripIdleAnim = false
_G.AntiSlow = false
_G.AntiKickEnabled = false
_G.GodModeEnabled = false
_G.ParallelAura = false
_G.AuraRadius = 500
_G.AuraSpam = 20
_G.AuraDelay = 0.05
_G.LastAttackTime = 0

-- =======================================================
-- LÕI HOOK TỐI THƯỢNG (Metatable 3 Lớp)
-- =======================================================
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
local oldNamecall = mt.__namecall
setreadonly(mt, false)

-- 1. INDEX HOOK (Lừa Anti-cheat)
mt.__index = newcclosure(function(self, key)
    if not checkcaller() and _G.MasterBypass and _G.SpoofStats then
        if key == "WalkSpeed" then return 16 end
        if key == "JumpPower" then return 50 end
    end
    return oldIndex(self, key)
end)

-- 2. NEWINDEX HOOK (Chặn Server/Hacker khác chỉnh sửa bạn)
mt.__newindex = newcclosure(function(self, key, value)
    if not checkcaller() and _G.MasterBypass and _G.BlockNewIndex then
        if key == "WalkSpeed" and value < 16 then return end
        if key == "Health" and _G.GodModeEnabled and value < 100 then return end
    end
    return oldNewIndex(self, key, value)
end)

-- 3. NAMECALL HOOK (Chặn lệnh & Animation Stripping)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() then
        if _G.AntiKickEnabled and (method == "Kick" or method == "kick") then return nil end
        
        -- ANIMATION STRIPPING (Xóa cầm kiếm, giữ chém nhanh)
        if method == "Play" or method == "play" then
            if self:IsA("AnimationTrack") then
                local animId = string.lower(self.Animation.AnimationId)
                if _G.StripIdleAnim and (string.find(animId, "idle") or string.find(animId, "hold") or string.find(animId, "equip")) then
                    return nil -- Xóa animation cầm kiếm
                end
                if _G.FastSlash and (string.find(animId, "attack") or string.find(animId, "slash") or string.find(animId, "swing")) then
                    self.Speed = 100 -- Ép chém siêu tốc
                end
            end
        end

        -- REMOTE MASKING & BATCH FIRE
        if (method == "InvokeServer" or method == "FireServer") and args[1] == "AttemptWeaponHit" then
            if _G.AntiSlow or _G.FastSlash then
                local data = args[2]
                if type(data) == "table" then
                    data.shouldSlow = false
                    if data.attackCycleData then data.attackCycleData.slowTime = 0; data.attackCycleData.slowMult = 1 end
                end
            end
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- =======================================================
-- GIAO DIỆN ĐIỀU KHIỂN
-- =======================================================
local BypassTab = Window:Tab({ Title = "Bypass & Shield", Icon = "shield" })
local CombatTab = Window:Tab({ Title = "Singularity Engine", Icon = "zap" })
local MoveTab = Window:Tab({ Title = "Movement", Icon = "move" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

-- PHẦN BYPASS
local ShieldSec = BypassTab:Section({ Title = "Anti-Cheat Protection", Icon = "shield-check", Opened = true, Box = true })
ShieldSec:Toggle({ Title = "Master Bypass", Value = true, Callback = function(v) _G.MasterBypass = v end })
ShieldSec:Toggle({ Title = "Spoof Stats (Index)", Value = true, Callback = function(v) _G.SpoofStats = v end })
ShieldSec:Toggle({ Title = "Block Server Edit (NewIndex)", Value = true, Callback = function(v) _G.BlockNewIndex = v end })
ShieldSec:Toggle({ Title = "Anti-Kick Shield", Value = false, Callback = function(v) _G.AntiKickEnabled = v end })

-- PHẦN COMBAT (SINGULARITY ENGINE)
local KillSec = CombatTab:Section({ Title = "KILL ENGINE", Icon = "target", Opened = true, Box = true })
local NukeWeaponDef = { attackCycle = { ["1"] = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, attackOrder = {"1"} }
local NukeCycleData = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0}

KillSec:Toggle({ Title = "Fast Slash (No Delay)", Value = false, Callback = function(v) _G.FastSlash = v end })
KillSec:Toggle({ Title = "Strip Idle Animations", Value = false, Callback = function(v) _G.StripIdleAnim = v end })
KillSec:Toggle({ Title = "Enable Singularity Nuke", Value = false, Callback = function(v) _G.ParallelAura = v end })
KillSec:Slider({ Title = "Aura Radius", Value = {Min = 50, Max = 5000, Default = 500}, Callback = function(v) _G.AuraRadius = v end })
KillSec:Slider({ Title = "Hits Per Target (Batch)", Value = {Min = 1, Max = 100, Default = 20}, Callback = function(v) _G.AuraSpam = v end })

-- PHẦN MOVEMENT
local MoveSec = MoveTab:Section({ Title = "Movement", Icon = "user", Opened = true, Box = true })
_G.WsEnabled, _G.WsValue = false, 16
MoveSec:Toggle({ Title = "Enable Speed", Value = false, Callback = function(v) _G.WsEnabled = v end })
MoveSec:Slider({ Title = "Speed Value", Value = {Min = 16, Max = 500, Default = 16}, Callback = function(v) _G.WsValue = v end })

-- =======================================================
-- LÕI XỬ LÝ (SPATIAL QUERY & BATCH FIRE)
-- =======================================================
local SpatialParams = OverlapParams.new()
SpatialParams.FilterType = Enum.RaycastFilterType.Exclude

local lastNukeTick = 0

RunService.PostSimulation:Connect(function()
    if _G.WsEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = _G.WsValue
    end

    if not _G.ParallelAura then return end
    if tick() - lastNukeTick < _G.AuraDelay then return end
    lastNukeTick = tick()

    local Char = LocalPlayer.Character
    local MyTool = Char and Char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not Char or not MyTool or not Char:FindFirstChild("HumanoidRootPart") then return end
    
    SpatialParams.FilterDescendantsInstances = {Char, Workspace.Terrain}
    
    task.defer(function()
        local parts = Workspace:GetPartBoundsInRadius(Char.HumanoidRootPart.Position, _G.AuraRadius, SpatialParams)
        local targets = {}
        local processed = {}
        
        for _, p in ipairs(parts) do
            local m = p.Parent
            if m and m:IsA("Model") and not processed[m] then
                processed[m] = true
                local h = m:FindFirstChild("Humanoid")
                if h and h.Health > 0 and m ~= Char then table.insert(targets, m) end
            end
        end

        if #targets > 0 then
            local hitArray = {}
            for _, t in ipairs(targets) do
                local hrp = t:FindFirstChild("HumanoidRootPart")
                if hrp then
                    local data = { knockback = 0, isClosestEnemy = true, origin = Char.HumanoidRootPart.Position, enemyModel = t, distance = (hrp.Position - Char.HumanoidRootPart.Position).Magnitude, direction = Vector3.zAxis }
                    for i = 1, _G.AuraSpam do table.insert(hitArray, data) end
                end
            end
            
            task.spawn(function()
                pcall(function() 
                    GameRemote:InvokeServer("AttemptWeaponHit", {
                        attackCycleData = NukeCycleData, weaponDefinition = NukeWeaponDef, tool = MyTool,
                        damage = 9e9, hitboxSize = Vector3.new(9e9, 9e9, 9e9), isCritical = true, shouldSlow = false
                    }, hitArray)
                end)
            end)
        end
    end)
end)

-- SETTINGS
local ThemeSection = SettingTab:Section({ Title = "Themes", Icon = "palette", Opened = true, Box = true })
local themes = {}
for name, _ in pairs(WindUI:GetThemes()) do table.insert(themes, name) end
ThemeSection:Dropdown({ Title = "Theme", Values = themes, Value = "Dark", Callback = function(v) WindUI:SetTheme(v) end })
ThemeSection:Keybind({ Title = "Toggle Key", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

print("Purium V8.0 Singularity Loaded Successfully!")

--[[
    PURIUM V8.0 SINGULARITY ULTIMATE
    Features: Parallel Luau, Spatial Query, 3-Layer Metatable Hooking, Animation Decoupling
]]

print("Loading V8.0 SINGULARITY ENGINE...")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium V8.0", Text = "Singularity Engine & Anim Bypass Injected!", Duration = 3 })

-- ÉP 100 FPS
pcall(function() if setfpscap then setfpscap(100) end end)

local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Singularity |", Icon = "orbit", Author = "Version : 8.0 Ultimate", Folder = "Purium_V8",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium God") end }
})

Window:EditOpenButton({ Title = "Open UI", Icon = "monitor", CornerRadius = UDim.new(0,16), StrokeThickness = 2, Color = ColorSequence.new(Color3.fromHex("1e1e1e"), Color3.fromHex("000000")), OnlyMobile = false, Enabled = true, Draggable = true })
Window:Tag({ Title = "v8.0 (Singularity)", Icon = "zap", Color = Color3.fromRGB(0, 255, 150), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

-- BIẾN ĐIỀU KHIỂN
_G.MasterBypass = true
_G.FastSlash = false
_G.AntiSlow = false
_G.AntiKickEnabled = false
_G.GodModeEnabled = false
_G.ParallelAura = false
_G.AuraRadius = 500
_G.AuraSpam = 20
_G.AuraDelay = 0.1

-- =======================================================
-- LÕI HOOK TỐI THƯỢNG (Index, NewIndex, Namecall)
-- =======================================================
local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if not checkcaller() and _G.MasterBypass then
        if key == "WalkSpeed" then return 16 end
        if key == "JumpPower" then return 50 end
    end
    return oldIndex(self, key)
end)

mt.__newindex = newcclosure(function(self, key, value)
    if not checkcaller() and _G.MasterBypass then
        if key == "WalkSpeed" and value < 16 then return end
        if key == "Health" and _G.GodModeEnabled and value < 100 then return end
    end
    return oldNewIndex(self, key, value)
end)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() then
        if _G.AntiKickEnabled and (method == "Kick" or method == "kick") then return nil end
        
        -- ANIMATION BYPASS (SỬA LỖI FAST SLASH)
        -- Chặn hoặc tăng tốc độ Animation khi chém
        if _G.FastSlash and method == "Play" and self:IsA("AnimationTrack") then
            if string.find(string.lower(self.Animation.AnimationId), "attack") or string.find(string.lower(self.Animation.AnimationId), "slash") then
                args[1] = 0 -- Bỏ qua fade time
                args[2] = 1 -- Bỏ qua weight
                args[3] = 100 -- ÉP TỐC ĐỘ ANIMATION X100 (Chém tức thì)
                return oldNamecall(self, table.unpack(args))
            end
        end

        if method == "InvokeServer" or method == "FireServer" then
            if (_G.AntiSlow or _G.FastSlash) and args[1] == "AttemptWeaponHit" and type(args[2]) == "table" then
                args[2].shouldSlow = false
                args[2].cycleIndex = 1 
                if args[2].attackCycleData then 
                    args[2].attackCycleData.slowMult = 1; args[2].attackCycleData.slowTime = 0
                    if _G.FastSlash then args[2].attackCycleData.attackTime = 0 end
                end
                return oldNamecall(self, table.unpack(args))
            end
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

-- =======================================================
-- GIAO DIỆN & TÍNH NĂNG
-- =======================================================
local BypassTab = Window:Tab({ Title = "Bypass & Shield", Icon = "shield" })
local CombatTab = Window:Tab({ Title = "Combat Engine", Icon = "swords" })
local VisTab = Window:Tab({ Title = "Visuals", Icon = "eye" })

-- PHẦN BYPASS
local ShieldSec = BypassTab:Section({ Title = "Anti-Cheat Protection", Icon = "shield-check", Opened = true, Box = true })
ShieldSec:Toggle({ Title = "Master Stealth Mode", Desc = "Spoof stats & Block server edits", Value = true, Callback = function(v) _G.MasterBypass = v end })
ShieldSec:Toggle({ Title = "Anti-Kick Shield", Value = false, Callback = function(v) _G.AntiKickEnabled = v end })

-- PHẦN COMBAT (SINGULARITY ENGINE)
local KillSec = CombatTab:Section({ Title = "SINGULARITY KILL ENGINE", Icon = "zap", Opened = true, Box = true })
local NukeWeaponDef = { attackCycle = { ["1"] = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, attackOrder = {"1"} }
local NukeCycleData = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0}

KillSec:Toggle({ Title = "Fast Slash (Anim Bypass)", Value = false, Callback = function(v) _G.FastSlash = v end })
KillSec:Toggle({ Title = "Enable Singularity Nuke", Desc = "Massive Damage & Spatial Query", Value = false, Callback = function(v) _G.ParallelAura = v end })
KillSec:Slider({ Title = "Radius", Value = {Min = 50, Max = 5000, Default = 500}, Callback = function(v) _G.AuraRadius = v end })
KillSec:Slider({ Title = "Hits Per Target", Value = {Min = 1, Max = 100, Default = 20}, Callback = function(v) _G.AuraSpam = v end })

-- LÕI QUÉT KHÔNG GIAN (SPATIAL QUERY)
local SpatialParams = OverlapParams.new()
SpatialParams.FilterType = Enum.RaycastFilterType.Exclude

RunService.PostSimulation:Connect(function()
    if not _G.ParallelAura then return end
    
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
                        damage = 9e9, hitboxSize = Vector3.new(9e9, 9e9, 9e9), isCritical = true
                    }, hitArray)
                end)
            end)
        end
    end)
end)

-- (Giữ lại các phần ESP và Settings từ bản slient.lua cũ của bạn bên dưới...)
-- ... (Phần ESP và Theme đã có trong slient.lua)

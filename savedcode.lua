local KillSec = CombatTab:Section({ Title = "THE SINGULARITY ENGINE", Icon = "zap", Opened = true, Box = true })

-- =======================================================
-- MASSIVE BURST & AUTO-SLEEP ENGINE (CHÉM HÀNG NGHÌN CON CÙNG LÚC)
-- =======================================================
local NukeWeaponDef = { 
    attackCycle = { ["1"] = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, 
    attackOrder = {"1"} 
}
local NukeCycleData = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0}

_G.ParallelAura = false
_G.AuraRadius = 2000 -- Để hẳn 2000 quét nửa map
_G.AuraSpam = 50 -- Trọng lượng: 1 con chém 50 nhát cùng lúc
_G.AuraDelay = 0.05 -- Tốc độ spam: 20 Quả Nuke mỗi giây (Cực kỳ khủng khiếp)

KillSec:Toggle({ Title = "Enable Burst Nuke & Auto-Sleep", Desc = "Spam hàng nghìn hit. Tự tắt khi hết người để Server thở.", Value = false, Callback = function(v) _G.ParallelAura = v end})
KillSec:Slider({ Title = "Singularity Radius (Tầm quét)", Value = {Min = 50, Max = 10000, Default = 2000}, Callback = function(v) _G.AuraRadius = v end})
KillSec:Slider({ Title = "Hits Per Target (Độ dày nuke)", Value = {Min = 1, Max = 100, Default = 50}, Callback = function(v) _G.AuraSpam = v end})

local SpatialParams = OverlapParams.new()
SpatialParams.FilterType = Enum.RaycastFilterType.Exclude

local function UpdateSpatialFilter()
    if LocalPlayer.Character then
        SpatialParams.FilterDescendantsInstances = {LocalPlayer.Character, Workspace.Terrain}
    end
end
LocalPlayer.CharacterAdded:Connect(UpdateSpatialFilter)
UpdateSpatialFilter()

local lastNukeTick = 0

RunService.Heartbeat:Connect(function()
    if not _G.ParallelAura then return end
    
    local currentTime = tick()
    if currentTime - lastNukeTick < _G.AuraDelay then return end
    lastNukeTick = currentTime

    local Char = LocalPlayer.Character
    local MyTool = Char and Char:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not Char or not MyTool or not Char:FindFirstChild("HumanoidRootPart") then return end
    local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or Char.HumanoidRootPart.Position

    task.spawn(function()
        local partsInRadius = Workspace:GetPartBoundsInRadius(myPos, _G.AuraRadius, SpatialParams)
        
        local targetsFound = {}
        local processedModels = {}

        for _, part in ipairs(partsInRadius) do
            local model = part.Parent
            if model and model:IsA("Model") and not processedModels[model] then
                processedModels[model] = true
                local hum = model:FindFirstChild("Humanoid")
                if hum and hum.Health > 0 and model ~= Char then
                    table.insert(targetsFound, model)
                end
            end
        end

        -- [CƠ CHẾ AUTO-SLEEP]: NẾU KHÔNG CÓ AI (HẾT VÁN), TẠM DỪNG GỬI LỆNH NGAY LẬP TỨC!
        if #targetsFound == 0 then 
            return -- Dừng script ở đây, không gửi bất kỳ gói tin rác nào lên server, cho server thời gian "thở"
        end

        -- [CƠ CHẾ MASSIVE PAYLOAD]: CÓ NGƯỜI -> DỒN TOÀN LỰC CHÉM
        local hitArray = {}
        for _, targetModel in ipairs(targetsFound) do
            local hrp = targetModel:FindFirstChild("HumanoidRootPart")
            if hrp then
                local singleHit = {
                    knockback = 0, isClosestEnemy = true, origin = myPos, 
                    enemyModel = targetModel, distance = (hrp.Position - myPos).Magnitude, direction = Vector3.zAxis
                }
                -- Nhân bản số hit lên (Ví dụ: 20 người x 50 AuraSpam = 1000 hit mỗi gói tin)
                for i = 1, _G.AuraSpam do table.insert(hitArray, singleHit) end
            end
        end

        -- Gửi mảng chứa hàng nghìn Hit lên server.
        -- Bọc trong task.defer để đảm bảo màn hình game không bao giờ bị khựng dù mảng có to đến đâu.
        if #hitArray > 0 then
            task.defer(function()
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
                -- Ép buộc game không được đợi Server trả lời
                pcall(function() GameRemote:InvokeServer(table.unpack(Args)) end)
            end)
        end
    end)
end)

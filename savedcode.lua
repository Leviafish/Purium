local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Silent Assassin |", Icon = "door-open", Author = "Version : 2.0.0 Ultimate", Folder = "Purium_Silent-Assassin",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})

print("Loading script maybe take a few seconds to complete")
WindUI:Notify({ Title = "Purium On Top!", Text = "Injecting Singularity Engine...", Duration = 1.5 })

pcall(function() if setfpscap then setfpscap(144) end end)

local t_insert = table.insert
local t_remove = table.remove
local v3_new = Vector3.new
local cf_new = CFrame.new
local math_min = math.min
local math_abs = math.abs
local math_floor = math.floor
local str_lower = string.lower
local str_find = string.find
local tick_now = tick

Window:EditOpenButton({ Title = "Open Purium", Icon = "crown", CornerRadius = UDim.new(0,16), Draggable = true })

WindUI:AddTheme({ Name = "Amethyst", Accent = Color3.fromHex("7E2CB6"), Dialog = Color3.fromHex("321E46"), Outline = Color3.fromHex("552D78"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("280C47"), Button = Color3.fromHex("733796"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("7E2CB6"), Slider = Color3.fromHex("7E2CB6"), Checkbox = Color3.fromHex("7E2CB6"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("7E2CB6"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
WindUI:AddTheme({ Name = "Balloon", Accent = Color3.fromHex("64AAFF"), Dialog = Color3.fromHex("BDE6FF"), Outline = Color3.fromHex("82AAE6"), Text = Color3.fromHex("1E1E1E"), Placeholder = Color3.fromHex("5A5A5A"), Background = Color3.fromHex("BDE0FF"), Button = Color3.fromHex("A0C8FF"), Icon = Color3.fromHex("5A5A5A"), Toggle = Color3.fromHex("64AAFF"), Slider = Color3.fromHex("64AAFF"), Checkbox = Color3.fromHex("64AAFF"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0, SliderIcon = Color3.fromHex("5A5A5A"), Primary = Color3.fromHex("64AAFF"), LabelBackground = Color3.fromHex("FFFFFF"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "SoftCream", Accent = Color3.fromHex("CEA35A"), Dialog = Color3.fromHex("FFFFF0"), Outline = Color3.fromHex("FFE6C8"), Text = Color3.fromHex("1E1E1E"), Placeholder = Color3.fromHex("5A5A5A"), Background = Color3.fromHex("FFF5DC"), Button = Color3.fromHex("FFD8A1"), Icon = Color3.fromHex("5A5A5A"), Toggle = Color3.fromHex("CEA35A"), Slider = Color3.fromHex("CEA35A"), Checkbox = Color3.fromHex("CEA35A"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0, SliderIcon = Color3.fromHex("5A5A5A"), Primary = Color3.fromHex("CEA35A"), LabelBackground = Color3.fromHex("FFFFFF"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "Night", Accent = Color3.fromHex("3432B2"), Dialog = Color3.fromHex("252550"), Outline = Color3.fromHex("535382"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("141414"), Button = Color3.fromHex("6F6CA0"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("3432B2"), Slider = Color3.fromHex("3432B2"), Checkbox = Color3.fromHex("3432B2"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("3432B2"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
WindUI:AddTheme({ Name = "Forest", Accent = Color3.fromHex("2E8D46"), Dialog = Color3.fromHex("233C28"), Outline = Color3.fromHex("325A3C"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("142319"), Button = Color3.fromHex("467850"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("2E8D46"), Slider = Color3.fromHex("2E8D46"), Checkbox = Color3.fromHex("2E8D46"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("2E8D46"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
WindUI:AddTheme({ Name = "Sunset", Accent = Color3.fromHex("FF8000"), Dialog = Color3.fromHex("3C2319"), Outline = Color3.fromHex("82503C"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("281919"), Button = Color3.fromHex("A06446"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("FF8000"), Slider = Color3.fromHex("FF8000"), Checkbox = Color3.fromHex("FF8000"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("FF8000"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
WindUI:AddTheme({ Name = "AMOLED", Accent = Color3.fromHex("FFFFFF"), Dialog = Color3.fromHex("000000"), Outline = Color3.fromHex("141414"), Text = Color3.fromHex("FFFFFF"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("000000"), Button = Color3.fromHex("0F0F0F"), Icon = Color3.fromHex("FFFFFF"), Toggle = Color3.fromHex("FFFFFF"), Slider = Color3.fromHex("FFFFFF"), Checkbox = Color3.fromHex("FFFFFF"), PanelBackground = Color3.fromHex("000000"), PanelBackgroundTransparency = 0, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("FFFFFF"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "Grape", Accent = Color3.fromHex("B7B0DF"), Dialog = Color3.fromHex("070012"), Outline = Color3.fromHex("141414"), Text = Color3.fromHex("FFFFFF"), Placeholder = Color3.fromHex("7B90AA"), Background = Color3.fromHex("060010"), Button = Color3.fromHex("0D0021"), Icon = Color3.fromHex("B7B0DF"), Toggle = Color3.fromHex("B7B0DF"), Slider = Color3.fromHex("B7B0DF"), Checkbox = Color3.fromHex("B7B0DF"), PanelBackground = Color3.fromHex("070012"), PanelBackgroundTransparency = 0.5, SliderIcon = Color3.fromHex("B7B0DF"), Primary = Color3.fromHex("B7B0DF"), LabelBackground = Color3.fromHex("070012"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "Bloody", Accent = Color3.fromHex("900000"), Dialog = Color3.fromHex("550001"), Outline = Color3.fromHex("560000"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("838383"), Background = Color3.fromHex("3D0000"), Button = Color3.fromHex("730E15"), Icon = Color3.fromHex("F0F0F0"), Toggle = Color3.fromHex("900000"), Slider = Color3.fromHex("900000"), Checkbox = Color3.fromHex("900000"), PanelBackground = Color3.fromHex("550001"), PanelBackgroundTransparency = 0.5, SliderIcon = Color3.fromHex("F0F0F0"), Primary = Color3.fromHex("900000"), LabelBackground = Color3.fromHex("550001"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "Arctic", Accent = Color3.fromHex("40E0FF"), Dialog = Color3.fromHex("1E2D3C"), Outline = Color3.fromHex("233746"), Text = Color3.fromHex("F0FAFF"), Placeholder = Color3.fromHex("B4C8D2"), Background = Color3.fromHex("0A1219"), Button = Color3.fromHex("1E2D3C"), Icon = Color3.fromHex("40E0FF"), Toggle = Color3.fromHex("40E0FF"), Slider = Color3.fromHex("40E0FF"), Checkbox = Color3.fromHex("40E0FF"), PanelBackground = Color3.fromHex("1E2D3C"), PanelBackgroundTransparency = 0.5, SliderIcon = Color3.fromHex("40E0FF"), Primary = Color3.fromHex("40E0FF"), LabelBackground = Color3.fromHex("1E2D3C"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "Cloud", Accent = Color3.fromHex("6DB0FF"), Dialog = Color3.fromHex("FFFFFF"), Outline = Color3.fromHex("C8DCF0"), Text = Color3.fromHex("1E1E1E"), Placeholder = Color3.fromHex("828282"), Background = Color3.fromHex("F0F8FF"), Button = Color3.fromHex("DCEBFA"), Icon = Color3.fromHex("1E1E1E"), Toggle = Color3.fromHex("6DB0FF"), Slider = Color3.fromHex("6DB0FF"), Checkbox = Color3.fromHex("6DB0FF"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0, SliderIcon = Color3.fromHex("828282"), Primary = Color3.fromHex("6DB0FF"), LabelBackground = Color3.fromHex("FFFFFF"), LabelBackgroundTransparency = 0 })
WindUI:AddTheme({ Name = "Sapphire", Accent = Color3.fromHex("0F52BA"), Dialog = Color3.fromHex("0F192D"), Outline = Color3.fromHex("1E2D50"), Text = Color3.fromHex("E6E6E6"), Placeholder = Color3.fromHex("8C8C8C"), Background = Color3.fromHex("0A0F1E"), Button = Color3.fromHex("14233C"), Icon = Color3.fromHex("E6E6E6"), Toggle = Color3.fromHex("0F52BA"), Slider = Color3.fromHex("0F52BA"), Checkbox = Color3.fromHex("0F52BA"), PanelBackground = Color3.fromHex("0F192D"), PanelBackgroundTransparency = 0.5, SliderIcon = Color3.fromHex("8C8C8C"), Primary = Color3.fromHex("0F52BA"), LabelBackground = Color3.fromHex("0F192D"), LabelBackgroundTransparency = 0 })


Window:Tag({ Title = "v2.0.0 Ultimate", Icon = "crown", Color = Color3.fromRGB(255, 215, 0), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

_G.AntiSlow = false
_G.AntiKickEnabled = false
_G.LastAttackTime = 0
_G.MasterBypass = false
_G.SpoofStats = false
_G.BlockNewIndex = false
_G.KillAll = false
_G.AuraRadius = 5000
_G.AuraSpam = 1000
_G.AuraDelay = 0.03
_G.DesyncGodMode = false
_G.AntiAFK = false

local mt = getrawmetatable(game)
local oldIndex = mt.__index
local oldNewIndex = mt.__newindex
local oldNamecall = mt.__namecall
setreadonly(mt, false)

mt.__index = newcclosure(function(self, key)
    if not checkcaller() and _G.MasterBypass and _G.SpoofStats then
        if key == "WalkSpeed" then return 16 end
        if key == "JumpPower" then return 50 end
    end
    return oldIndex(self, key)
end)

mt.__newindex = newcclosure(function(self, key, value)
    if not checkcaller() and _G.MasterBypass and _G.BlockNewIndex then
        if key == "WalkSpeed" and value < 16 then return end
        if key == "CFrame" and _G.DesyncGodMode then return end
    end
    return oldNewIndex(self, key, value)
end)

mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    
    if not checkcaller() then
        if _G.AntiKickEnabled and (method == "Kick" or method == "kick") then return nil end

        if method == "InvokeServer" or method == "FireServer" then
            if _G.AntiSlow and args[1] == "AttemptWeaponHit" and type(args[2]) == "table" then
                args[2].shouldSlow = false
                args[2].cycleIndex = 1 
                if args[2].attackCycleData then 
                    args[2].attackCycleData.slowMult = 1
                    args[2].attackCycleData.slowTime = 0
                end
                if args[2].weaponDefinition and args[2].weaponDefinition.attackCycle then
                    for k, v in pairs(args[2].weaponDefinition.attackCycle) do 
                        v.slowMult = 1
                        v.slowTime = 0
                    end
                end
                return oldNamecall(self, table.unpack(args))
            end
        end
    end
    return oldNamecall(self, ...)
end)
setreadonly(mt, true)

local BypassTab = Window:Tab({ Title = "Server Modification", Icon = "shield-alert" })
local CombatTab = Window:Tab({ Title = "Combat & Farm", Icon = "swords" })
local MoveTab = Window:Tab({ Title = "Movement & Fling", Icon = "move" })
local VisTab = Window:Tab({ Title = "Visuals (ESP)", Icon = "eye" })
local PlayerTab = Window:Tab({ Title = "Players List", Icon = "users" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local function getNearestTarget()
    local nearest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local myPos = char.HumanoidRootPart.Position

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - myPos).Magnitude
                if dist < minDist then 
                    minDist = dist
                    nearest = p.Character 
                end
            end
        end
    end
    return nearest
end

local AntiCheatSec = BypassTab:Section({ Title = "Anti-Cheat Protection", Icon = "shield", Opened = true, Box = true })
AntiCheatSec:Toggle({ Title = "Master Bypass", Desc = "Enable to hide from server anti-cheat", Value = false, Callback = function(v) _G.MasterBypass = v end })
AntiCheatSec:Toggle({ Title = "Spoof Stats (Index)", Desc = "Spoof your speed and jump power", Value = false, Callback = function(v) _G.SpoofStats = v end })
AntiCheatSec:Toggle({ Title = "Block Server Edit (NewIndex)", Desc = "Prevent other hackers from modifying your stats", Value = false, Callback = function(v) _G.BlockNewIndex = v end })

local GodSec = BypassTab:Section({ Title = "Modifications", Icon = "shield", Opened = true, Box = true })
GodSec:Toggle({ Title = "Enable Anti-Kick", Desc = "Blocks server from kicking you", Value = false, Callback = function(v)
    _G.AntiKickEnabled = v
    if v then WindUI:Notify({Title = "Shield Active", Content = "Server kick attempts will now be ignored.", Duration = 3}) end
end})

GodSec:Divider()
_G.TeleportWalk = false
_G.TPWalkValue = 2
GodSec:Toggle({ Title = "Teleport Walk", Desc = "Safer and better than WalkSpeed", Value = false, Callback = function(v) _G.TeleportWalk = v end})
GodSec:Slider({ Title = "Teleport Walk Distance", Value = {Min = 1, Max = 10, Default = 2}, Callback = function(v) _G.TPWalkValue = v end})

RunService.Heartbeat:Connect(function()
    if _G.TeleportWalk then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") and char:FindFirstChild("Humanoid") then
            local hum = char.Humanoid
            local hrp = char.HumanoidRootPart
            if hum.MoveDirection.Magnitude > 0 then
                if _G.DesyncGodMode and _G.LastSafeCFrame then
                    _G.LastSafeCFrame = _G.LastSafeCFrame + (hum.MoveDirection * _G.TPWalkValue)
                else
                    hrp.CFrame = hrp.CFrame + (hum.MoveDirection * _G.TPWalkValue)
                end
            end
        end
    end
end)

GodSec:Divider()
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function()
    if _G.AntiAFK then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end
end)
GodSec:Toggle({ Title = "Anti-AFK", Desc = "Prevents idle disconnects", Value = false, Callback = function(v) _G.AntiAFK = v end})

local SupportSection = BypassTab:Section({ Title = "Others", Icon = "wrench", Opened = true, Box = true })
SupportSection:Toggle({ Title = "Auto Rejoin", Desc = "Automatically reconnect when disconnected", Flag = "AutoRejoinToggle", Value = false, Callback = function(Value) if Value then _G.RejoinConnection = game:GetService("GuiService").ErrorMessageChanged:Connect(function() task.wait(0.5) game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end) else if _G.RejoinConnection then _G.RejoinConnection:Disconnect(); _G.RejoinConnection = nil end end end })
SupportSection:Button({ Title = "Rejoin Server (Manual)", Desc = "Use when stuck in terrain", Callback = function() game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer) end })

local GodModeSec = BypassTab:Section({ Title = "God Mode Settings", Icon = "heart", Opened = true, Box = true })
GodModeSec:Toggle({ Title = "God Mode (Desync)", Desc = "Make you invincible to standard hits", Value = false, Callback = function(v) 
    _G.DesyncGodMode = v 
    pcall(function()
        if not v then
            local cp = Workspace:FindFirstChild("PuriumCamPart")
            if cp then cp:Destroy() end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then Camera.CameraSubject = LocalPlayer.Character.Humanoid end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then local hrp = LocalPlayer.Character.HumanoidRootPart; if hrp.Position.Y > 20000 then hrp.CFrame = hrp.CFrame - v3_new(0, 50000, 0) end end
        end
    end)
end})

local function getFakeCamPart()
    local cp = Workspace:FindFirstChild("PuriumCamPart")
    if not cp then
        cp = Instance.new("Part")
        cp.Name = "PuriumCamPart"
        cp.Transparency = 1
        cp.CanCollide = false
        cp.Anchored = true
        cp.Massless = true
        cp.Size = v3_new(1, 1, 1)
        cp.Parent = Workspace
    end
    return cp
end

RunService.Heartbeat:Connect(function()
    if _G.DesyncGodMode then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            if tick_now() - _G.LastAttackTime > 0.2 then
                if hrp.Position.Y < 20000 then
                    local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity
                    hrp.CFrame = hrp.CFrame + v3_new(0, 50000, 0)
                    hrp.AssemblyLinearVelocity = vel
                    hrp.AssemblyAngularVelocity = rot
                end
            else
                if hrp.Position.Y > 20000 then
                    local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity
                    hrp.CFrame = hrp.CFrame - v3_new(0, 50000, 0)
                    hrp.AssemblyLinearVelocity = vel
                    hrp.AssemblyAngularVelocity = rot
                end
            end
        end
    end
end)

RunService.RenderStepped:Connect(function()
    if _G.DesyncGodMode then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrp = char.HumanoidRootPart
            if hrp.Position.Y > 20000 then
                local vel, rot = hrp.AssemblyLinearVelocity, hrp.AssemblyAngularVelocity
                hrp.CFrame = hrp.CFrame - v3_new(0, 50000, 0)
                hrp.AssemblyLinearVelocity = vel
                hrp.AssemblyAngularVelocity = rot
            end
            local cp = getFakeCamPart()
            cp.CFrame = hrp.CFrame
            Camera.CameraSubject = cp
        end
    end
end)

LocalPlayer.CharacterAdded:Connect(function() 
    pcall(function() 
        local cp = Workspace:FindFirstChild("PuriumCamPart")
        if cp then cp:Destroy() end 
    end) 
end)

local HitboxSec = BypassTab:Section({ Title = "Hitbox Expander", Icon = "maximize", Opened = true, Box = true })
_G.HitboxStatus = false
_G.HitboxSize = 25
_G.HitboxTransparency = 70
_G.HitboxColorMode = "Pre-defined"
_G.HitboxStyle = "Red (Default)"
_G.HitboxCustomRGB = "255, 0, 0"
_G.HitboxCustomHEX = "#FF0000"

HitboxSec:Toggle({ Title = "Enable Hitbox Expander", Desc = "Expand enemy body parts", Value = false, Callback = function(v) _G.HitboxStatus = v end})
HitboxSec:Slider({ Title = "Hitbox Size", Value = {Min = 5, Max = 100, Default = 25}, Callback = function(v) _G.HitboxSize = v end})
HitboxSec:Slider({ Title = "Hitbox Transparency", Desc = "Adjust visibility (0-100)", Value = {Min = 0, Max = 100, Default = 70}, Callback = function(v) _G.HitboxTransparency = v end})
HitboxSec:Dropdown({ Title = "Hitbox Color Mode", Values = {"Pre-defined", "Custom RGB", "Custom HEX"}, Value = "Pre-defined", Callback = function(v) _G.HitboxColorMode = v end})
HitboxSec:Dropdown({ Title = "Pre-defined Colors & Style", Values = {"Red (Default)", "White", "Light Blue", "Black", "Transparent Outline", "Custom"}, Value = "Red (Default)", Callback = function(v) _G.HitboxStyle = v end})
HitboxSec:Input({ Title = "Custom Main Color (Fill)", Value = "255, 0, 0", Callback = function(v) _G.HitboxCustomRGB = v end})
HitboxSec:Input({ Title = "Custom Outline Color (Border)", Value = "255, 255, 255", Callback = function(v) _G.HitboxCustomHEX = v end})

local function getParsedColor(val)
    local c = Color3.fromRGB(255, 255, 255)
    pcall(function()
        if _G.HitboxColorMode == "Custom RGB" then
            local r, g, b = string.match(val, "(%d+)%D+(%d+)%D+(%d+)"); if r and g and b then c = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
        else
            local hex = val; if string.sub(hex, 1, 1) ~= "#" then hex = "#" .. hex end; c = Color3.fromHex(hex)
        end
    end)
    return c
end

RunService.RenderStepped:Connect(function()
    if _G.HitboxStatus then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = v3_new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize); hrp.CanCollide = false
                local useFill, useOutline, mainC, outlineC = true, false, Color3.fromRGB(255, 0, 0), Color3.fromRGB(255, 255, 255)
                
                if _G.HitboxColorMode == "Pre-defined" then
                    if _G.HitboxStyle == "White" then mainC = Color3.fromRGB(255, 255, 255)
                    elseif _G.HitboxStyle == "Light Blue" then mainC = Color3.fromRGB(0, 255, 255)
                    elseif _G.HitboxStyle == "Black" then mainC = Color3.fromRGB(0, 0, 0)
                    elseif _G.HitboxStyle == "Transparent Outline" then useFill = false; useOutline = true; outlineC = Color3.fromRGB(255, 255, 255)
                    elseif _G.HitboxStyle == "Custom" then useFill = true; useOutline = true; mainC = Color3.fromRGB(255, 0, 0) end
                else
                    useFill = true; useOutline = true; mainC = getParsedColor(_G.HitboxCustomRGB); outlineC = getParsedColor(_G.HitboxCustomHEX)
                end

                if useFill then hrp.Transparency = _G.HitboxTransparency / 100; hrp.Material = Enum.Material.Neon; hrp.Color = mainC else hrp.Transparency = 1 end
                if useOutline then
                    if not hrp:FindFirstChild("HitboxSelection") then
                        local box = Instance.new("SelectionBox"); box.Name = "HitboxSelection"; box.Adornee = hrp; box.LineThickness = 0.05; box.Parent = hrp
                    end
                    hrp.HitboxSelection.Color3 = outlineC; hrp.HitboxSelection.SurfaceTransparency = 1
                else if hrp:FindFirstChild("HitboxSelection") then hrp.HitboxSelection:Destroy() end end
            end
        end
    else
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                hrp.Size = v3_new(2, 2, 1); hrp.Transparency = 1; if hrp:FindFirstChild("HitboxSelection") then hrp.HitboxSelection:Destroy() end
            end
        end
    end
end)

local MoveSec = MoveTab:Section({ Title = "Character Modification", Icon = "user", Opened = true, Box = true })
local noclipLoop
MoveSec:Toggle({ Title = "Enable Noclip", Desc = "Walk through walls and obstacles", Value = false, Callback = function(v)
    if v then 
        noclipLoop = RunService.Stepped:Connect(function() pcall(function() if LocalPlayer.Character then for _, p in ipairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end end) end) 
    else if noclipLoop then noclipLoop:Disconnect(); noclipLoop = nil end end
end})

MoveSec:Divider()
_G.WsEnabled = false
_G.WsValue = 25
MoveSec:Toggle({ Title = "Enable WalkSpeed", Desc = "Modify your movement speed", Value = false, Callback = function(v) _G.WsEnabled = v; if not v then pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end) end end})
MoveSec:Slider({ Title = "Speed Amount", Value = {Min = 16, Max = 1500, Default = 25}, Callback = function(v) _G.WsValue = v end})

MoveSec:Divider()
_G.JpEnabled = false
_G.JpValue = 100
MoveSec:Toggle({ Title = "Enable JumpPower", Desc = "Modify your jump height", Value = false, Callback = function(v) _G.JpEnabled = v; if not v then pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 50 end) end end})
MoveSec:Slider({ Title = "Jump Amount", Value = {Min = 50, Max = 1500, Default = 100}, Callback = function(v) _G.JpValue = v end})

RunService.Heartbeat:Connect(function()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if _G.WsEnabled then hum.WalkSpeed = _G.WsValue elseif _G.AntiSlow and hum.WalkSpeed < 16 then hum.WalkSpeed = 16 end
            if _G.JpEnabled then hum.JumpPower = _G.JpValue end
        end
    end
end)

local FlingSec = MoveTab:Section({ Title = "Physics Fling Exploits", Icon = "wind", Opened = true, Box = true })
_G.AntiFling = false
FlingSec:Toggle({ Title = "Anti Fling", Desc = "Ghost mode to prevent being flung", Value = false, Callback = function(v) _G.AntiFling = v end})

FlingSec:Divider()
_G.FlingMode = "Spin Fling"
FlingSec:Dropdown({ Title = "Select Fling Mode", Values = {"Spin Fling", "Teleport & Fling", "Touch Fling"}, Value = "Spin Fling", Callback = function(v) _G.FlingMode = v end})
_G.FlingTarget = ""
FlingSec:Input({ Title = "Target Name (For Teleport)", Desc = "Enter target's name to fling", Value = "", Callback = function(v) _G.FlingTarget = v end})
_G.FlingPower = 50000
FlingSec:Slider({ Title = "Fling Power", Desc = "Rotation speed for maximum fling", Value = {Min = 1000, Max = 100000, Default = 50000}, Callback = function(v) _G.FlingPower = v end})
_G.FlingActive = false
FlingSec:Toggle({ Title = "Enable Fling", Desc = "Activate physics destroyer", Value = false, Callback = function(v) 
    _G.FlingActive = v 
    if not v then
        pcall(function()
            local hrp = LocalPlayer.Character.HumanoidRootPart
            hrp.AssemblyAngularVelocity = v3_new(0,0,0)
            hrp.AssemblyLinearVelocity = v3_new(0,0,0)
            local bav = hrp:FindFirstChild("PuriumFlingBAV"); if bav then bav:Destroy() end
        end)
    end
end})

RunService.Stepped:Connect(function()
    if _G.AntiFling and not _G.FlingActive and LocalPlayer.Character then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character then 
                for _, part in ipairs(p.Character:GetChildren()) do 
                    if part:IsA("BasePart") then part.CanCollide = false end 
                end 
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if _G.FlingActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = LocalPlayer.Character.HumanoidRootPart
        if LocalPlayer.Character:FindFirstChild("Humanoid") then LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Physics) end

        if _G.FlingMode == "Spin Fling" then
            local bav = hrp:FindFirstChild("PuriumFlingBAV")
            if not bav then 
                bav = Instance.new("BodyAngularVelocity")
                bav.Name = "PuriumFlingBAV"
                bav.MaxTorque = v3_new(0, math.huge, 0)
                bav.P = math.huge
                bav.Parent = hrp 
            end
            bav.AngularVelocity = v3_new(0, _G.FlingPower, 0)
        elseif _G.FlingMode == "Touch Fling" then
            local bav = hrp:FindFirstChild("PuriumFlingBAV"); if bav then bav:Destroy() end
            hrp.AssemblyAngularVelocity = v3_new(0, _G.FlingPower, 0)
        elseif _G.FlingMode == "Teleport & Fling" then
            local bav = hrp:FindFirstChild("PuriumFlingBAV"); if bav then bav:Destroy() end
            if _G.FlingTarget ~= "" then
                local tPlayer = nil
                for _, p in ipairs(Players:GetPlayers()) do 
                    if p ~= LocalPlayer and str_find(str_lower(p.Name), str_lower(_G.FlingTarget)) then 
                        tPlayer = p; break 
                    end 
                end
                if tPlayer and tPlayer.Character and tPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local tHrp = tPlayer.Character.HumanoidRootPart
                    hrp.CFrame = tHrp.CFrame
                    hrp.AssemblyAngularVelocity = v3_new(math.random(-_G.FlingPower, _G.FlingPower), math.random(-_G.FlingPower, _G.FlingPower), math.random(-_G.FlingPower, _G.FlingPower))
                    hrp.AssemblyLinearVelocity = v3_new(0, 0, 0)
                end
            end
        end
    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then 
            if LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Physics then 
                LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp) 
            end 
        end
    end
end)

local CombatSec = CombatTab:Section({ Title = "Attack Settings", Icon = "crosshair", Opened = true, Box = true })
CombatSec:Toggle({ Title = "Enable Anti-Slow", Desc = "Remove movement penalty while swinging weapon", Value = false, Callback = function(v) _G.AntiSlow = v end})

local KillSec = CombatTab:Section({ Title = "MULTIPLEXING KILL ALL", Icon = "zap", Opened = true, Box = true })
KillSec:Toggle({ Title = "Enable Kill All", Desc = "Automatically attack players in a wide area", Value = false, Callback = function(v) _G.KillAll = v end})
KillSec:Slider({ Title = "Kill Radius", Value = {Min = 100, Max = 10000, Default = 5000}, Callback = function(v) _G.AuraRadius = v end})
KillSec:Slider({ Title = "Hits Per Target", Value = {Min = 1, Max = 1000, Default = 1000}, Callback = function(v) _G.AuraSpam = v end})
KillSec:Slider({ Title = "Ping Stabilizer (Delay)", Value = {Min = 0.01, Max = 0.5, Default = 0.03}, Callback = function(v) _G.AuraDelay = v end})

local MultiplexQueue = {}
local MAX_PAYLOAD = 300 
local NukeWeaponDef = { attackCycle = { ["1"] = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0, hitboxSizeAdd = v3_new(9e9, 9e9, 9e9)} }, attackOrder = {"1", "1", "1", "1"} }
local NukeCycleData = {knockbackMul=0, slowMult=1, attackTime=0, lungeMul=0, slowTime=0}

local FastInvoke = GameRemote.InvokeServer
local function FireBatch(payload)
    local tool = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Tool") or LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
    if not tool then return end
    task.spawn(FastInvoke, GameRemote, "AttemptWeaponHit", { attackCycleData = NukeCycleData, weaponDefinition = NukeWeaponDef, tool = tool, damage = 9e9, hitboxSize = v3_new(9e9, 9e9, 9e9), isCritical = true, shouldSlow = false }, payload)
end

local lastNukeTick = 0
RunService.PostSimulation:Connect(function()
    if not _G.KillAll then return end
    
    if tick_now() - lastNukeTick < _G.AuraDelay then return end
    lastNukeTick = tick_now()

    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    
    local myPos = Char.HumanoidRootPart.Position

    task.defer(function()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local tChar = p.Character
                local hum = tChar:FindFirstChild("Humanoid")
                local hrp = tChar:FindFirstChild("HumanoidRootPart")
                
                if hum and hum.Health > 0 then
                    local dist = (hrp.Position - myPos).Magnitude
                    if dist <= _G.AuraRadius then
                        local dir = dist > 0 and (hrp.Position - myPos).Unit or Vector3.zAxis
                        local singleHit = { knockback = 0, isClosestEnemy = true, origin = myPos, enemyModel = tChar, distance = dist, direction = dir }
                        for i = 1, _G.AuraSpam do t_insert(MultiplexQueue, singleHit) end
                    end
                end
            end
        end
    end)
end)

local FarmSec = CombatTab:Section({ Title = "Auto Farm & Target", Icon = "crosshair", Opened = true, Box = true })
_G.AutoHit = false
_G.HitRange = 15
FarmSec:Toggle({ Title = "Auto Hit By Distance", Desc = "Automatically attack nearby enemies", Value = false, Callback = function(v) _G.AutoHit = v end})
FarmSec:Slider({ Title = "Auto Hit Range", Value = {Min = 5, Max = 1000, Default = 15}, Callback = function(v) _G.HitRange = v end})

_G.AutoFarm = false
FarmSec:Toggle({ Title = "Auto Farm", Desc = "Teleport behind enemies and attack", Value = false, Callback = function(v) _G.AutoFarm = v end})

local lastFarmTick = 0
RunService.Heartbeat:Connect(function()
    if not _G.AutoFarm and not _G.AutoHit then return end
    if _G.KillAll then return end
    
    if tick_now() - lastFarmTick < _G.AuraDelay then return end
    lastFarmTick = tick_now()

    local Char = LocalPlayer.Character
    if Char and Char:FindFirstChild("HumanoidRootPart") then
        local target = getNearestTarget()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local hrp = Char.HumanoidRootPart
            local tHrp = target.HumanoidRootPart
            local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or hrp.Position
            local dist = (tHrp.Position - myPos).Magnitude

            if _G.AutoFarm then
                if _G.DesyncGodMode and _G.LastSafeCFrame then _G.LastSafeCFrame = tHrp.CFrame * cf_new(0, 0, 3) else hrp.CFrame = tHrp.CFrame * cf_new(0, 0, 3); hrp.Velocity = v3_new(0,0,0) end
                for i = 1, _G.AuraSpam do t_insert(MultiplexQueue, { knockback = 0, isClosestEnemy = true, origin = hrp.Position, enemyModel = target, distance = 3, direction = Vector3.zAxis }) end
                if _G.DesyncGodMode and _G.LastSafeCFrame then _G.LastSafeCFrame = tHrp.CFrame * cf_new(0, 25, 0) else hrp.CFrame = tHrp.CFrame * cf_new(0, 25, 0) end
            
            elseif _G.AutoHit and dist <= _G.HitRange then
                local dir = dist > 0 and (tHrp.Position - myPos).Unit or Vector3.zAxis
                for i = 1, _G.AuraSpam do t_insert(MultiplexQueue, { knockback = 0, isClosestEnemy = true, origin = myPos, enemyModel = target, distance = dist, direction = dir }) end
            end
        end
    end
end)

local lastNetTick = 0
RunService.Heartbeat:Connect(function()
    if #MultiplexQueue > 20000 then MultiplexQueue = {} end 
    
    if #MultiplexQueue == 0 then return end
    if tick_now() - lastNetTick < _G.AuraDelay then return end
    lastNetTick = tick_now()

    local payloadChunk = {}
    local processCount = math_min(#MultiplexQueue, MAX_PAYLOAD)
    for i = 1, processCount do t_insert(payloadChunk, t_remove(MultiplexQueue, 1)) end
    
    if #payloadChunk > 0 then FireBatch(payloadChunk) end
end)

local AimSec = CombatTab:Section({ Title = "Aimbot Configuration", Icon = "crosshair", Opened = true, Box = true })
_G.AimbotMode = "None"
_G.AimbotSmoothness = 1

AimSec:Dropdown({ Title = "Select Aimbot Mode", Values = {"None", "Camera", "Character", "Camera & Character"}, Value = "None", Callback = function(v) _G.AimbotMode = v end})
AimSec:Slider({ Title = "Smoothness (Camera)", Desc = "1 = Instant, Higher = Smoother", Value = {Min = 1, Max = 10, Default = 1}, Callback = function(v) _G.AimbotSmoothness = v end})

RunService.RenderStepped:Connect(function()
    if (_G.AimbotMode == "Camera" or _G.AimbotMode == "Camera & Character") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getNearestTarget()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local goalCFrame = CFrame.lookAt(Camera.CFrame.Position, target.HumanoidRootPart.Position)
            if _G.AimbotSmoothness == 1 then Camera.CFrame = goalCFrame else Camera.CFrame = Camera.CFrame:Lerp(goalCFrame, 1 / _G.AimbotSmoothness) end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    if (_G.AimbotMode == "Character" or _G.AimbotMode == "Camera & Character") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getNearestTarget()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local myHrp = LocalPlayer.Character.HumanoidRootPart
            local tPos = target.HumanoidRootPart.Position
            local lookVec = v3_new(tPos.X, myHrp.Position.Y, tPos.Z)
            if _G.DesyncGodMode and _G.LastSafeCFrame then _G.LastSafeCFrame = CFrame.lookAt(_G.LastSafeCFrame.Position, lookVec) else myHrp.CFrame = CFrame.lookAt(myHrp.Position, lookVec) end
        end
    end
end)

local VisSec = VisTab:Section({ Title = "ESP Configurations", Icon = "eye", Opened = true, Box = true })

local originalTrans = {}
local antiInvisLoop
VisSec:Toggle({ Title = "Show Invisible Players", Desc = "Force hidden players to appear normally", Value = false, Callback = function(v)
    if v then
        antiInvisLoop = RunService.RenderStepped:Connect(function()
            pcall(function()
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character then 
                        for _, part in ipairs(p.Character:GetDescendants()) do 
                            if (part:IsA("BasePart") or part:IsA("Decal")) then 
                                if part.Name ~= "HumanoidRootPart" and not str_find(str_lower(part.Name), "hitbox") then 
                                    if part.Transparency > 0 then 
                                        if originalTrans[part] == nil then originalTrans[part] = part.Transparency end
                                        part.Transparency = 0 
                                    end 
                                end 
                            end 
                        end 
                    end
                end
            end)
        end)
    else
        if antiInvisLoop then antiInvisLoop:Disconnect(); antiInvisLoop = nil end
        for part, trans in pairs(originalTrans) do pcall(function() if part and part.Parent then part.Transparency = trans end end) end
        originalTrans = {}
    end
end})

VisSec:Divider()
_G.ESP_Box = false
_G.ESP_Name = false
_G.ESP_Chams = false
VisSec:Toggle({ Title = "Enable 2D Box", Desc = "Clean, lag-free bounding box", Value = false, Callback = function(v) _G.ESP_Box = v end})
VisSec:Toggle({ Title = "Enable Names & Distance", Desc = "Show player info above their head", Value = false, Callback = function(v) _G.ESP_Name = v end})
VisSec:Toggle({ Title = "Enable Chams (Highlight)", Desc = "See players through walls", Value = false, Callback = function(v) _G.ESP_Chams = v end})

local espElements = {}
local function cleanEsp(player) 
    if espElements[player] then 
        pcall(function() espElements[player].Name:Remove(); espElements[player].Box:Remove(); espElements[player].Highlight:Destroy() end)
        espElements[player] = nil 
    end 
end

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
                            local headPos = Camera:WorldToViewportPoint(head.Position + v3_new(0, 0.5, 0))
                            local legPos = Camera:WorldToViewportPoint(hrp.Position - v3_new(0, 3, 0))
                            local boxHeight = math_abs(headPos.Y - legPos.Y)
                            local boxWidth = boxHeight * 0.6
                            local boxPos = Vector2.new(rootPos.X - boxWidth / 2, headPos.Y)
                            local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
                            local teamColor = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 50, 50)
                            
                            d.Box.Size = Vector2.new(boxWidth, boxHeight)
                            d.Box.Position = boxPos
                            d.Box.Color = teamColor
                            d.Box.Visible = _G.ESP_Box
                            d.Name.Color = teamColor
                            d.Name.Text = player.Name .. " ["..math_floor(dist).."m]"
                            d.Name.Position = Vector2.new(rootPos.X, headPos.Y - 20)
                            d.Name.Visible = _G.ESP_Name
                            d.Highlight.FillColor = teamColor
                            d.Highlight.Parent = char
                            d.Highlight.Enabled = _G.ESP_Chams
                        else 
                            d.Name.Visible = false; d.Box.Visible = false; d.Highlight.Enabled = false 
                        end
                    else 
                        cleanEsp(player) 
                    end
                end
            end
        end
        for player, _ in pairs(espElements) do 
            if not activePlayers[player] then cleanEsp(player) end 
        end
    end)
end)

local PlayerSec = PlayerTab:Section({ Title = "Server Players", Icon = "users", Opened = true, Box = true })
local playerNames = {}
local PlayerDropdown = PlayerSec:Dropdown({ Title = "Select Player", Values = {"None"}, Callback = function(sel) _G.SelectedPlayer = sel end})

local function refreshPlayers() 
    playerNames = {}
    for _, p in ipairs(Players:GetPlayers()) do 
        if p ~= LocalPlayer then t_insert(playerNames, p.Name) end 
    end
    PlayerDropdown:Refresh(playerNames) 
end

PlayerSec:Divider()
PlayerSec:Button({ Title = "Refresh Player List", Icon = "refresh-cw", Callback = refreshPlayers })
PlayerSec:Button({ Title = "Teleport To Player", Icon = "map-pin", Callback = function()
    pcall(function()
        local target = Players:FindFirstChild(_G.SelectedPlayer)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            WindUI:Notify({Title = "Teleport", Content = "Teleported to " .. target.Name, Duration=2})
        end
    end)
end})
refreshPlayers()

local ThemeSection = SettingTab:Section({ Title = "Themes", Icon = "palette", Opened = true, Box = true })
local validThemes = WindUI:GetThemes()
local uiThemes = {}
for themeName, _ in pairs(validThemes) do t_insert(uiThemes, themeName) end
table.sort(uiThemes)
ThemeSection:Dropdown({ Title = "Theme", Desc = "Choose UI Style", Values = uiThemes, Flag = "ThemeDropdown", Value = "Dark", Callback = function(Value) if validThemes[Value] then pcall(function() WindUI:SetTheme(Value) end) end end })

SettingTab:Space()
local ConfigSection = SettingTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local ConfigManager = Window.ConfigManager
local configName = "Configs"
local configFile = ConfigManager:CreateConfig(configName)
local savedConfigs = ConfigManager:AllConfigs()

local function getAutoLoad() 
    local success, result = pcall(function() if isfile and isfile("AutoLoad.txt") then return readfile("AutoLoad.txt") end end)
    if success and result then return result end
    return "none" 
end

local function setAutoLoad(name) 
    pcall(function() if writefile then writefile("AutoLoad.txt", name) end end) 
end

if #savedConfigs == 0 then t_insert(savedConfigs, "Configs") end

local ConfigInput = ConfigSection:Input({ Title = "Config Name", Value = configName, Callback = function(value) configName = value or "Configs" end })
local AutoLoadToggle
local ConfigDropdown = ConfigSection:Dropdown({ Title = "Choose Saved Config", Values = savedConfigs, Value = configName, AllowNone = false, Callback = function(value) configName = value or "Configs"; ConfigInput:Set(configName); if AutoLoadToggle then AutoLoadToggle:Set(getAutoLoad() == configName) end end })

AutoLoadToggle = ConfigSection:Toggle({ Title = "Auto-Load Config", Desc = "Enable to auto load this config on execution", Value = (getAutoLoad() == configName), Callback = function(Value) if Value then setAutoLoad(configName) else setAutoLoad("none") end end })
ConfigSection:Button({ Title = "Save Config", Icon = "check", Callback = function() configFile = ConfigManager:CreateConfig(configName); if configFile:Save() then local newList = ConfigManager:AllConfigs(); if #newList == 0 then t_insert(newList, "Configs") end; ConfigDropdown:Refresh(newList); WindUI:Notify({ Title = "Save Config", Content = "Saved: " .. configName, Duration = 3 }) end end })
ConfigSection:Button({ Title = "Load Config", Icon = "refresh-cw", Callback = function() configFile = ConfigManager:CreateConfig(configName); if configFile:Load() then WindUI:Notify({ Title = "Load Config", Content = "Loaded: " .. configName, Duration = 3 }) end end })

Window:OnClose(function() if ConfigManager and configFile then configFile:Save() end end)

task.spawn(function()
    task.wait(0.5)
    local autoConf = getAutoLoad()
    if autoConf ~= "none" then
        configName = autoConf; configFile = ConfigManager:CreateConfig(configName)
        pcall(function() configFile:Load(); WindUI:Notify({ Title = "Auto-Load Enabled", Content = "Loaded config: " .. configName, Duration = 2 }) end)
    end
    task.wait(0.8)
    pcall(function() Window:Minimize() end)
    pcall(function() Window:Toggle() end)
    WindUI:Notify({ Title = "UI Minimized", Content = "The UI is minimized. Click the floating icon to open.", Duration = 2 })
end)

ThemeSection:Keybind({ Title = "Keybind", Desc = "Keybind to open UI", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

print("Successfully loaded all assets! Purium on Top!")

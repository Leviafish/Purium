print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Script...", Duration = 3 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Silent Assassin |", Icon = "door-open", Author = "Version : 1.7.1", Folder = "Purium_Silent-Assassin",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})

Window:EditOpenButton({
    Title = "Open UI", Icon = "monitor", CornerRadius = UDim.new(0,16), StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("1e1e1e"), Color3.fromHex("000000")),
    OnlyMobile = false, Enabled = true, Draggable = true,
})

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

Window:Tag({ Title = "v1.7.1 (Perfect Nuke)", Icon = "github", Color = Color3.fromRGB(48, 255, 106), Radius = 10 })

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

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    if not checkcaller() then
        if _G.AntiKickEnabled and (method == "Kick" or method == "kick") then
            return nil
        end
        
        if _G.AntiSlow and (method == "FireServer" or method == "InvokeServer") then
            if args[1] == "AttemptWeaponHit" and type(args[2]) == "table" then
                args[2].shouldSlow = false
                args[2].slowMult = 1
                args[2].slowTime = 0
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
                return oldNamecall(self, unpack(args))
            end
        end
    end

    return oldNamecall(self, ...)
end)

local BypassTab = Window:Tab({ Title = "Server Modification", Icon = "shield-alert" })
local CombatTab = Window:Tab({ Title = "Combat & Farm", Icon = "swords" })
local MoveTab = Window:Tab({ Title = "Movement", Icon = "move" })
local VisTab = Window:Tab({ Title = "Visuals (ESP)", Icon = "eye" })
local PlayerTab = Window:Tab({ Title = "Players List", Icon = "users" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local MoveSec = MoveTab:Section({ Title = "Character Modification", Icon = "user", Opened = true, Box = true })
local noclipLoop
MoveSec:Toggle({ Title = "Enable Noclip", Desc = "Walk through walls and obstacles", Value = false, Callback = function(v)
    if v then 
        noclipLoop = RunService.Stepped:Connect(function() 
            pcall(function()
                if LocalPlayer.Character then 
                    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do 
                        if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end 
                    end 
                end 
            end)
        end) 
    else 
        if noclipLoop then noclipLoop:Disconnect(); noclipLoop = nil end 
    end
end})
MoveSec:Divider()
_G.WsEnabled = false
_G.WsValue = 25
MoveSec:Toggle({ Title = "Enable WalkSpeed", Desc = "Modify your movement speed", Value = false, Callback = function(v) 
    _G.WsEnabled = v
    if not v then pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end) end 
end})
MoveSec:Slider({ Title = "Speed Amount", Value = {Min = 16, Max = 15000, Default = 25}, Callback = function(v) _G.WsValue = v end})
MoveSec:Divider()
_G.JpEnabled = false
_G.JpValue = 100
MoveSec:Toggle({ Title = "Enable JumpPower", Desc = "Modify your jump height", Value = false, Callback = function(v) 
    _G.JpEnabled = v
    if not v then pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 50 end) end 
end})
MoveSec:Slider({ Title = "Jump Amount", Value = {Min = 50, Max = 2500, Default = 100}, Callback = function(v) _G.JpValue = v end})

RunService.Heartbeat:Connect(function()
    pcall(function()
        local char = LocalPlayer.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                if _G.WsEnabled then 
                    hum.WalkSpeed = _G.WsValue 
                elseif _G.AntiSlow and hum.WalkSpeed < 16 then 
                    hum.WalkSpeed = 16 
                end
                if _G.JpEnabled then 
                    hum.JumpPower = _G.JpValue 
                end
            end
        end
    end)
end)

local GodSec = BypassTab:Section({ Title = "Modifications", Icon = "shield", Opened = true, Box = true })

GodSec:Toggle({ Title = "Enable Anti-Kick", Desc = "Blocks server from kicking you", Value = false, Callback = function(v) _G.AntiKickEnabled = v end})
GodSec:Divider()
_G.TeleportWalk = false
_G.TPWalkValue = 2
GodSec:Toggle({ Title = "Teleport Walk", Desc = "Safer and better than WalkSpeed", Value = false, Callback = function(v) _G.TeleportWalk = v end})
GodSec:Slider({ Title = "Teleport Walk Distance", Value = {Min = 1, Max = 10, Default = 2}, Callback = function(v) _G.TPWalkValue = v end})

RunService.Heartbeat:Connect(function()
    pcall(function()
        if _G.TeleportWalk and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character:FindFirstChild("Humanoid") then
            local hum = LocalPlayer.Character.Humanoid
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if hum.MoveDirection.Magnitude > 0 then
                if _G.DesyncGodMode and _G.LastSafeCFrame then
                    _G.LastSafeCFrame = _G.LastSafeCFrame + (hum.MoveDirection * _G.TPWalkValue)
                else
                    hrp.CFrame = hrp.CFrame + (hum.MoveDirection * _G.TPWalkValue)
                end
            end
        end
    end)
end)

GodSec:Divider()
_G.FakeLag = false
GodSec:Toggle({ Title = "Fake Lag (Blink)", Desc = "Freeze your character on others screens", Value = false, Callback = function(v)
    _G.FakeLag = v
    pcall(function() settings():GetService("NetworkSettings").IncomingReplicationLag = v and 9999 or 0 end)
end})

GodSec:Divider()
_G.AntiAFK = false
local VirtualUser = game:GetService("VirtualUser")
LocalPlayer.Idled:Connect(function() if _G.AntiAFK then VirtualUser:CaptureController(); VirtualUser:ClickButton2(Vector2.new()) end end)
GodSec:Toggle({ Title = "Anti-AFK", Desc = "Prevents 20-minute idle disconnect", Value = false, Callback = function(v) _G.AntiAFK = v end})

local SupportSection = BypassTab:Section({ Title = "Others", Icon = "wrench", Opened = true, Box = true })
SupportSection:Toggle({ Title = "Auto Rejoin", Desc = "Reconnect automatically if kicked", Flag = "AutoRejoinToggle", Value = false, Callback = function(Value) if Value then _G.RejoinConnection = game:GetService("GuiService").ErrorMessageChanged:Connect(function() task.wait(0.5) game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end) else if _G.RejoinConnection then _G.RejoinConnection:Disconnect(); _G.RejoinConnection = nil end end end })
SupportSection:Button({ Title = "Rejoin Server (Manual)", Desc = "Use when stuck", Callback = function() game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end })

local HitboxSec = BypassTab:Section({ Title = "Hitbox Expander", Icon = "maximize", Opened = true, Box = true })
_G.HitboxStatus = false
_G.HitboxSize = 25
_G.HitboxTransparency = 70
_G.HitboxColorMode = "Pre-defined"
_G.HitboxStyle = "Red (Default)"
_G.HitboxCustomRGB = "255, 0, 0"
_G.HitboxCustomHEX = "#FF0000"

HitboxSec:Toggle({ Title = "Enable Hitbox Expander", Desc = "Expand enemy body parts to hit them easily", Value = false, Callback = function(v) _G.HitboxStatus = v end})
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
            local r, g, b = string.match(val, "(%d+)%D+(%d+)%D+(%d+)")
            if r and g and b then c = Color3.fromRGB(tonumber(r), tonumber(g), tonumber(b)) end
        else
            local hex = val
            if string.sub(hex, 1, 1) ~= "#" then hex = "#" .. hex end
            c = Color3.fromHex(hex)
        end
    end)
    return c
end

RunService.RenderStepped:Connect(function()
    pcall(function()
        if not _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
        end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = p.Character.HumanoidRootPart
                if _G.HitboxStatus then
                    hrp.Size = Vector3.new(_G.HitboxSize, _G.HitboxSize, _G.HitboxSize)
                    hrp.CanCollide = false
                    local useFill = true
                    local useOutline = false
                    local mainC = Color3.fromRGB(255, 0, 0)
                    local outlineC = Color3.fromRGB(255, 255, 255)
                    
                    if _G.HitboxColorMode == "Pre-defined" then
                        if _G.HitboxStyle == "White" then mainC = Color3.fromRGB(255, 255, 255)
                        elseif _G.HitboxStyle == "Light Blue" then mainC = Color3.fromRGB(0, 255, 255)
                        elseif _G.HitboxStyle == "Black" then mainC = Color3.fromRGB(0, 0, 0)
                        elseif _G.HitboxStyle == "Transparent Outline" then useFill = false; useOutline = true; outlineC = Color3.fromRGB(255, 255, 255)
                        elseif _G.HitboxStyle == "Custom" then useFill = true; useOutline = true; mainC = Color3.fromRGB(255, 0, 0) end
                    else
                        useFill = true
                        useOutline = true
                        mainC = getParsedColor(_G.HitboxCustomRGB)
                        outlineC = getParsedColor(_G.HitboxCustomHEX)
                    end

                    if useFill then
                        hrp.Transparency = _G.HitboxTransparency / 100
                        hrp.Material = Enum.Material.Neon
                        hrp.Color = mainC
                    else
                        hrp.Transparency = 1
                    end
                    
                    if useOutline then
                        if not hrp:FindFirstChild("HitboxSelection") then
                            local box = Instance.new("SelectionBox")
                            box.Name = "HitboxSelection"
                            box.Adornee = hrp
                            box.LineThickness = 0.05
                            box.Parent = hrp
                        end
                        hrp.HitboxSelection.Color3 = outlineC
                        hrp.HitboxSelection.SurfaceTransparency = 1
                    else
                        if hrp:FindFirstChild("HitboxSelection") then hrp.HitboxSelection:Destroy() end
                    end
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    if hrp:FindFirstChild("HitboxSelection") then hrp.HitboxSelection:Destroy() end
                end
            end
        end
    end)
end)

HitboxSec:Divider()
_G.DesyncGodMode = false
HitboxSec:Toggle({ Title = "God Mode (Desync)", Desc = "Makes you invincible to normal attacks", Value = false, Callback = function(v) 
    _G.DesyncGodMode = v 
    pcall(function()
        if not v then
            local cp = Workspace:FindFirstChild("PuriumCamPart")
            if cp then cp:Destroy() end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                Camera.CameraSubject = LocalPlayer.Character.Humanoid
            end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local hrp = LocalPlayer.Character.HumanoidRootPart
                if hrp.Position.Y > 20000 then hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0) end
            end
        end
    end)
end})

local function getFakeCamPart()
    local cp = Workspace:FindFirstChild("PuriumCamPart")
    if not cp then
        cp = Instance.new("Part"); cp.Name = "PuriumCamPart"; cp.Transparency = 1; cp.CanCollide = false
        cp.Anchored = true; cp.Massless = true; cp.Size = Vector3.new(1, 1, 1); cp.Parent = Workspace
    end
    return cp
end

RunService.Heartbeat:Connect(function()
    pcall(function()
        if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if tick() - _G.LastAttackTime > 0.2 then
                if hrp.Position.Y < 20000 then hrp.CFrame = hrp.CFrame + Vector3.new(0, 50000, 0) end
            else
                if hrp.Position.Y > 20000 then hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0) end
            end
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if hrp.Position.Y > 20000 then hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0) end
            local cp = getFakeCamPart()
            cp.CFrame = hrp.CFrame
            Camera.CameraSubject = cp
        end
    end)
end)

local CombatSec = CombatTab:Section({ Title = "Attack Settings", Icon = "crosshair", Opened = true, Box = true })

CombatSec:Toggle({ Title = "Enable Anti-Slow", Desc = "Remove movement penalty while swinging weapon", Value = false, Callback = function(v) 
    _G.AntiSlow = v 
end})

CombatSec:Divider()

_G.AttackDelay = 0
CombatSec:Slider({ Title = "Attack Delay (Seconds)", Desc = "Map wipe speed (0 = Fastest possible)", Value = {Min = 0, Max = 10, Default = 0}, Callback = function(v) 
    _G.AttackDelay = v 
end})

CombatSec:Divider()

_G.HitsPerPacket = 20 
CombatSec:Slider({ 
    Title = "Hits Per Packet (Stat Farm)", 
    Desc = "Virtual slashes per hit (Recommended: 10 - 50)", 
    Value = {Min = 1, Max = 200, Default = 20}, 
    Callback = function(v) 
        _G.HitsPerPacket = v 
    end
})

CombatSec:Divider()

local function getNearestTarget()
    local nearest = nil
    local minDist = math.huge
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or Char.HumanoidRootPart.Position
    
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

local function BuildHitData(TargetChar)
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return {} end
    if not TargetChar or not TargetChar:FindFirstChild("HumanoidRootPart") then return {} end
    
    local myHrp = Char.HumanoidRootPart
    local tHrp = TargetChar.HumanoidRootPart
    
    local dist = (tHrp.Position - myHrp.Position).Magnitude
    local dir = (tHrp.Position - myHrp.Position).Unit
    if dist == 0 or dist ~= dist then dir = Vector3.new(0, 0, 1) end 
    
    local targetArray = {}
    local safeHits = math.clamp(_G.HitsPerPacket, 1, 200) 
    
    for i = 1, safeHits do
        table.insert(targetArray, {
            knockback = 0, isClosestEnemy = true, 
            origin = myHrp.Position, enemyModel = TargetChar, 
            distance = dist, direction = dir 
        })
    end
    return targetArray
end

local function FireCombatRequest(targetArray)
    if #targetArray == 0 then return end
    local Char = LocalPlayer.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    
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
            knockback = 0, shouldLock = true, shouldLunge = false,
            hitboxOffset = Vector3.new(0, 0, 0), isCritical = true, shouldSlow = isSlow,
            attackCooldown = 0, damage = 9e9, lungeKnockback = 0, cycleIndex = 1,
            slowMult = slowMul, 
            hitboxSize = Vector3.new(9e9, 9e9, 9e9), 
            weaponDefinition = { 
                attackCycle = { ["1"] = {knockbackMul=0, slowMult=slowMul, attackTime=0, lungeMul=0, slowTime=slowTim, hitboxSizeAdd = Vector3.new(9e9, 9e9, 9e9)} }, 
                attackOrder = {"1", "1", "1", "1"} 
            },
            tool = MyTool, slowTime = slowTim
        },
        targetArray
    }
    
    task.spawn(function() 
        pcall(function() GameRemote:InvokeServer(unpack(Args)) end) 
    end)
end

_G.KillAll = false
CombatSec:Toggle({ Title = "Kill All Players", Desc = "", Value = false, Callback = function(v) 
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
                        FireCombatRequest(fullArray)
                    end
                end)
                if _G.AttackDelay > 0 then task.wait(_G.AttackDelay) else task.wait(0.1) end
            end
        end)
    end
end})

CombatSec:Divider()

_G.AutoHit = false
_G.HitRange = 15
CombatSec:Toggle({ Title = "Auto Hit By Distance", Desc = "Automatically execute enemies entering your range", Value = false, Callback = function(v) 
    _G.AutoHit = v 
end})
CombatSec:Slider({ Title = "Auto Hit Range", Value = {Min = 5, Max = 1000, Default = 15}, Callback = function(v) _G.HitRange = v end})

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
                            FireCombatRequest(data)
                        end
                    end
                end
            end)
            task.wait(math.max(_G.AttackDelay, 0.05))
        end
    end
end)

CombatSec:Divider()

_G.AutoFarm = false
CombatSec:Toggle({ Title = "Auto Farm", Desc = "Ghostly glide to execute enemies", Value = false, Callback = function(v) 
    _G.AutoFarm = v 
end})

task.spawn(function()
    while true do
        task.wait()
        if _G.AutoFarm and not _G.KillAll then
            pcall(function()
                local Char = LocalPlayer.Character
                if Char and Char:FindFirstChild("HumanoidRootPart") then
                    local target = getNearestTarget()
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        local hrp = Char.HumanoidRootPart
                        local tHrp = target.HumanoidRootPart
                        local behindPos = tHrp.CFrame * CFrame.new(0, 0, 3)
                        
                        if _G.DesyncGodMode and _G.LastSafeCFrame then
                            _G.LastSafeCFrame = behindPos
                        else
                            hrp.CFrame = behindPos
                            hrp.Velocity = Vector3.new(0,0,0) 
                        end
                        
                        local data = BuildHitData(target)
                        FireCombatRequest(data)
                        
                        task.wait(0.05)
                        if _G.DesyncGodMode and _G.LastSafeCFrame then
                            _G.LastSafeCFrame = tHrp.CFrame * CFrame.new(0, 5, 0)
                        else
                            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 5, 0)
                            hrp.Velocity = Vector3.new(0,0,0)
                        end
                    end
                end
            end)
            task.wait(math.max(_G.AttackDelay, 0.1))
        end
    end
end)

local AimSec = CombatTab:Section({ Title = "Aimbot Configuration", Icon = "crosshair", Opened = true, Box = true })
_G.AimbotMode = "None"
_G.AimbotSmoothness = 1

AimSec:Dropdown({ Title = "Select Aimbot Mode", Values = {"None", "Camera", "Character", "Camera & Character"}, Value = "None", Callback = function(v) 
    _G.AimbotMode = v 
end})

AimSec:Slider({ Title = "Smoothness (Camera)", Desc = "1 = Instant, Higher = Smoother", Value = {Min = 1, Max = 10, Default = 1}, Callback = function(v) 
    _G.AimbotSmoothness = v 
end})

RunService.RenderStepped:Connect(function()
    if (_G.AimbotMode == "Camera" or _G.AimbotMode == "Camera & Character") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local target = getNearestTarget()
        if target and target:FindFirstChild("HumanoidRootPart") then
            local tPos = target.HumanoidRootPart.Position
            local goalCFrame = CFrame.lookAt(Camera.CFrame.Position, tPos)
            
            if _G.AimbotSmoothness == 1 then
                Camera.CFrame = goalCFrame
            else
                Camera.CFrame = Camera.CFrame:Lerp(goalCFrame, 1 / _G.AimbotSmoothness)
            end
        end
    end
end)

RunService.Heartbeat:Connect(function()
    pcall(function()
        if (_G.AimbotMode == "Character" or _G.AimbotMode == "Camera & Character") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local target = getNearestTarget()
            if target and target:FindFirstChild("HumanoidRootPart") then
                local myHrp = LocalPlayer.Character.HumanoidRootPart
                local tPos = target.HumanoidRootPart.Position

                local lookVec = Vector3.new(tPos.X, myHrp.Position.Y, tPos.Z)
                if _G.DesyncGodMode and _G.LastSafeCFrame then
                    _G.LastSafeCFrame = CFrame.lookAt(_G.LastSafeCFrame.Position, lookVec)
                else
                    myHrp.CFrame = CFrame.lookAt(myHrp.Position, lookVec)
                end
            end
        end
    end)
end)

local VisSec = VisTab:Section({ Title = "ESP & Visuals", Icon = "eye", Opened = true, Box = true })

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
                                if part.Name ~= "HumanoidRootPart" and not string.find(string.lower(part.Name), "hitbox") then
                                    if part.Transparency > 0 then
                                        if originalTrans[part] == nil then 
                                            originalTrans[part] = part.Transparency 
                                        end
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
        if antiInvisLoop then
            antiInvisLoop:Disconnect()
            antiInvisLoop = nil
        end
        for part, trans in pairs(originalTrans) do
            pcall(function() 
                if part and part.Parent then 
                    part.Transparency = trans 
                end 
            end)
        end
        originalTrans = {}
    end
end})

VisSec:Divider()

local espElements = {}
local espConn = nil

local function cleanEsp(player)
    if espElements[player] then 
        pcall(function() 
            espElements[player].Name:Remove()
            if espElements[player].Box then espElements[player].Box:Remove() end
            if espElements[player].BoxOutline then espElements[player].BoxOutline:Remove() end
            espElements[player].Highlight:Destroy() 
        end) 
        espElements[player] = nil 
    end
end

local function updatePlayerEsp()
    pcall(function()
        local activePlayers = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer then
                activePlayers[player] = true
                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                
                if char and hrp and hum and hum.Health > 0 then
                    if not espElements[player] then
                        local d = { 
                            Name = Drawing.new("Text"), 
                            BoxOutline = Drawing.new("Square"),
                            Box = Drawing.new("Square"),
                            Highlight = Instance.new("Highlight") 
                        }
                        d.Name.Size = 16
                        d.Name.Center = true
                        d.Name.Outline = true
                        d.Name.Font = 2
                        
                        d.BoxOutline.Thickness = 3
                        d.BoxOutline.Filled = false
                        d.BoxOutline.Color = Color3.new(0, 0, 0)
                        
                        d.Box.Thickness = 1
                        d.Box.Filled = false
                        
                        d.Highlight.FillTransparency = 0.5
                        d.Highlight.OutlineTransparency = 0
                        d.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        d.Highlight.Parent = char
                        
                        espElements[player] = d
                    end
                    
                    local d = espElements[player]
                    local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                    
                    if onScreen then
                        local dist = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
                        local teamColor = player.TeamColor and player.TeamColor.Color or Color3.fromRGB(255, 50, 50)
                        
                        local boxWidth = 3000 / rootPos.Z
                        local boxHeight = 4500 / rootPos.Z
                        local boxPos = Vector2.new(rootPos.X - boxWidth / 2, rootPos.Y - boxHeight / 2)
                        
                        d.BoxOutline.Size = Vector2.new(boxWidth, boxHeight)
                        d.BoxOutline.Position = boxPos
                        d.BoxOutline.Visible = _G.ShowESP
                        
                        d.Box.Size = Vector2.new(boxWidth, boxHeight)
                        d.Box.Position = boxPos
                        d.Box.Color = teamColor
                        d.Box.Visible = _G.ShowESP
                        
                        d.Name.Color = teamColor
                        d.Name.Text = player.Name .. " ["..math.floor(dist).."m]"
                        d.Name.Position = Vector2.new(rootPos.X, rootPos.Y - boxHeight / 2 - 20)
                        d.Name.Visible = _G.ShowESP
                        
                        d.Highlight.FillColor = teamColor
                        d.Highlight.Parent = char
                        d.Highlight.Enabled = _G.ShowESP
                    else 
                        d.Name.Visible = false
                        d.Box.Visible = false
                        d.BoxOutline.Visible = false
                        d.Highlight.Enabled = false
                    end
                else 
                    cleanEsp(player) 
                end
            end
        end
        for player, _ in pairs(espElements) do 
            if not activePlayers[player] then 
                cleanEsp(player) 
            end 
        end
    end)
end

_G.ShowESP = false
VisSec:Toggle({ Title = "Enable ESP (Chams & 2D Box)", Desc = "Draws highlight and 2D box around players", Value = false, Callback = function(v)
    _G.ShowESP = v
    if v then 
        if not espConn then espConn = RunService.RenderStepped:Connect(updatePlayerEsp) end 
    else 
        if espConn then 
            espConn:Disconnect()
            espConn = nil 
            for p, _ in pairs(espElements) do cleanEsp(p) end 
        end 
    end
end})

local PlayerSec = PlayerTab:Section({ Title = "Server Players", Icon = "users", Opened = true, Box = true })
local playerNames = {}
local PlayerDropdown = PlayerSec:Dropdown({ Title = "Select Player", Values = {"None"}, Callback = function(sel) 
    _G.SelectedPlayer = sel 
end})

local function refreshPlayers()
    playerNames = {}
    for _, p in pairs(Players:GetPlayers()) do 
        if p ~= LocalPlayer then 
            table.insert(playerNames, p.Name) 
        end 
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
local themes = {}
for themeName, _ in pairs(validThemes) do table.insert(themes, themeName) end
table.sort(themes)
ThemeSection:Dropdown({ Title = "Theme", Desc = "Choose UI Style", Values = themes, Flag = "ThemeDropdown", Value = "Dark", Callback = function(Value) if validThemes[Value] then pcall(function() WindUI:SetTheme(Value) end) end end })

SettingTab:Space()

local ConfigSection = SettingTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local ConfigManager = Window.ConfigManager
local configName = "Configs"
local configFile = ConfigManager:CreateConfig(configName)
local savedConfigs = ConfigManager:AllConfigs()

local function getAutoLoad()
    pcall(function()
        if isfile and isfile("AutoLoad.txt") then
            return readfile("AutoLoad.txt")
        end
    end)
    return "none"
end

local function setAutoLoad(name)
    pcall(function()
        if writefile then
            writefile("AutoLoad.txt", name)
        end
    end)
end

if #savedConfigs == 0 then table.insert(savedConfigs, "Configs") end

local ConfigInput = ConfigSection:Input({ Title = "Config Name", Value = configName, Callback = function(value) configName = value or "Configs" end })
local AutoLoadToggle

local ConfigDropdown = ConfigSection:Dropdown({ 
    Title = "Choose Saved Config", 
    Values = savedConfigs, 
    Value = configName, 
    AllowNone = false, 
    Callback = function(value) 
        configName = value or "Configs" 
        ConfigInput:Set(configName) 
        if AutoLoadToggle then 
            AutoLoadToggle:Set(getAutoLoad() == configName) 
        end 
    end 
})

AutoLoadToggle = ConfigSection:Toggle({ 
    Title = "Auto-Load Config", 
    Desc = "Enable to auto load this config on execution", 
    Value = (getAutoLoad() == configName), 
    Callback = function(Value) 
        if Value then setAutoLoad(configName) else setAutoLoad("none") end 
    end 
})

ConfigSection:Button({ 
    Title = "Save Config", 
    Icon = "check", 
    Callback = function() 
        configFile = ConfigManager:CreateConfig(configName) 
        if configFile:Save() then 
            local newList = ConfigManager:AllConfigs() 
            if #newList == 0 then table.insert(newList, "Configs") end 
            ConfigDropdown:Refresh(newList) 
            WindUI:Notify({ Title = "Save Config", Content = "Saved: " .. configName, Duration = 3 }) 
        end 
    end 
})

ConfigSection:Button({ 
    Title = "Load Config", 
    Icon = "refresh-cw", 
    Callback = function() 
        configFile = ConfigManager:CreateConfig(configName) 
        if configFile:Load() then 
            WindUI:Notify({ Title = "Load Config", Content = "Loaded: " .. configName, Duration = 3 }) 
        end 
    end 
})

Window:OnClose(function() 
    if ConfigManager and configFile then configFile:Save() end 
end)

task.spawn(function()
    task.wait(1.5)
    local autoConf = getAutoLoad()
    if autoConf ~= "none" then
        configName = autoConf
        configFile = ConfigManager:CreateConfig(configName)
        pcall(function()
            configFile:Load()
            WindUI:Notify({ Title = "Auto-Load Enabled", Content = "Loaded config: " .. configName, Duration = 3 })
        end)
    end
    
ThemeSection:Keybind({ Title = "Keybind", Desc = "Keybind to hide/open UI", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

print("Successfully loaded all assets! Purium on Top!")

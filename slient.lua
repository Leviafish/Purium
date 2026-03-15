print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Script...", Duration = 3 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Silent Assassin |", Icon = "door-open", Author = "Version : 0.0.1", Folder = "Purium_Silent-Assassin",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})

Window:EditOpenButton({
    Title = "Open UI",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(Color3.fromHex("1e1e1e"), Color3.fromHex("000000")),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
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

Window:Tag({ Title = "v1.6.6", Icon = "github", Color = Color3.fromRGB(48, 255, 106), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local GameRemote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("GameRemoteFunction")

_G.AntiSlow = false
_G.LastAttackTime = 0

local oldNamecall
oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
        if _G.AntiSlow and args[1] == "AttemptWeaponHit" and type(args[2]) == "table" then
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
    return oldNamecall(self, ...)
end)

local BypassTab = Window:Tab({ Title = "Server Modification", Icon = "shield-alert" })
local CombatTab = Window:Tab({ Title = "Combat & Farm", Icon = "swords" })
local MoveTab = Window:Tab({ Title = "Movement", Icon = "move" })
local VisTab = Window:Tab({ Title = "Visuals (ESP)", Icon = "eye" })
local PlayerTab = Window:Tab({ Title = "Players List", Icon = "users" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local function getNearestTarget()
    local nearest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            local hum = p.Character:FindFirstChild("Humanoid")
            if hrp and hum and hum.Health > 0 then
                local dist = (hrp.Position - char.HumanoidRootPart.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    nearest = p.Character
                end
            end
        end
    end
    return nearest
end

local MoveSec = MoveTab:Section({ Title = "Character Modification", Icon = "user", Opened = true, Box = true })

local noclipLoop
MoveSec:Toggle({ Title = "Enable Noclip", Desc = "Walk through walls and obstacles", Value = false, Callback = function(v)
    if v then 
        noclipLoop = RunService.Stepped:Connect(function() 
            pcall(function()
                if LocalPlayer.Character then 
                    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do 
                        if p:IsA("BasePart") and p.CanCollide then 
                            p.CanCollide = false 
                        end 
                    end 
                end 
            end)
        end) 
    else 
        if noclipLoop then 
            noclipLoop:Disconnect()
            noclipLoop = nil 
        end 
    end
end})

MoveSec:Divider()

_G.WsEnabled = false
_G.WsValue = 25
MoveSec:Toggle({ Title = "Enable WalkSpeed", Desc = "Modify your movement speed", Value = false, Callback = function(v) 
    _G.WsEnabled = v
    if not v then 
        pcall(function() LocalPlayer.Character.Humanoid.WalkSpeed = 16 end) 
    end 
end})

MoveSec:Slider({ Title = "Speed Amount", Value = {Min = 16, Max = 15000, Default = 25}, Callback = function(v) 
    _G.WsValue = v 
end})

MoveSec:Divider()

_G.JpEnabled = false
_G.JpValue = 100
MoveSec:Toggle({ Title = "Enable JumpPower", Desc = "Modify your jump height", Value = false, Callback = function(v) 
    _G.JpEnabled = v
    if not v then 
        pcall(function() LocalPlayer.Character.Humanoid.JumpPower = 50 end) 
    end 
end})

MoveSec:Slider({ Title = "Jump Amount", Value = {Min = 50, Max = 2500, Default = 100}, Callback = function(v) 
    _G.JpValue = v 
end})

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
local HitboxSec = BypassTab:Section({ Title = "Hitbox Expander", Icon = "maximize", Opened = true, Box = true })

_G.HitboxStatus = false
_G.HitboxSize = 25
_G.HitboxTransparency = 70
_G.HitboxColorMode = "Pre-defined"
_G.HitboxStyle = "Red (Default)"
_G.HitboxCustomRGB = "255, 0, 0"
_G.HitboxCustomHEX = "#FF0000"

HitboxSec:Toggle({ Title = "Enable Hitbox Expander", Desc = "Expand enemy body parts to hit them easily", Value = false, Callback = function(v) 
    _G.HitboxStatus = v 
end})

HitboxSec:Slider({ Title = "Hitbox Size", Value = {Min = 5, Max = 100, Default = 25}, Callback = function(v) 
    _G.HitboxSize = v 
end})

HitboxSec:Slider({ Title = "Hitbox Transparency", Desc = "Adjust the visibility of the hitbox (0-100)", Value = {Min = 0, Max = 100, Default = 70}, Callback = function(v) 
    _G.HitboxTransparency = v 
end})

HitboxSec:Dropdown({ Title = "Hitbox Color Mode", Values = {"Pre-defined", "Custom RGB", "Custom HEX"}, Value = "Pre-defined", Callback = function(v) 
    _G.HitboxColorMode = v 
end})

HitboxSec:Dropdown({ Title = "Pre-defined Colors & Style", Values = {"Red (Default)", "White", "Light Blue", "Black", "Transparent Outline", "Custom"}, Value = "Red (Default)", Callback = function(v) 
    _G.HitboxStyle = v 
end})

HitboxSec:Input({ Title = "Custom Main Color (Fill)", Value = "255, 0, 0", Callback = function(v) 
    _G.HitboxCustomRGB = v 
end})

HitboxSec:Input({ Title = "Custom Outline Color (Border)", Value = "255, 255, 255", Callback = function(v) 
    _G.HitboxCustomHEX = v 
end})

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
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
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
                        if _G.HitboxStyle == "White" then 
                            mainC = Color3.fromRGB(255, 255, 255)
                        elseif _G.HitboxStyle == "Light Blue" then 
                            mainC = Color3.fromRGB(0, 255, 255)
                        elseif _G.HitboxStyle == "Black" then 
                            mainC = Color3.fromRGB(0, 0, 0)
                        elseif _G.HitboxStyle == "Transparent Outline" then
                            useFill = false
                            useOutline = true
                            outlineC = Color3.fromRGB(255, 255, 255)
                        elseif _G.HitboxStyle == "Custom" then
                            useFill = true
                            useOutline = true
                            mainC = Color3.fromRGB(255, 0, 0)
                        end
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
                        if hrp:FindFirstChild("HitboxSelection") then 
                            hrp.HitboxSelection:Destroy() 
                        end
                    end
                else
                    hrp.Size = Vector3.new(2, 2, 1)
                    hrp.Transparency = 1
                    if hrp:FindFirstChild("HitboxSelection") then 
                        hrp.HitboxSelection:Destroy() 
                    end
                end
            end
        end
    end)
end)

HitboxSec:Divider()

_G.DesyncGodMode = false

MoveSec:Toggle({ Title = "God Mode", Desc = "Make You Invincible But Didn't Work With Other Hackers", Value = false, Callback = function(v) 
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
                if hrp.Position.Y > 20000 then
                    hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0)
                end
            end
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
        cp.Size = Vector3.new(1, 1, 1)
        cp.Parent = Workspace
    end
    return cp
end

RunService.Heartbeat:Connect(function()
    pcall(function()
        if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if tick() - _G.LastAttackTime > 0.2 then
                if hrp.Position.Y < 20000 then
                    local vel = hrp.AssemblyLinearVelocity
                    local rot = hrp.AssemblyAngularVelocity
                    hrp.CFrame = hrp.CFrame + Vector3.new(0, 50000, 0)
                    hrp.AssemblyLinearVelocity = vel
                    hrp.AssemblyAngularVelocity = rot
                end
            else
                if hrp.Position.Y > 20000 then
                    local vel = hrp.AssemblyLinearVelocity
                    local rot = hrp.AssemblyAngularVelocity
                    hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0)
                    hrp.AssemblyLinearVelocity = vel
                    hrp.AssemblyAngularVelocity = rot
                end
            end
        end
    end)
end)

RunService.RenderStepped:Connect(function()
    pcall(function()
        if _G.DesyncGodMode and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            if hrp.Position.Y > 20000 then
                local vel = hrp.AssemblyLinearVelocity
                local rot = hrp.AssemblyAngularVelocity
                hrp.CFrame = hrp.CFrame - Vector3.new(0, 50000, 0)
                hrp.AssemblyLinearVelocity = vel
                hrp.AssemblyAngularVelocity = rot
            end
            
            local cp = getFakeCamPart()
            cp.CFrame = hrp.CFrame
            Camera.CameraSubject = cp
        end
    end)
end)

LocalPlayer.CharacterAdded:Connect(function()
    pcall(function()
        local cp = Workspace:FindFirstChild("PuriumCamPart")
        if cp then cp:Destroy() end
    end)
end)

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

HitboxSec:Divider()

local FlingSec = BypassTab:Section({ Title = "Physics Fling Exploit(Didn't Work)", Icon = "wind", Opened = true, Box = true })

_G.FlingActive = false
_G.FlingMode = "Touch Fling"
_G.FlingTarget = ""

FlingSec:Toggle({ Title = "Enable Fling", Desc = "", Value = false, Callback = function(v) 
    _G.FlingActive = v 
end})

FlingSec:Dropdown({ Title = "Fling Mode", Values = {"Touch Fling", "Fling Target", "Fling All"}, Value = "Touch Fling", Callback = function(v) 
    _G.FlingMode = v 
end})

FlingSec:Input({ Title = "Target Username (For Target Mode)", Value = "", Callback = function(v) 
    _G.FlingTarget = v 
end})

RunService.Heartbeat:Connect(function()
    pcall(function()
        if _G.FlingActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local myHrp = LocalPlayer.Character.HumanoidRootPart
            
            -- Vô hiệu hóa va chạm và khối lượng để không bao giờ bị văng ngược
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then 
                    part.CanCollide = false 
                    part.Massless = true 
                end
            end

            -- Hàm tông vật lý không cần xoay
            local function executeFling(targetHrp)
                local oldPos = myHrp.CFrame
                myHrp.CFrame = targetHrp.CFrame
                myHrp.Velocity = Vector3.new(50000, 50000, 50000)
                
                -- Nếu dùng Aura Fling, trả nhân vật về vị trí cũ lập tức để đi lại bình thường
                if _G.FlingMode == "Touch Fling" then
                    task.wait()
                    myHrp.CFrame = oldPos
                    myHrp.Velocity = Vector3.new(0, 0, 0)
                end
            end

            -- Các chế độ Fling
            if _G.FlingMode == "Touch Fling" then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local tHrp = p.Character.HumanoidRootPart
                        if (tHrp.Position - myHrp.Position).Magnitude < 10 then
                            executeFling(tHrp)
                        end
                    end
                end
            elseif _G.FlingMode == "Fling Target" and _G.FlingTarget ~= "" then
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and string.find(string.lower(p.Name), string.lower(_G.FlingTarget)) and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        executeFling(p.Character.HumanoidRootPart)
                        break
                    end
                end
            elseif _G.FlingMode == "Fling All" then
                local targets = {}
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
                        table.insert(targets, p.Character.HumanoidRootPart)
                    end
                end
                if #targets > 0 then
                    executeFling(targets[math.random(1, #targets)])
                end
            end
        end
    end)
end)

local CombatSec = CombatTab:Section({ Title = "Attack Settings", Icon = "crosshair", Opened = true, Box = true })

_G.AntiSlow = false
CombatSec:Toggle({ Title = "Enable Anti-Slow", Desc = "Remove Slow while swinging weapon", Value = false, Callback = function(v) 
    _G.AntiSlow = v 
end})

CombatSec:Divider()

_G.AttackDelay = 0
CombatSec:Slider({ Title = "Attack Delay (Seconds)", Desc = "Choose your kill speed less mean more faster", Value = {Min = 0, Max = 20, Default = 5}, Callback = function(v) 
    _G.AttackDelay = v 
end})

CombatSec:Divider()

local function getNearestTarget()
    local nearest = nil
    local minDist = math.huge
    local char = LocalPlayer.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    
    local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or char.HumanoidRootPart.Position
    
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

local function AttemptWeaponHit(TargetChar)
    pcall(function()
        local Char = LocalPlayer.Character
        if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
        if not TargetChar or not TargetChar:FindFirstChild("HumanoidRootPart") then return end
        
        local MyTool = Char:FindFirstChildOfClass("Tool")
        if not MyTool then 
            local backpackTool = LocalPlayer.Backpack:FindFirstChildOfClass("Tool")
            if backpackTool then
                pcall(function() LocalPlayer.Character.Humanoid:EquipTool(backpackTool) end)
                MyTool = backpackTool
            else
                return
            end
        end
        
        _G.LastAttackTime = tick()
        
        local isSlow = _G.AntiSlow and false or true
        local slowMul = _G.AntiSlow and 1 or 0.2
        local slowTim = _G.AntiSlow and 0 or 1.5
        
        local fakeOrigin = TargetChar.HumanoidRootPart.Position
        local direction = Vector3.new(0, 0, 1)
        
        local Args = {
            "AttemptWeaponHit",
            {
                attackCycleData = {knockbackMul=1,slowMult=slowMul,attackTime=0.65,lungeMul=1,slowTime=slowTim},
                knockback = 50, shouldLock = true, shouldLunge = true,
                hitboxOffset = Vector3.new(0, 0, -1.5), isCritical = true, shouldSlow = isSlow,
                attackCooldown = 0, damage = 100, lungeKnockback = 55, cycleIndex = 1,
                slowMult = slowMul, hitboxSize = Vector3.new(100, 100, 100),
                weaponDefinition = { 
                    attackCycle = { 
                        ["1"] = {knockbackMul=1, slowMult=slowMul, attackTime=0.65, lungeMul=1, slowTime=slowTim}, 
                        ["4"] = {lungeMult=2.25, attackTime=0.98, slowMult=slowMul, hitboxOffsetAdd=Vector3.new(0,0,-1.5), hitboxSizeAdd=Vector3.new(0,0,3), knockbackMult=2.25, slowTime=slowTim}, 
                        ["3"] = {lungeMult=0.75, slowMult=slowMul, attackTime=0.71, knockbackMult=1.5, slowTime=slowTim}, 
                        ["2"] = {lungeMult=1, slowMult=slowMul, attackTime=0.65, knockbackMult=1, slowTime=slowTim} 
                    }, 
                    attackOrder = {"1", "2", "3", "4"} 
                },
                tool = MyTool, slowTime = slowTim
            },
            {{ knockback = 50, isClosestEnemy = true, origin = fakeOrigin, enemyModel = TargetChar, distance = 0.1, direction = direction }}
        }
        
        task.spawn(function()
            pcall(function() GameRemote:InvokeServer(unpack(Args)) end)
        end)
    end)
end

_G.KillAll = false
CombatSec:Toggle({ Title = "Kill All Players", Desc = "After The Rewrite It Now Is Better And More Win Chance", Value = false, Callback = function(v) 
    _G.KillAll = v 
end})

task.spawn(function()
    while true do
        task.wait(0.01)
        if _G.KillAll then
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Character then
                            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
                            local hum = p.Character:FindFirstChild("Humanoid")
                            if hrp and hum and hum.Health > 0 then
                                AttemptWeaponHit(p.Character)
                            end
                        end
                    end
                end
            end)
            task.wait(math.max(_G.AttackDelay, 0.05))
        end
    end
end)

CombatSec:Divider()

_G.AutoHit = false
_G.HitRange = 15
CombatSec:Toggle({ Title = "Auto Hit By Distance", Desc = "Automatically attack enemies near you", Value = false, Callback = function(v) 
    _G.AutoHit = v 
end})

CombatSec:Slider({ Title = "Auto Hit Range", Value = {Min = 5, Max = 100, Default = 15}, Callback = function(v) 
    _G.HitRange = v 
end})

task.spawn(function()
    while true do
        task.wait(0.01)
        if _G.AutoHit and not _G.KillAll then
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local target = getNearestTarget()
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        local myPos = (_G.DesyncGodMode and _G.LastSafeCFrame) and _G.LastSafeCFrame.Position or LocalPlayer.Character.HumanoidRootPart.Position
                        local dist = (target.HumanoidRootPart.Position - myPos).Magnitude
                        if dist <= _G.HitRange then 
                            AttemptWeaponHit(target)
                        end
                    end
                end
            end)
            task.wait(math.max(_G.AttackDelay, 0.03))
        end
    end
end)

CombatSec:Divider()

_G.AutoFarm = false
CombatSec:Toggle({ Title = "Auto Farm", Desc = "Teleport behind targets and eliminate them", Value = false, Callback = function(v) 
    _G.AutoFarm = v 
end})

task.spawn(function()
    while true do
        task.wait(0.01)
        if _G.AutoFarm then
            pcall(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local target = getNearestTarget()
                    if target and target:FindFirstChild("HumanoidRootPart") then
                        local hrp = LocalPlayer.Character.HumanoidRootPart
                        local tHrp = target.HumanoidRootPart
                        
                        if _G.DesyncGodMode and _G.LastSafeCFrame then
                            _G.LastSafeCFrame = tHrp.CFrame * CFrame.new(0, 0, 3)
                        else
                            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 0, 3)
                        end
                        
                        AttemptWeaponHit(target)
                        
                        if _G.DesyncGodMode and _G.LastSafeCFrame then
                            _G.LastSafeCFrame = tHrp.CFrame * CFrame.new(0, 25, 0)
                        else
                            hrp.CFrame = tHrp.CFrame * CFrame.new(0, 25, 0)
                        end
                        
                        hrp.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
            task.wait(math.max(_G.AttackDelay, 0.05))
        end
    end
end)

local AimSec = CombatTab:Section({ Title = "Aimbot Configuration", Icon = "crosshair", Opened = true, Box = true })
_G.AimbotMode = "None"
AimSec:Dropdown({ Title = "Select Aimbot Mode", Values = {"None", "Camera", "Character", "Camera & Character"}, Value = "None", Callback = function(v) 
    _G.AimbotMode = v 
end})

RunService.RenderStepped:Connect(function()
    pcall(function()
        if _G.AimbotMode ~= "None" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local target = getNearestTarget()
            if target and target:FindFirstChild("HumanoidRootPart") then
                local myHrp = LocalPlayer.Character.HumanoidRootPart
                local tPos = target.HumanoidRootPart.Position
                if _G.AimbotMode == "Camera" or _G.AimbotMode == "Camera & Character" then
                    Camera.CFrame = CFrame.lookAt(Camera.CFrame.Position, tPos)
                end
                if _G.AimbotMode == "Character" or _G.AimbotMode == "Camera & Character" then
                    if _G.DesyncGodMode and _G.LastSafeCFrame then
                        _G.LastSafeCFrame = CFrame.lookAt(_G.LastSafeCFrame.Position, Vector3.new(tPos.X, _G.LastSafeCFrame.Position.Y, tPos.Z))
                    else
                        myHrp.CFrame = CFrame.lookAt(myHrp.Position, Vector3.new(tPos.X, myHrp.Position.Y, tPos.Z))
                    end
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
                            Highlight = Instance.new("Highlight") 
                        }
                        d.Name.Size = 16
                        d.Name.Center = true
                        d.Name.Outline = true
                        d.Name.Font = 2
                        
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
                        
                        d.Name.Color = teamColor
                        d.Name.Text = player.Name .. " ["..math.floor(dist).."m]"
                        d.Name.Position = Vector2.new(rootPos.X, rootPos.Y - 40)
                        d.Name.Visible = _G.ShowESP
                        
                        d.Highlight.FillColor = teamColor
                        d.Highlight.Parent = char
                        d.Highlight.Enabled = _G.ShowESP
                    else 
                        d.Name.Visible = false
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
VisSec:Toggle({ Title = "Enable ESP (Chams & Name)", Desc = "Draws highlight and name around players", Value = false, Callback = function(v)
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

local FinderSec = PlayerTab:Section({ Title = "Blox Finder (Server Sniper)", Icon = "search", Opened = true, Box = true })

-- [THUẬT TOÁN VƯỢT TƯỜNG LỬA API TỰ ĐỘNG]
local function ProxiedFetch(subdomain, path, method, body)
    local HttpService = game:GetService("HttpService")
    local reqFunc = request or http_request or (syn and syn.request) or (fluxus and fluxus.request)
    local domains = { "roproxy.com", "roblox.com" }
    
    for _, domain in ipairs(domains) do
        local fullUrl = "https://" .. subdomain .. "." .. domain .. path
        if reqFunc then
            local options = {
                Url = fullUrl,
                Method = method or "GET",
                Headers = { ["Content-Type"] = "application/json", ["Accept"] = "application/json" }
            }
            if body then options.Body = HttpService:JSONEncode(body) end
            local success, res = pcall(function() return reqFunc(options) end)
            if success and res and type(res) == "table" and res.Body and string.find(res.Body, "{") then
                return true, res.Body
            end
        end
        if not body and (method == "GET" or not method) then
            local success, res = pcall(function() return game:HttpGet(fullUrl) end)
            if success and res and type(res) == "string" and string.find(res, "{") then
                return true, res
            end
        end
    end
    return false, nil
end

FinderSec:Divider()

_G.TargetGameMode = "Current Game"
FinderSec:Dropdown({ Title = "Search Game Mode", Values = {"Current Game", "Game ID", "Game Name"}, Value = "Current Game", Callback = function(v) 
    _G.TargetGameMode = v 
end})

_G.GameInfoInput = ""
FinderSec:Input({ Title = "Game Info (ID or Name)", Value = "", Callback = function(v) 
    _G.GameInfoInput = v 
end})

FinderSec:Button({ Title = "Find Target & Auto-Join", Icon = "radar", Callback = function() 
    if _G.PlayerToFind == "" then
        WindUI:Notify({Title = "Error", Content = "Please input a username!", Duration = 3})
        return
    end
    
    local targetUser = _G.PlayerToFind
    local extractedName = string.match(targetUser, "@([%w_]+)")
    if not extractedName then extractedName = targetUser end
    extractedName = string.gsub(extractedName, "%s+", "")
    
    WindUI:Notify({Title = "Searching", Content = "Target: " .. extractedName .. ". Preparing multi-scan...", Duration = 4})
    
    task.spawn(function()
        local HttpService = game:GetService("HttpService")
        local TeleportService = game:GetService("TeleportService")
        
        local successId, targetId = pcall(function() return Players:GetUserIdFromNameAsync(extractedName) end)
        if not successId or not targetId then
            WindUI:Notify({Title = "Error", Content = "Invalid username: " .. extractedName, Duration = 3})
            return
        end
        
        local targetPlaces = {}
        
        if _G.TargetGameMode == "Current Game" then
            table.insert(targetPlaces, game.PlaceId)
            if Players:GetPlayerByUserId(targetId) then
                WindUI:Notify({Title = "Found", Content = "Player is already in your current server!", Duration = 5})
                return
            end
        elseif _G.TargetGameMode == "Game ID" then
            local pid = tonumber(_G.GameInfoInput)
            if not pid then 
                WindUI:Notify({Title = "Error", Content = "Invalid Game ID!", Duration = 3})
                return 
            end
            table.insert(targetPlaces, pid)
        elseif _G.TargetGameMode == "Game Name" then
            if _G.GameInfoInput == "" then
                WindUI:Notify({Title = "Error", Content = "Please input a Game Name!", Duration = 3})
                return
            end
            
            local successReq, resBody = ProxiedFetch("games", "/v1/games/list?model.keyword=" .. HttpService:UrlEncode(_G.GameInfoInput) .. "&model.maxRows=50", "GET")
            if successReq and resBody then
                local data = HttpService:JSONDecode(resBody)
                if data and data.games and #data.games > 0 then
                    table.sort(data.games, function(a, b) return (a.playerCount or 0) > (b.playerCount or 0) end)
                    for i = 1, math.min(#data.games, 15) do
                        table.insert(targetPlaces, data.games[i].placeId)
                    end
                    WindUI:Notify({Title = "Multi-Scan", Content = "Scanning top " .. #targetPlaces .. " populated games...", Duration = 4})
                else
                    WindUI:Notify({Title = "Error", Content = "Game not found!", Duration = 3})
                    return
                end
            else
                WindUI:Notify({Title = "Error", Content = "API request failed. Try Game ID mode.", Duration = 3})
                return
            end
        end
        
        local targetImageUrl = ""
        local successImg, resBody = ProxiedFetch("thumbnails", "/v1/users/avatar-headshot?userIds="..targetId.."&size=150x150&format=Png&isCircular=false", "GET")
        if successImg and resBody then 
            targetImageUrl = HttpService:JSONDecode(resBody).data[1].imageUrl
        else
            WindUI:Notify({Title = "Error", Content = "Failed to fetch avatar data.", Duration = 3})
            return
        end

        local foundServer = nil
        local serverData = nil
        local successPlaceId = nil

        for _, scanPlaceId in ipairs(targetPlaces) do
            if foundServer then break end
            local cursor = ""
            local attempts = 0
            
            while cursor ~= nil and not foundServer and attempts < 100 do
                attempts = attempts + 1
                local path = "/v1/games/"..scanPlaceId.."/servers/Public?sortOrder=Asc&limit=100"
                if cursor ~= "" then path = path .. "&cursor=" .. cursor end
                
                local successReq, resBody = ProxiedFetch("games", path, "GET")
                if successReq and resBody then
                    local data = HttpService:JSONDecode(resBody)
                    if data and data.data then
                        local allTokens = {}
                        local tokenToServer = {}
                        
                        for _, server in pairs(data.data) do
                            if server.playing and server.playerTokens and server.id ~= game.JobId then
                                for _, token in ipairs(server.playerTokens) do
                                    table.insert(allTokens, token)
                                    tokenToServer[token] = { id = server.id, playing = server.playing, maxPlayers = server.maxPlayers }
                                end
                            end
                        end
                        
                        for i = 1, #allTokens, 100 do
                            local postData = {}
                            for j = i, math.min(i + 99, #allTokens) do
                                table.insert(postData, {
                                    requestId = allTokens[j],
                                    type = "AvatarHeadShot",
                                    targetId = 0,
                                    token = allTokens[j],
                                    format = "png",
                                    size = "150x150"
                                })
                            end
                            
                            local successPost, postResBody = ProxiedFetch("thumbnails", "/v1/batch", "POST", postData)
                            if successPost and postResBody then
                                local resultPost = HttpService:JSONDecode(postResBody)
                                if resultPost and resultPost.data then
                                    for _, avatar in pairs(resultPost.data) do
                                        if avatar.imageUrl == targetImageUrl then
                                            local sData = tokenToServer[avatar.requestId]
                                            if sData then
                                                foundServer = sData.id
                                                serverData = sData
                                                successPlaceId = scanPlaceId
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                            if foundServer then break end
                        end
                        cursor = data.nextPageCursor
                    else
                        break
                    end
                else
                    break
                end
                task.wait(0.1)
            end
        end

        if foundServer and serverData and successPlaceId then
            pcall(function() setclipboard(tostring(foundServer)) end)
            
            if serverData.playing >= serverData.maxPlayers then
                WindUI:Notify({Title = "Server Full", Content = "Target found but server is full. JobId copied!", Duration = 7})
            else
                WindUI:Notify({Title = "Success", Content = "Found target! JobId copied. Teleporting...", Duration = 5})
                task.wait(1)
                TeleportService:TeleportToPlaceInstance(successPlaceId, foundServer, LocalPlayer)
            end
        else
            WindUI:Notify({Title = "Not Found", Content = "Target is not in the scanned servers.", Duration = 5})
        end
    end)
end})

FinderSec:Divider()

_G.JobIdToJoin = ""
FinderSec:Input({ Title = "Target JobId", Value = "", Callback = function(v) 
    _G.JobIdToJoin = v 
end})

FinderSec:Button({ Title = "Join Server By JobId", Icon = "log-in", Callback = function() 
    if _G.JobIdToJoin ~= "" then
        WindUI:Notify({Title = "Teleporting", Content = "Joining server using provided JobId...", Duration = 3})
        pcall(function() 
            local targetPlaceId = game.PlaceId
            if _G.TargetGameMode == "Game ID" and tonumber(_G.GameInfoInput) then
                targetPlaceId = tonumber(_G.GameInfoInput)
            end
            game:GetService("TeleportService"):TeleportToPlaceInstance(targetPlaceId, _G.JobIdToJoin, LocalPlayer) 
        end)
    else
        WindUI:Notify({Title = "Error", Content = "Please input a valid JobId first!", Duration = 3})
    end
end})


FinderSec:Divider()

_G.PlayerToFind = ""
local TargetInput = FinderSec:Input({ Title = "Target Username (e.g. Name @user)", Value = "", Callback = function(v) 
    _G.PlayerToFind = v 
end})

FinderSec:Button({ Title = "Check Player Status", Icon = "info", Callback = function()
    if _G.PlayerToFind == "" then
        UpdateStatus("Error", "Please input a username!")
        return
    end
    
    local targetUser = _G.PlayerToFind
    local extractedName = string.match(targetUser, "@([%w_]+)")
    if not extractedName then extractedName = targetUser end
    extractedName = string.gsub(extractedName, "%s+", "")
    
    UpdateStatus("Checking...", "Fetching data for " .. extractedName)
    
    task.spawn(function()
        local HttpService = game:GetService("HttpService")
        local successId, targetId = pcall(function() return Players:GetUserIdFromNameAsync(extractedName) end)
        
        if not successId or not targetId then
            UpdateStatus("Error", "Invalid username: " .. extractedName)
            return
        end
        
        local successReq, resBody = ProxiedFetch("presence", "/v1/presence/users", "POST", { userIds = { targetId } })
        
        if successReq and resBody then
            local data = HttpService:JSONDecode(resBody)
            if data and data.userPresences and data.userPresences[1] then
                local p = data.userPresences[1]
                local pType = p.userPresenceType
                local statusMsg = ""
                
                if pType == 0 then statusMsg = "Offline"
                elseif pType == 1 then statusMsg = "Online (No-Game)"
                elseif pType == 2 then 
                    local gameName = p.lastLocation
                    if gameName == "" then gameName = "Hidden Game" end
                    statusMsg = "In-Game: " .. gameName
                elseif pType == 3 then statusMsg = "In Studio"
                else statusMsg = "Unknown Status" end
                
                UpdateStatus("Target: " .. extractedName, "Status: " .. statusMsg)
            else
                UpdateStatus("Error", "Failed to parse presence data.")
            end
        else
            UpdateStatus("Error", "API Blocked! Executor preventing connection.")
        end
    end)
end})

local StatusParagraph = nil
local function UpdateStatus(titleTxt, descTxt)
    pcall(function()
        if StatusParagraph then
            StatusParagraph:Destroy()
        end
    end)
    StatusParagraph = FinderSec:Paragraph({
        Title = titleTxt, 
        Desc = descTxt,
        Image = "user", 
        ImageSize = 20
    })
end

UpdateStatus("Player Status: Waiting...", "Input a username and click check.")


local ThemeSection = SettingTab:Section({ Title = "Themes", Icon = "palette", Opened = true, Box = true })
local validThemes = WindUI:GetThemes()
local themes = {}
for themeName, _ in pairs(validThemes) do table.insert(themes, themeName) end
table.sort(themes)
ThemeSection:Dropdown({ Title = "Theme", Desc = "Choose UI Style", Values = themes, Flag = "ThemeDropdown", Value = "Dark", Callback = function(Value) if validThemes[Value] then pcall(function() WindUI:SetTheme(Value) end) end end })

SettingTab:Space()

local ConsoleSec = SettingTab:Section({ Title = "Console Manager", Icon = "code", Opened = true, Box = true })

local VIM = game:GetService("VirtualInputManager")
ConsoleSec:Button({ Title = "Open Roblox Console (F9)", Icon = "square-terminal", Callback = function() pcall(function() VIM:SendKeyEvent(true, Enum.KeyCode.F9, false, game); task.wait(0.05); VIM:SendKeyEvent(false, Enum.KeyCode.F9, false, game) end) end })

local LogService = game:GetService("LogService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local NORMAL_SIZE = UDim2.new(0, 500, 0, 320)
local MINIMIZED_SIZE = UDim2.new(0, 500, 0, 30)
local MAXIMIZED_SIZE = UDim2.new(0.9, 0, 0.9, 0)
local isMaximized, isMinimized = false, false
local isConsoleOpen = false 
local savedPos = UDim2.new(0.5, -250, 0.5, -160)
    
local customConsoleGui = Instance.new("ScreenGui")
customConsoleGui.Name = "Purium_PremiumConsole"
customConsoleGui.ResetOnSpawn = false
    
local successParent = pcall(function() customConsoleGui.Parent = (gethui and gethui()) or CoreGui end)
if not successParent then pcall(function() customConsoleGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end) end

local consoleFrame = Instance.new("Frame", customConsoleGui)
consoleFrame.Size = UDim2.new(0, 0, 0, 0)
consoleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
consoleFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20) 
consoleFrame.BorderSizePixel = 0
consoleFrame.Visible = false
consoleFrame.ClipsDescendants = true
consoleFrame.Active = true
consoleFrame.Draggable = true
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 10)

local topBar = Instance.new("Frame", consoleFrame)
topBar.Size = UDim2.new(1, 0, 0, 30)
topBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)
    
local fixSquare = Instance.new("Frame", topBar)
fixSquare.Size = UDim2.new(1, 0, 0, 10)
fixSquare.Position = UDim2.new(0, 0, 1, -10)
fixSquare.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
fixSquare.BorderSizePixel = 0

local title = Instance.new("TextLabel", topBar)
title.Size = UDim2.new(1, -100, 1, 0)
title.Position = UDim2.new(0, 15, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Purium's Custome Console"
title.TextColor3 = Color3.fromRGB(220, 220, 220)
title.Font = Enum.Font.GothamBold
title.TextSize = 13
title.TextXAlignment = Enum.TextXAlignment.Left

local btnContainer = Instance.new("Frame", topBar)
btnContainer.Size = UDim2.new(0, 60, 1, 0)
btnContainer.AnchorPoint = Vector2.new(1, 0)
btnContainer.Position = UDim2.new(1, -10, 0, 0)
btnContainer.BackgroundTransparency = 1
    
local listLayoutBtns = Instance.new("UIListLayout", btnContainer)
listLayoutBtns.FillDirection = Enum.FillDirection.Horizontal
listLayoutBtns.VerticalAlignment = Enum.VerticalAlignment.Center
listLayoutBtns.Padding = UDim.new(0, 8)
    
local btnMinimize = Instance.new("TextButton", btnContainer)
btnMinimize.Size = UDim2.new(0, 12, 0, 12)
btnMinimize.BackgroundColor3 = Color3.fromRGB(255, 189, 46)
btnMinimize.Text = ""
Instance.new("UICorner", btnMinimize).CornerRadius = UDim.new(1, 0)
    
local btnMaximize = Instance.new("TextButton", btnContainer)
btnMaximize.Size = UDim2.new(0, 12, 0, 12)
btnMaximize.BackgroundColor3 = Color3.fromRGB(39, 201, 63)
btnMaximize.Text = ""
Instance.new("UICorner", btnMaximize).CornerRadius = UDim.new(1, 0)
    
local btnClose = Instance.new("TextButton", btnContainer)
btnClose.Size = UDim2.new(0, 12, 0, 12)
btnClose.BackgroundColor3 = Color3.fromRGB(255, 95, 86)
btnClose.Text = ""
Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1, 0)

local scrollFrame = Instance.new("ScrollingFrame", consoleFrame)
scrollFrame.Size = UDim2.new(1, -10, 1, -40)
scrollFrame.Position = UDim2.new(0, 5, 0, 35)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    
local listLayout = Instance.new("UIListLayout", scrollFrame)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 3)

local function openConsole() 
    if isConsoleOpen then return end 
    isConsoleOpen = true
    consoleFrame.Visible = true
    local targetSize = NORMAL_SIZE
    local targetPos = savedPos
    if isMaximized then 
        targetSize = MAXIMIZED_SIZE
        targetPos = UDim2.new(0.05, 0, 0.05, 0) 
    elseif isMinimized then 
        targetSize = MINIMIZED_SIZE 
    end 
    TweenService:Create(consoleFrame, TWEEN_INFO, {Size = targetSize, Position = targetPos}):Play() 
end
    
local function hideConsole() 
    if not isConsoleOpen then return end 
    isConsoleOpen = false
    if not isMaximized and not isMinimized then 
        savedPos = consoleFrame.Position 
    end 
    local closeTween = TweenService:Create(consoleFrame, TWEEN_INFO, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(consoleFrame.Position.X.Scale, consoleFrame.Position.X.Offset + (consoleFrame.AbsoluteSize.X/2), consoleFrame.Position.Y.Scale, consoleFrame.Position.Y.Offset + (consoleFrame.AbsoluteSize.Y/2)) })
    closeTween:Play()
    task.delay(0.3, function() 
        if not isConsoleOpen then consoleFrame.Visible = false end 
    end) 
end

btnClose.MouseButton1Click:Connect(hideConsole)
    
btnMinimize.MouseButton1Click:Connect(function() 
    if not isConsoleOpen then return end 
    isMinimized = not isMinimized 
    if isMinimized then 
        if not isMaximized then savedPos = consoleFrame.Position end 
        TweenService:Create(consoleFrame, TWEEN_INFO, {Size = MINIMIZED_SIZE}):Play()
        scrollFrame.Visible = false 
    else 
        scrollFrame.Visible = true
        local targetSize = isMaximized and MAXIMIZED_SIZE or NORMAL_SIZE
        TweenService:Create(consoleFrame, TWEEN_INFO, {Size = targetSize}):Play() 
    end 
end)
    
btnMaximize.MouseButton1Click:Connect(function() 
    if not isConsoleOpen or isMinimized then return end 
    isMaximized = not isMaximized 
    if isMaximized then 
        savedPos = consoleFrame.Position
        TweenService:Create(consoleFrame, TWEEN_INFO, { Size = MAXIMIZED_SIZE, Position = UDim2.new(0.05, 0, 0.05, 0) }):Play() 
    else 
        TweenService:Create(consoleFrame, TWEEN_INFO, { Size = NORMAL_SIZE, Position = savedPos }):Play() 
    end 
end)

local logCount = 0
local function addLog(message, msgType, logTime)
    logCount = logCount + 1
    if logCount > 300 then 
        local oldestLog = scrollFrame:FindFirstChildWhichIsA("TextLabel")
        if oldestLog then 
            oldestLog:Destroy() 
            logCount = logCount - 1 
        end 
    end
        
    local logLbl = Instance.new("TextLabel", scrollFrame)
    logLbl.Size = UDim2.new(1, 0, 0, 18)
    logLbl.BackgroundTransparency = 1
    logLbl.Font = Enum.Font.Code
    logLbl.TextSize = 13
    logLbl.TextXAlignment = Enum.TextXAlignment.Left
    logLbl.TextWrapped = true
    logLbl.AutomaticSize = Enum.AutomaticSize.Y
    
    local timeStr = logTime and os.date("%H:%M:%S", logTime) or os.date("%H:%M:%S")
    local prefix = " [" .. timeStr .. "] "
        
    if msgType == Enum.MessageType.MessageInfo then 
        logLbl.TextColor3 = Color3.fromRGB(0, 170, 255)
        logLbl.Text = prefix .. "[INFO] " .. tostring(message)
    elseif msgType == Enum.MessageType.MessageWarning then 
        logLbl.TextColor3 = Color3.fromRGB(255, 170, 0)
        logLbl.Text = prefix .. "[WARN] " .. tostring(message)
    elseif msgType == Enum.MessageType.MessageError then 
        logLbl.TextColor3 = Color3.fromRGB(255, 60, 60)
        logLbl.Text = prefix .. "[ERROR] " .. tostring(message)
    else 
        logLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
        logLbl.Text = prefix .. "[OUTPUT] " .. tostring(message) 
    end
        
    task.defer(function()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteWindowSize.Y + 9999)
    end)
end

pcall(function()
    local history = LogService:GetLogHistory()
    for _, log in ipairs(history) do
        addLog(log.message, log.messageType, log.timestamp)
    end
end)
    
LogService.MessageOut:Connect(function(msg, msgType) addLog(msg, msgType) end)

pcall(function() 
    game:GetService("ScriptContext").Error:Connect(function(message, trace, script) 
        local fullError = tostring(message) .. "\n" .. tostring(trace) .. "\nSrc: " .. tostring(script)
        addLog(fullError, Enum.MessageType.MessageError) 
    end) 
end)

ConsoleSec:Button({ Title = "Open Custom Console", Icon = "terminal", Callback = function() openConsole() end })
ConsoleSec:Button({ 
    Title = "Test Console Logs", 
    Icon = "flask-conical", 
    Callback = function() 
        print("This is a standard OUTPUT message.")
        warn("This is a WARNING message.")
        pcall(function() game:GetService("TestService"):Message("This is an INFO message.") end)
        task.spawn(function() error("This is an ERROR message triggered for testing.") end) 
    end 
})
    
ConsoleSec:Button({ 
    Title = "Clear Console Data", 
    Icon = "trash", 
    Callback = function() 
        for _, child in ipairs(scrollFrame:GetChildren()) do 
            if child:IsA("TextLabel") then 
                child:Destroy() 
            end 
        end 
        logCount = 0
        pcall(function() WindUI:Notify({Title = "Console", Content = "Cleared All Custom Console Logs!"}) end) 
    end 
})

SettingTab:Space()

local ConfigSection = SettingTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local ConfigManager = Window.ConfigManager
local configName = "MainConfig"
local configFile = ConfigManager:CreateConfig(configName)

local savedConfigs = {"MainConfig"}
pcall(function()
    local fetchedList = ConfigManager:AllConfigs()
    if type(fetchedList) == "table" and #fetchedList > 0 then
        savedConfigs = fetchedList
    end
end)

local ConfigInput = ConfigSection:Input({ Title = "Config Name", Value = configName, Callback = function(value) configName = value or "MainConfig" end })
local AutoLoadToggle
local ConfigDropdown = ConfigSection:Dropdown({ Title = "Choose Saved Config", Values = savedConfigs, Value = configName, AllowNone = false, Callback = function(value) configName = value or "MainConfig" ConfigInput:Set(configName) if AutoLoadToggle then AutoLoadToggle:Set(getAutoLoad() == configName) end end })
AutoLoadToggle = ConfigSection:Toggle({ Title = "Auto-Load Config", Desc = "Enable to auto load this config on execution", Value = (getAutoLoad() == configName), Callback = function(Value) if Value then setAutoLoad(configName) else setAutoLoad("none") end end })
ConfigSection:Button({ Title = "Save Config", Icon = "check", Callback = function() configFile = ConfigManager:CreateConfig(configName) if configFile:Save() then local newList = {"MainConfig"} pcall(function() newList = ConfigManager:AllConfigs() end) if #newList == 0 then table.insert(newList, "MainConfig") end ConfigDropdown:Refresh(newList) WindUI:Notify({ Title = "Save Config", Content = "Saved: " .. configName, Duration = 3 }) end end })
ConfigSection:Button({ Title = "Load Config", Icon = "refresh-cw", Callback = function() configFile = ConfigManager:CreateConfig(configName) if configFile:Load() then WindUI:Notify({ Title = "Load Config", Content = "Loaded: " .. configName, Duration = 3 }) end end })
Window:OnClose(function() if ConfigManager and configFile then configFile:Save() end end)
task.spawn(function()
    task.wait(1.5)
    local autoConf = getAutoLoad()
    if autoConf ~= "none" then configName = autoConf; configFile = ConfigManager:CreateConfig(configName); pcall(function() configFile:Load(); WindUI:Notify({ Title = "Auto-Load Enabled", Content = "Loaded config: " .. configName, Duration = 3 }) end) end
    task.wait(0.5); pcall(function() Window:Minimize() end); pcall(function() Window:Toggle() end)
    WindUI:Notify({ Title = "UI Minimized", Content = "The Ui Automatic Minized You Can Open By Click The Ui On The Bottom", Duration = 5 })
end)

ThemeSection:Keybind({ Title = "Keybind", Desc = "Keybind to open ui", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })


print("Successfully loaded all assets! Purium on Top!")

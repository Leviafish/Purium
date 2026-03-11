--------------------------------------------------------------------------------------------------------------
-- PART 1: WIND UI SETUP, NOTIFICATIONS & MOVEMENT
--------------------------------------------------------------------------------------------------------------
print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Script...", Duration = 1.5 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Chain |", Icon = "door-open", Author = "Version : 0.0.1", Folder = "Purium_CHAIN",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})
task.spawn(function()
    task.wait(1)
    pcall(function()
        Window:Dialog({
            Title = "Welcome To Purium Script!!",
            Content = "Thanks you guys for using my script!",
            Buttons = {
                { Title = "I Don't Care", Callback = function() end },
                { Title = "Good Boy~", Callback = function() end, Variant = "Primary" }
            }
        })
    end)
end)
Window:EditOpenButton({
    Title = "Open Ui",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new(
        Color3.fromHex("1e1e1e"), 
        Color3.fromHex("000000")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})

WindUI:AddTheme({
    Name = "Amethyst",
    Accent = Color3.fromHex("7E2CB6"),
    Dialog = Color3.fromHex("321E46"),
    Outline = Color3.fromHex("552D78"),
    Text = Color3.fromHex("F0F0F0"),
    Placeholder = Color3.fromHex("AAAAAA"),
    Background = Color3.fromHex("280C47"),
    Button = Color3.fromHex("733796"),
    Icon = Color3.fromHex("AAAAAA"),
    Toggle = Color3.fromHex("7E2CB6"),
    Slider = Color3.fromHex("7E2CB6"),
    Checkbox = Color3.fromHex("7E2CB6"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0.95,
    SliderIcon = Color3.fromHex("AAAAAA"),
    Primary = Color3.fromHex("7E2CB6"),
    LabelBackground = Color3.fromHex("000000"),
    LabelBackgroundTransparency = 0.85,
})

WindUI:AddTheme({
    Name = "Balloon",
    Accent = Color3.fromHex("64AAFF"),
    Dialog = Color3.fromHex("BDE6FF"),
    Outline = Color3.fromHex("82AAE6"),
    Text = Color3.fromHex("1E1E1E"), -- Chữ đen cho nền sáng
    Placeholder = Color3.fromHex("5A5A5A"),
    Background = Color3.fromHex("BDE0FF"),
    Button = Color3.fromHex("A0C8FF"),
    Icon = Color3.fromHex("5A5A5A"),
    Toggle = Color3.fromHex("64AAFF"),
    Slider = Color3.fromHex("64AAFF"),
    Checkbox = Color3.fromHex("64AAFF"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0, -- Nền sáng không để trong suốt
    SliderIcon = Color3.fromHex("5A5A5A"),
    Primary = Color3.fromHex("64AAFF"),
    LabelBackground = Color3.fromHex("FFFFFF"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "SoftCream",
    Accent = Color3.fromHex("CEA35A"),
    Dialog = Color3.fromHex("FFFFF0"),
    Outline = Color3.fromHex("FFE6C8"),
    Text = Color3.fromHex("1E1E1E"), -- Chữ đen
    Placeholder = Color3.fromHex("5A5A5A"),
    Background = Color3.fromHex("FFF5DC"),
    Button = Color3.fromHex("FFD8A1"),
    Icon = Color3.fromHex("5A5A5A"),
    Toggle = Color3.fromHex("CEA35A"),
    Slider = Color3.fromHex("CEA35A"),
    Checkbox = Color3.fromHex("CEA35A"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0,
    SliderIcon = Color3.fromHex("5A5A5A"),
    Primary = Color3.fromHex("CEA35A"),
    LabelBackground = Color3.fromHex("FFFFFF"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Midnight",
    Accent = Color3.fromHex("3432B2"),
    Dialog = Color3.fromHex("252550"),
    Outline = Color3.fromHex("535382"),
    Text = Color3.fromHex("F0F0F0"),
    Placeholder = Color3.fromHex("AAAAAA"),
    Background = Color3.fromHex("141414"),
    Button = Color3.fromHex("6F6CA0"),
    Icon = Color3.fromHex("AAAAAA"),
    Toggle = Color3.fromHex("3432B2"),
    Slider = Color3.fromHex("3432B2"),
    Checkbox = Color3.fromHex("3432B2"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0.95,
    SliderIcon = Color3.fromHex("AAAAAA"),
    Primary = Color3.fromHex("3432B2"),
    LabelBackground = Color3.fromHex("000000"),
    LabelBackgroundTransparency = 0.85,
})

WindUI:AddTheme({
    Name = "Forest",
    Accent = Color3.fromHex("2E8D46"),
    Dialog = Color3.fromHex("233C28"),
    Outline = Color3.fromHex("325A3C"),
    Text = Color3.fromHex("F0F0F0"),
    Placeholder = Color3.fromHex("AAAAAA"),
    Background = Color3.fromHex("142319"),
    Button = Color3.fromHex("467850"),
    Icon = Color3.fromHex("AAAAAA"),
    Toggle = Color3.fromHex("2E8D46"),
    Slider = Color3.fromHex("2E8D46"),
    Checkbox = Color3.fromHex("2E8D46"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0.95,
    SliderIcon = Color3.fromHex("AAAAAA"),
    Primary = Color3.fromHex("2E8D46"),
    LabelBackground = Color3.fromHex("000000"),
    LabelBackgroundTransparency = 0.85,
})

WindUI:AddTheme({
    Name = "Sunset",
    Accent = Color3.fromHex("FF8000"),
    Dialog = Color3.fromHex("3C2319"),
    Outline = Color3.fromHex("82503C"),
    Text = Color3.fromHex("F0F0F0"),
    Placeholder = Color3.fromHex("AAAAAA"),
    Background = Color3.fromHex("281919"),
    Button = Color3.fromHex("A06446"),
    Icon = Color3.fromHex("AAAAAA"),
    Toggle = Color3.fromHex("FF8000"),
    Slider = Color3.fromHex("FF8000"),
    Checkbox = Color3.fromHex("FF8000"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0.95,
    SliderIcon = Color3.fromHex("AAAAAA"),
    Primary = Color3.fromHex("FF8000"),
    LabelBackground = Color3.fromHex("000000"),
    LabelBackgroundTransparency = 0.85,
})

WindUI:AddTheme({
    Name = "AMOLED",
    Accent = Color3.fromHex("FFFFFF"),
    Dialog = Color3.fromHex("000000"),
    Outline = Color3.fromHex("141414"),
    Text = Color3.fromHex("FFFFFF"),
    Placeholder = Color3.fromHex("AAAAAA"),
    Background = Color3.fromHex("000000"),
    Button = Color3.fromHex("0F0F0F"),
    Icon = Color3.fromHex("FFFFFF"),
    Toggle = Color3.fromHex("FFFFFF"),
    Slider = Color3.fromHex("FFFFFF"),
    Checkbox = Color3.fromHex("FFFFFF"),
    PanelBackground = Color3.fromHex("000000"),
    PanelBackgroundTransparency = 0,
    SliderIcon = Color3.fromHex("AAAAAA"),
    Primary = Color3.fromHex("FFFFFF"),
    LabelBackground = Color3.fromHex("000000"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Grape",
    Accent = Color3.fromHex("B7B0DF"),
    Dialog = Color3.fromHex("070012"),
    Outline = Color3.fromHex("141414"),
    Text = Color3.fromHex("FFFFFF"),
    Placeholder = Color3.fromHex("7B90AA"),
    Background = Color3.fromHex("060010"),
    Button = Color3.fromHex("0D0021"),
    Icon = Color3.fromHex("B7B0DF"),
    Toggle = Color3.fromHex("B7B0DF"),
    Slider = Color3.fromHex("B7B0DF"),
    Checkbox = Color3.fromHex("B7B0DF"),
    PanelBackground = Color3.fromHex("070012"),
    PanelBackgroundTransparency = 0.5,
    SliderIcon = Color3.fromHex("B7B0DF"),
    Primary = Color3.fromHex("B7B0DF"),
    LabelBackground = Color3.fromHex("070012"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Bloody",
    Accent = Color3.fromHex("900000"),
    Dialog = Color3.fromHex("550001"),
    Outline = Color3.fromHex("560000"),
    Text = Color3.fromHex("F0F0F0"),
    Placeholder = Color3.fromHex("838383"),
    Background = Color3.fromHex("3D0000"),
    Button = Color3.fromHex("730E15"),
    Icon = Color3.fromHex("F0F0F0"),
    Toggle = Color3.fromHex("900000"),
    Slider = Color3.fromHex("900000"),
    Checkbox = Color3.fromHex("900000"),
    PanelBackground = Color3.fromHex("550001"),
    PanelBackgroundTransparency = 0.5,
    SliderIcon = Color3.fromHex("F0F0F0"),
    Primary = Color3.fromHex("900000"),
    LabelBackground = Color3.fromHex("550001"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Arctic",
    Accent = Color3.fromHex("40E0FF"),
    Dialog = Color3.fromHex("1E2D3C"),
    Outline = Color3.fromHex("233746"),
    Text = Color3.fromHex("F0FAFF"),
    Placeholder = Color3.fromHex("B4C8D2"),
    Background = Color3.fromHex("0A1219"),
    Button = Color3.fromHex("1E2D3C"),
    Icon = Color3.fromHex("40E0FF"),
    Toggle = Color3.fromHex("40E0FF"),
    Slider = Color3.fromHex("40E0FF"),
    Checkbox = Color3.fromHex("40E0FF"),
    PanelBackground = Color3.fromHex("1E2D3C"),
    PanelBackgroundTransparency = 0.5,
    SliderIcon = Color3.fromHex("40E0FF"),
    Primary = Color3.fromHex("40E0FF"),
    LabelBackground = Color3.fromHex("1E2D3C"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Cloud",
    Accent = Color3.fromHex("6DB0FF"),
    Dialog = Color3.fromHex("FFFFFF"),
    Outline = Color3.fromHex("C8DCF0"),
    Text = Color3.fromHex("1E1E1E"), -- Chữ tối trên nền sáng
    Placeholder = Color3.fromHex("828282"),
    Background = Color3.fromHex("F0F8FF"),
    Button = Color3.fromHex("DCEBFA"),
    Icon = Color3.fromHex("1E1E1E"),
    Toggle = Color3.fromHex("6DB0FF"),
    Slider = Color3.fromHex("6DB0FF"),
    Checkbox = Color3.fromHex("6DB0FF"),
    PanelBackground = Color3.fromHex("FFFFFF"),
    PanelBackgroundTransparency = 0,
    SliderIcon = Color3.fromHex("828282"),
    Primary = Color3.fromHex("6DB0FF"),
    LabelBackground = Color3.fromHex("FFFFFF"),
    LabelBackgroundTransparency = 0,
})

WindUI:AddTheme({
    Name = "Sapphire",
    Accent = Color3.fromHex("0F52BA"),
    Dialog = Color3.fromHex("0F192D"),
    Outline = Color3.fromHex("1E2D50"),
    Text = Color3.fromHex("E6E6E6"),
    Placeholder = Color3.fromHex("8C8C8C"),
    Background = Color3.fromHex("0A0F1E"),
    Button = Color3.fromHex("14233C"),
    Icon = Color3.fromHex("E6E6E6"),
    Toggle = Color3.fromHex("0F52BA"),
    Slider = Color3.fromHex("0F52BA"),
    Checkbox = Color3.fromHex("0F52BA"),
    PanelBackground = Color3.fromHex("0F192D"),
    PanelBackgroundTransparency = 0.5,
    SliderIcon = Color3.fromHex("8C8C8C"),
    Primary = Color3.fromHex("0F52BA"),
    LabelBackground = Color3.fromHex("0F192D"),
    LabelBackgroundTransparency = 0,
})

Window:Tag({ Title = "V [0.0.1]", Icon = "github", Color = Color3.fromRGB(48, 255, 106), Radius = 10 })

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

local InfoTab = Window:Tab({ Title = "Information", Icon = "info" })
local NotifyTab = Window:Tab({ Title = "Notifications", Icon = "bell" })
local MainTab = Window:Tab({ Title = "Main & Movement", Icon = "castle" })
local VisualsTab = Window:Tab({ Title = "Visuals & ESP", Icon = "eye" })
local CharTab = Window:Tab({ Title = "Character & Combat", Icon = "user" })
local TpTab = Window:Tab({ Title = "Teleports", Icon = "map-pin" })
local MiscTab = Window:Tab({ Title = "World & Items", Icon = "cog" })
local FarmTab = Window:Tab({ Title = "AutoFarm", Icon = "feather" })
local ServerTab = Window:Tab({ Title = "Servers", Icon = "server" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })

local InfoSection = InfoTab:Section({ Title = "Script Information", Icon = "book-open", Opened = true, Box = true })
InfoSection:Paragraph({
    Title = "Welcome To Purium Hub!", Desc = "Note : Thank You For Using My Script :D !!",
    Image = "alert-triangle", ImageSize = 5
})
InfoSection:Paragraph({
    Title = "Owner | Developers",
    Desc = "@hlck49[Owner]\nHieu&Thanh[Developers]",
})
InfoTab:Space()
local UpdateSection = InfoTab:Section({ 
    Title = "Changelogs & Updates", 
    Icon = "history", 
    Opened = true, 
    Box = true 
})
UpdateSection:Paragraph({
    Title = "Update | Changelogs :",
    Desc = "[+] Fixed Not Load Tabs\n[+] Added Notifications\n[+] Fixed inf stamina\n[+] Improved Esp",
})

local NotifSec = NotifyTab:Section({ Title = "Smart Notifications", Icon = "bell", Opened = true, Box = true })
local notifSet = { power = true, roundTime = true, chain = true, artifact = true, airdrop = true }

NotifSec:Toggle({ Title = "Low Power (30%)", Value = true, Callback = function(v) notifSet.power = v end })
NotifSec:Toggle({ Title = "End of Round (30s)", Value = true, Callback = function(v) notifSet.roundTime = v end })
NotifSec:Toggle({ Title = "CHAIN Spawn / Defeat", Value = true, Callback = function(v) notifSet.chain = v end })
NotifSec:Toggle({ Title = "Artifact Spawn", Value = true, Callback = function(v) notifSet.artifact = v end })
NotifSec:Toggle({ Title = "Airdrop Spawn", Value = true, Callback = function(v) notifSet.airdrop = v end })

local function playSound() pcall(function() local s = Instance.new("Sound", Workspace); s.SoundId = "rbxassetid://133278612669127"; s.Volume = 7; s:Play(); game:GetService("Debris"):AddItem(s, 3) end) end

task.spawn(function()
    local valFolder = Workspace:WaitForChild("GameStuff", 5) and Workspace.GameStuff:WaitForChild("Values", 5)
    if valFolder then
        local pN, rN = false, false
        valFolder:GetAttributeChangedSignal("Power"):Connect(function() local v = valFolder:GetAttribute("Power"); if type(v)=="number" and v<=30 and notifSet.power and not pN then pN=true; playSound(); WindUI:Notify({Title="Low Power!", Content="30% power remaining.", Duration=5}) elseif type(v)=="number" and v>30 then pN=false end end)
        valFolder:GetAttributeChangedSignal("RoundTime"):Connect(function() local v = valFolder:GetAttribute("RoundTime"); if type(v)=="number" and v<=30 and notifSet.roundTime and not rN then rN=true; playSound(); WindUI:Notify({Title="Round Ending!", Content="30 seconds remaining!", Duration=5}) elseif type(v)=="number" and v>30 then rN=false end end)
    end
end)

task.spawn(function()
    local aiFolder = Workspace:WaitForChild("Misc", 5) and Workspace.Misc:WaitForChild("AI", 5)
    if not aiFolder then return end
    local chainActive = false
    while task.wait(2) do
        if notifSet.chain then
            local chain = aiFolder:FindFirstChild("CHAIN")
            local isAlive = chain and chain:FindFirstChild("Humanoid") and chain.Humanoid.Health > 0
            if isAlive and not chainActive then chainActive = true; playSound(); WindUI:Notify({Title="‼️ CHAIN SPAWNED ‼️", Content="The main enemy is active.", Duration=6})
            elseif not isAlive and chainActive then chainActive = false; playSound(); WindUI:Notify({Title="✅ CHAIN DEFEATED ✅", Content="The main enemy is dead.", Duration=6}) end
        end
    end
end)

local MainSec = MainTab:Section({ Title = "Bypasses & Tools", Icon = "shield", Opened = true, Box = true })
MainSec:Button({ Title = "Remove Adonis Anticheat(This may make your device lag)", Callback = function() pcall(function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/refs/heads/main/Source.lua"))() WindUI:Notify({Title="Bypassed", Content="Adonis AC Removed!", Duration=3}) end) end })
MainSec:Button({ Title = "Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
MainSec:Button({ Title = "Third Person View", Callback = function() pcall(function() LocalPlayer.CameraMode = Enum.CameraMode.Classic; LocalPlayer.CameraMaxZoomDistance = 1280; LocalPlayer.CameraMinZoomDistance = 0.5 end) end })
MainSec:Button({ Title = "Remove Mask on head", Callback = function() pcall(function() LocalPlayer.Character.Sack.SurfaceAppearance.Parent:Destroy() end) end })

local moveSec = MainTab:Section({ Title = "Movement", Icon = "move", Opened = true, Box = true })

local barrierTask, barrierActive = nil, false
moveSec:Toggle({ Title = "Destroy Invisible Barriers", Value = false, Callback = function(v)
    barrierActive = v; if v then barrierTask = task.spawn(function() while barrierActive do for _, p in ipairs(Workspace:GetDescendants()) do pcall(function() if p:IsA("BasePart") and p.Transparency == 1 and p.CanCollide and not p.Parent:FindFirstChild("Humanoid") then p:Destroy() end end) end task.wait(1.5) end end) end
end})

local clickTpConn
moveSec:Toggle({ Title = "Click Teleport (Ctrl + Click)", Value = false, Callback = function(v)
    if v then clickTpConn = UserInputService.InputBegan:Connect(function(i, g) if not g and i.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then pcall(function() LocalPlayer.Character:MoveTo(LocalPlayer:GetMouse().Hit.Position) end) end end) else if clickTpConn then clickTpConn:Disconnect() clickTpConn=nil end end
end})

local noclipLoop
moveSec:Toggle({ Title = "Noclip", Value = false, Callback = function(v)
    if v then noclipLoop = RunService.Stepped:Connect(function() if LocalPlayer.Character then for _, p in pairs(LocalPlayer.Character:GetDescendants()) do if p:IsA("BasePart") and p.CanCollide then p.CanCollide = false end end end end) else if noclipLoop then noclipLoop:Disconnect() noclipLoop=nil end end
end})

local FLYING = false; local iyflyspeed = 1; local flyKeyDown, flyKeyUp
local function getRoot(char) return char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') end
local function sFLY()
    if FLYING then return end; FLYING = true
    local T = getRoot(LocalPlayer.Character); if not T then return end
    local BG = Instance.new('BodyGyro', T); local BV = Instance.new('BodyVelocity', T)
    BG.P = 9e4; BG.maxTorque = Vector3.new(9e9, 9e9, 9e9); BG.cframe = T.CFrame
    BV.velocity = Vector3.new(0, 0, 0); BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
    local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}; local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}; local SPEED = 0
    task.spawn(function()
        while FLYING and LocalPlayer.Character do
            pcall(function() LocalPlayer.Character.Humanoid.PlatformStand = true end)
            if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then SPEED = 50 elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then SPEED = 0 end
            if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then BV.velocity = ((Camera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((Camera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Camera.CoordinateFrame.p)) * SPEED * iyflyspeed; lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R} elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then BV.velocity = ((Camera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((Camera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - Camera.CoordinateFrame.p)) * SPEED * iyflyspeed else BV.velocity = Vector3.new(0, 0, 0) end
            BG.cframe = Camera.CoordinateFrame; task.wait()
        end
        CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}; SPEED = 0; BG:Destroy(); BV:Destroy()
        pcall(function() LocalPlayer.Character.Humanoid.PlatformStand = false end)
    end)
    local mouse = LocalPlayer:GetMouse()
    flyKeyDown = mouse.KeyDown:Connect(function(KEY) if KEY:lower() == 'w' then CONTROL.F = 1 elseif KEY:lower() == 's' then CONTROL.B = -1 elseif KEY:lower() == 'a' then CONTROL.L = -1 elseif KEY:lower() == 'd' then CONTROL.R = 1 elseif KEY:lower() == 'e' then CONTROL.Q = 1 elseif KEY:lower() == 'q' then CONTROL.E = -1 end end)
    flyKeyUp = mouse.KeyUp:Connect(function(KEY) if KEY:lower() == 'w' then CONTROL.F = 0 elseif KEY:lower() == 's' then CONTROL.B = 0 elseif KEY:lower() == 'a' then CONTROL.L = 0 elseif KEY:lower() == 'd' then CONTROL.R = 0 elseif KEY:lower() == 'e' then CONTROL.Q = 0 elseif KEY:lower() == 'q' then CONTROL.E = 0 end end)
end
local function NOFLY() FLYING = false; if flyKeyDown then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end; pcall(function() LocalPlayer.Character.Humanoid.PlatformStand = false end) end
moveSec:Toggle({ Title = "Fly", Value = false, Callback = function(v) if v then sFLY() else NOFLY() end end })
--------------------------------------------------------------------------------------------------------------
-- PART 2: DYNAMIC HEALTH ESP & TELEPORTS
--------------------------------------------------------------------------------------------------------------
local VisSec = VisualsTab:Section({ Title = "Dynamic Health ESP & Players", Icon = "users", Opened = true, Box = true })
local espElements, espConn = {}, nil

local function getHealthColor(health)
    if health > 100 then return Color3.fromRGB(173, 216, 230)
    elseif health >= 98 then return Color3.fromRGB(144, 238, 144)
    elseif health >= 60 then return Color3.fromRGB(255, 255, 255)
    elseif health >= 30 then return Color3.fromRGB(255, 255, 153)
    elseif health >= 20 then return Color3.fromRGB(255, 69, 0)
    else return Color3.fromRGB(139, 0, 0) end
end

local function cleanEsp(player)
    if espElements[player] then 
        pcall(function() espElements[player].Name:Remove(); espElements[player].Dist:Remove(); espElements[player].Highlight:Destroy() end)
        espElements[player] = nil 
    end
end

local function updatePlayerEsp()
    local activePlayers = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            activePlayers[player] = true
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            local head = char and char:FindFirstChild("Head")
            local hum = char and char:FindFirstChild("Humanoid")

            if char and hrp and head and hum and hum.Health > 0 then
                if not espElements[player] then
                    local d = { Name = Drawing.new("Text"), Dist = Drawing.new("Text"), Highlight = Instance.new("Highlight") }
                    d.Name.Size = 16; d.Name.Center = true; d.Name.Outline = true; d.Name.Font = 2
                    d.Dist.Size = 14; d.Dist.Center = true; d.Dist.Outline = true; d.Dist.Font = 2
                    d.Highlight.FillTransparency = 0.5; d.Highlight.OutlineColor = Color3.fromRGB(255, 255, 255); d.Highlight.OutlineTransparency = 0; d.Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; d.Highlight.Parent = char
                    espElements[player] = d
                end

                local d = espElements[player]; local rootPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                
                if onScreen then
                    local headPos = Camera:WorldToViewportPoint(head.Position + Vector3.new(0, 0.5, 0))
                    local legPos = Camera:WorldToViewportPoint(hrp.Position - Vector3.new(0, 3, 0))
                    local height = math.abs(headPos.Y - legPos.Y)
                    local distNum = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and (LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude or 0
                    local currentColor = getHealthColor(hum.Health)

                    d.Name.Color = currentColor; d.Name.Text = player.Name; d.Name.Position = Vector2.new(rootPos.X, headPos.Y - 20); d.Name.Visible = true
                    d.Dist.Color = Color3.fromRGB(200, 200, 200); d.Dist.Text = "["..math.floor(distNum).."m]"; d.Dist.Position = Vector2.new(rootPos.X, headPos.Y + height + 2); d.Dist.Visible = true
                    d.Highlight.FillColor = currentColor; d.Highlight.Parent = char
                else
                    d.Name.Visible = false; d.Dist.Visible = false
                end
            else cleanEsp(player) end
        end
    end
    for player, _ in pairs(espElements) do if not activePlayers[player] then cleanEsp(player) end end
end

VisSec:Toggle({ Title = "Player ESP", Value = false, Callback = function(v)
    if v then if not espConn then espConn = RunService.RenderStepped:Connect(updatePlayerEsp) end else if espConn then espConn:Disconnect(); espConn = nil end for p, _ in pairs(espElements) do cleanEsp(p) end end
end})

local ItemEspSec = VisualsTab:Section({ Title = "Items & World ESP", Icon = "box", Opened = true, Box = true })
local function simpleHighlight(folder, toggleVar, color)
    task.spawn(function()
        while task.wait(1) do
            if _G[toggleVar] then
                for _, item in ipairs(folder:GetChildren()) do if item:IsA("Model") or item:IsA("BasePart") then if not item:FindFirstChild("WindUI_Chams") then local h = Instance.new("Highlight"); h.Name = "WindUI_Chams"; h.FillColor = color; h.FillTransparency = 0.5; h.OutlineTransparency = 0; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Parent = item end end end
            else
                for _, item in ipairs(folder:GetChildren()) do local h = item:FindFirstChild("WindUI_Chams"); if h then h:Destroy() end end
            end
        end
    end)
end

_G.airdropEsp, _G.artifactEsp, _G.trapEsp, _G.scrapEsp, _G.chainEsp = false, false, false, false, false
ItemEspSec:Toggle({ Title = "Airdrop Chams", Value = false, Callback = function(v) _G.airdropEsp = v; simpleHighlight(Workspace:WaitForChild("GameStuff"):WaitForChild("GameSections"):WaitForChild("AirDrops"), "airdropEsp", Color3.fromRGB(255, 255, 0)) end})
ItemEspSec:Toggle({ Title = "Artifact Chams", Value = false, Callback = function(v) _G.artifactEsp = v; simpleHighlight(Workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Artifacts"), "artifactEsp", Color3.fromRGB(0, 255, 255)) end})
ItemEspSec:Toggle({ Title = "BearTrap Chams", Value = false, Callback = function(v) _G.trapEsp = v; simpleHighlight(Workspace:WaitForChild("GameStuff"):WaitForChild("PlayerStuff"):WaitForChild("BearTraps"), "trapEsp", Color3.fromRGB(138, 43, 226)) end})
ItemEspSec:Toggle({ Title = "Scrap Chams", Value = false, Callback = function(v) _G.scrapEsp = v; simpleHighlight(Workspace:WaitForChild("Misc"):WaitForChild("Zones"):WaitForChild("LootingItems"):WaitForChild("Scrap"), "scrapEsp", Color3.fromRGB(0, 255, 0)) end})

ItemEspSec:Toggle({ Title = "Chain ESP (Red)", Value = false, Callback = function(v)
    _G.chainEsp = v; task.spawn(function() while task.wait(1) do local chain = Workspace:FindFirstChild("Misc") and Workspace.Misc:FindFirstChild("AI") and Workspace.Misc.AI:FindFirstChild("CHAIN")
    if chain then if _G.chainEsp and not chain:FindFirstChild("Chain_ESP") then local h = Instance.new("Highlight"); h.Name = "Chain_ESP"; h.FillColor = Color3.fromRGB(255, 0, 0); h.FillTransparency = 0.5; h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop; h.Parent = chain elseif not _G.chainEsp and chain:FindFirstChild("Chain_ESP") then chain.Chain_ESP:Destroy() end end end end)
end})

local TpSec = TpTab:Section({ Title = "Locations", Icon = "map", Opened = true, Box = true })

local playerNames = {}
for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(playerNames, p.Name) end end
local playerTpDropdown = TpSec:Dropdown({ Title = "Teleport to player 👤", Values = playerNames, Callback = function(sel) local p = Players:FindFirstChild(sel); if p and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame end end})
task.spawn(function() while task.wait(10) do local nn = {}; for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then table.insert(nn, p.Name) end end pcall(function() playerTpDropdown:Refresh(nn) end) end end)

local savedLocs, curLocName, curSelLoc = {}, "", ""
local ownTpSec = TpTab:Section({ Title = "Own Teleports", Icon = "map-pin", Opened = true, Box = true })
ownTpSec:Input({ Title = "Location Name", Callback = function(t) curLocName = t end })
local locDropdown = ownTpSec:Dropdown({ Title = "Select a saved item", Values = {}, Callback = function(v) curSelLoc = v end })
ownTpSec:Button({ Title = "Save Current Position", Callback = function() if curLocName ~= "" and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then savedLocs[curLocName] = LocalPlayer.Character.HumanoidRootPart.CFrame; local names = {}; for n, _ in pairs(savedLocs) do table.insert(names, n) end; locDropdown:Refresh(names); WindUI:Notify({Title="Saved", Content=curLocName}) end end})
ownTpSec:Button({ Title = "Teleport to Selected", Callback = function() if savedLocs[curSelLoc] and LocalPlayer.Character then LocalPlayer.Character.HumanoidRootPart.CFrame = savedLocs[curSelLoc] end end})

local locs = { SafeHouse = CFrame.new(162.68, -94.26, 230.03), WorkShopOut = CFrame.new(130.92, -106.07, -2.17), WorkShopIn = CFrame.new(169.56, -103.65, -30.01), Cabin = CFrame.new(-324.80, -88.61, 290.67), Shop = CFrame.new(-111.37, -87.20, 203.52), PowerStation = CFrame.new(-208.29, -110.60, -120.22), WareHouse = CFrame.new(314.62, -113.51, -258.48), Ritual = CFrame.new(-18.60, -107.77, -229.89) }
for name, cf in pairs(locs) do TpSec:Button({ Title = name, Callback = function() pcall(function() LocalPlayer.Character.HumanoidRootPart.CFrame = cf end) end }) end
TpSec:Button({ Title = "Teleport to nearest Airdrop", Callback = function() pcall(function() local drops = Workspace.GameStuff.GameSections.AirDrops:GetChildren(); if #drops > 0 and LocalPlayer.Character then LocalPlayer.Character:PivotTo(drops[1]:GetPivot() * CFrame.new(0, 10, 0)) end end) end})
--------------------------------------------------------------------------------------------------------------
-- PART 3: COMBAT, AUTOFARM, MISC & SETTINGS
--------------------------------------------------------------------------------------------------------------
local CmbSec = CharTab:Section({ Title = "Combat & Character", Icon = "swords", Opened = true, Box = true })

local infStam, infCombat, autoClash, infGas = false, false, false, false
CmbSec:Toggle({ Title = "Inf Stamina", Value = false, Callback = function(v) infStam = v; task.spawn(function() while infStam do pcall(function() LocalPlayer.Character.Stats.Stamina.Value = 100 end) task.wait(0.5) end end) end})
CmbSec:Toggle({ Title = "Inf Combat Stamina", Value = false, Callback = function(v) infCombat = v; task.spawn(function() while infCombat do pcall(function() LocalPlayer.Character.Stats.CombatStamina.Value = 100 end) task.wait(0.5) end end) end})
CmbSec:Toggle({ Title = "Auto Win XSaw Clash", Value = false, Callback = function(v) autoClash = v; task.spawn(function() while autoClash do pcall(function() LocalPlayer.Character.Stats.ClashStrength.Value = 100 end) task.wait(0.01) end end) end})
CmbSec:Toggle({ Title = "Inf XSaw Gas", Value = false, Callback = function(v) infGas = v; task.spawn(function() while infGas do pcall(function() local c=LocalPlayer.Character; if c and c:FindFirstChild("Items") and c.Items:FindFirstChild("XSaw") then c.Items.XSaw:SetAttribute("Gas", 100) end end) task.wait(0.1) end end) end})

local walkSpeed = 18
CmbSec:Slider({ Title = "Walk Speed", Value = {Min=18, Max=200, Default=18}, Callback = function(v) walkSpeed = v end })
RunService.Heartbeat:Connect(function() pcall(function() local h = LocalPlayer.Character:FindFirstChild("Humanoid"); if h and h.WalkSpeed ~= walkSpeed then h.WalkSpeed = walkSpeed end end) end)

local jumpConn
CmbSec:Toggle({ Title = "Unlock Jump", Value = false, Callback = function(v)
    if v then jumpConn = RunService.Heartbeat:Connect(function() pcall(function() local hum = LocalPlayer.Character:FindFirstChild("Humanoid"); if hum and hum.JumpPower ~= 50 then hum.JumpPower = 50 end end) end) else if jumpConn then jumpConn:Disconnect(); jumpConn = nil end end
end})

CmbSec:Button({ Title = "Enable Inf Dodge (Must remove AC first)", Callback = function()
    local __namecall; __namecall = hookmetamethod(game, "__namecall", function(self, ...) if not checkcaller() and getnamecallmethod() == "FireServer" and self.Name == "CTS" then local args = {...}; if args[1] == "DoneDodge" then args[1] = "Dodge" end return __namecall(self, unpack(args)) end return __namecall(self, ...) end)
    WindUI:Notify({Title="Dodge Enabled", Content="You can now dodge infinitely.", Duration=3})
end})

local aimbot, holdPPM, chainTarget = false, false, nil
CmbSec:Toggle({ Title = "Aimbot on Chain (Hold PPM)", Value = false, Callback = function(v) aimbot = v end })
UserInputService.InputBegan:Connect(function(input, gpe) if not gpe and input.UserInputType == Enum.UserInputType.MouseButton2 then holdPPM = true end end)
UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton2 then holdPPM = false end end)
RunService.RenderStepped:Connect(function()
    if aimbot and holdPPM then
        if not chainTarget or not chainTarget.Parent then for _, c in ipairs(Workspace.Misc.AI:GetChildren()) do if c:FindFirstChild("HumanoidRootPart") then chainTarget = c break end end end
        if chainTarget then Camera.CFrame = CFrame.new(Camera.CFrame.Position, chainTarget:GetPivot().Position) end
    else chainTarget = nil end
end)

local FarmSec = FarmTab:Section({ Title = "Auto Farming", Icon = "feather", Opened = true, Box = true })
local function farmItem(folderPath, toggleVarName, delayTime)
    task.spawn(function()
        while _G[toggleVarName] do
            pcall(function() local folder = folderPath(); if folder then for _, item in ipairs(folder:GetChildren()) do if not _G[toggleVarName] then break end local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true); if prompt and prompt.Enabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then LocalPlayer.Character:PivotTo(item:GetPivot() * CFrame.new(0, 3, 0)); task.wait(0.2); fireproximityprompt(prompt); task.wait(0.5) end end end end); task.wait(delayTime)
        end
    end)
end
_G.FarmScrap = false; FarmSec:Toggle({ Title = "AutoFarm Scrap", Value = false, Callback = function(v) _G.FarmScrap = v; if v then farmItem(function() return Workspace.Misc.Zones.LootingItems.Scrap end, "FarmScrap", 1) end end})
_G.FarmArtifact = false; FarmSec:Toggle({ Title = "AutoFarm Artifacts", Value = false, Callback = function(v) _G.FarmArtifact = v; if v then farmItem(function() return Workspace.Misc.Zones.LootingItems.Artifacts end, "FarmArtifact", 3) end end})

local ItemSec = MiscTab:Section({ Title = "Blueprints & GUIs", Icon = "key", Opened = true, Box = true })
local function unlockBP(name) pcall(function() LocalPlayer.PlayerStats.Blueprints:SetAttribute(name, true); WindUI:Notify({Title="Unlocked", Content=name.." unlocked!"}) end) end
ItemSec:Button({ Title = "Unlock CombatKnife", Callback = function() unlockBP("CombatKnife") end})
ItemSec:Button({ Title = "Unlock DoubleBarrel", Callback = function() unlockBP("DoubleBarrel") end})
ItemSec:Button({ Title = "Unlock M1911", Callback = function() unlockBP("M1911") end})
ItemSec:Button({ Title = "Unlock Machete", Callback = function() unlockBP("Machete") end})

ItemSec:Toggle({ Title = "Hide Blood Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Health.Visible = not v end) end})
ItemSec:Toggle({ Title = "Shop Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Shop.Visible = v end) end})
ItemSec:Toggle({ Title = "Deconstructor Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Deconstructor.Visible = v end) end})
ItemSec:Toggle({ Title = "Workbench Gui", Value = false, Callback = function(v) pcall(function() LocalPlayer.PlayerGui.Ingame.Workbench.Visible = v end) end})

local hideEffectsActive = false
ItemSec:Toggle({ Title = "Hide Annoying Chain Screen effect", Value = false, Callback = function(v) hideEffectsActive = v end})
RunService.Heartbeat:Connect(function() if hideEffectsActive then pcall(function() local mf = LocalPlayer.PlayerGui.Ingame.MechanicsFrame; for _, n in ipairs({"CursedText", "Glitch", "StaticRegular", "StaticScare", "WhiteLines"}) do if mf:FindFirstChild(n) and mf[n].Visible then mf[n].Visible = false end end end) end end)

local WorldSec = MiscTab:Section({ Title = "World & Lighting", Icon = "zap", Opened = true, Box = true })
local Lighting = game:GetService("Lighting")
WorldSec:Button({ Title = "No Fog", Callback = function() Lighting.FogEnd = 100000; for _,v in pairs(Lighting:GetDescendants()) do if v:IsA("Atmosphere") then v:Destroy() end end end})
WorldSec:Toggle({ Title = "Fullbright", Value = false, Callback = function(v) if v then Lighting.Ambient=Color3.new(1,1,1); Lighting.OutdoorAmbient=Color3.new(1,1,1); Lighting.Brightness=2; Lighting.TimeOfDay="14:00:00"; Lighting.GlobalShadows=false end end})

local afkConn
WorldSec:Toggle({ Title = "Anti-AFK", Value = false, Callback = function(v)
    if v then afkConn = LocalPlayer.Idled:Connect(function() game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), Camera.CFrame); task.wait(1); game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), Camera.CFrame) end)
    else if afkConn then afkConn:Disconnect(); afkConn=nil end end
end})

local SrvSec = ServerTab:Section({ Title = "Server Actions", Icon = "server", Opened = true, Box = true })
SrvSec:Button({ Title = "Random Server Hop", Callback = function() WindUI:Notify({Title="Teleporting", Content="Hopping..."}); game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end })
_G.HopSmall = false
SrvSec:Toggle({ Title = "Auto Hop (< 5 Players)", Value = false, Callback = function(v)
    _G.HopSmall = v
    if v then if #Players:GetPlayers() < 5 then WindUI:Notify({Title="Found!", Content="Already in a small server."}); _G.HopSmall=false else game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer) end end
end})
SrvSec:Toggle({ Title = "Auto Rejoin (Anti-Disconnect)", Desc = "Automatically reconnect when disconnected or kicked", Flag = "AutoRejoinToggle", Value = false, Callback = function(Value) if Value then _G.RejoinConnection = GuiService.ErrorMessageChanged:Connect(function() task.wait(0.5) if #game:GetService("Players"):GetPlayers() <= 1 then TeleportService:Teleport(game.PlaceId, _LocalPlayer22) else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _LocalPlayer22) end end) else if _G.RejoinConnection then _G.RejoinConnection:Disconnect(); _G.RejoinConnection = nil end end end })
SrvSec:Button({ Title = "Rejoin Server (Manual)", Desc = "Use when stuck in terrain", Callback = function() if #game:GetService("Players"):GetPlayers() <= 1 then TeleportService:Teleport(game.PlaceId, _LocalPlayer22) else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _LocalPlayer22) end end })

SettingTab:Space()

local ThemeSection = SettingTab:Section({ Title = "Themes", Icon = "palette", Opened = true, Box = true })
local validThemes = WindUI:GetThemes()
local themes = {}
for themeName, _ in pairs(validThemes) do table.insert(themes, themeName) end
table.sort(themes)
ThemeSection:Dropdown({ Title = "Theme", Desc = "Choose UI Style", Values = themes, Flag = "ThemeDropdown", Value = "Dark", Callback = function(Value) if validThemes[Value] then pcall(function() WindUI:SetTheme(Value) end) end end })
SettingTab:Space()
local ConfigSection = SettingTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local ConfigManager = Window.ConfigManager
local configName = "MainConfig"
local configFile = ConfigManager:CreateConfig(configName)
local savedConfigs = ConfigManager:AllConfigs()
if #savedConfigs == 0 then table.insert(savedConfigs, "MainConfig") end
local ConfigInput = ConfigSection:Input({ Title = "Config Name", Value = configName, Callback = function(value) configName = value or "MainConfig" end })
local AutoLoadToggle
local ConfigDropdown = ConfigSection:Dropdown({ Title = "Choose Saved Config", Values = savedConfigs, Value = configName, AllowNone = false, Callback = function(value) configName = value or "MainConfig" ConfigInput:Set(configName) if AutoLoadToggle then AutoLoadToggle:Set(getAutoLoad() == configName) end end })
AutoLoadToggle = ConfigSection:Toggle({ Title = "Auto-Load Config", Desc = "Enable to auto load this config on execution", Value = (getAutoLoad() == configName), Callback = function(Value) if Value then setAutoLoad(configName) else setAutoLoad("none") end end })
ConfigSection:Button({ Title = "Save Config", Icon = "check", Callback = function() configFile = ConfigManager:CreateConfig(configName) if configFile:Save() then local newList = ConfigManager:AllConfigs() if #newList == 0 then table.insert(newList, "MainConfig") end ConfigDropdown:Refresh(newList) WindUI:Notify({ Title = "Save Config", Content = "Saved: " .. configName, Duration = 3 }) end end })
ConfigSection:Button({ Title = "Load Config", Icon = "refresh-cw", Callback = function() configFile = ConfigManager:CreateConfig(configName) if configFile:Load() then WindUI:Notify({ Title = "Load Config", Content = "Loaded: " .. configName, Duration = 3 }) end end })
Window:OnClose(function() if ConfigManager and configFile then configFile:Save() end end)
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
    task.wait(0.5)
    pcall(function()
        Window:Minimize()
    end)
    pcall(function()
        Window:Toggle() 
    end)
    WindUI:Notify({
        Title = "UI Minimized",
        Content = "The Ui Automatic Minized You Can Open By Click The Ui On The Bottom",
        Duration = 5
    })
end)
ThemeSection:Keybind({
    Title = "Keybind",
    Desc = "Keybind to open ui",
    Value = "G",
    Callback = function(v)
        Window:SetToggleKey(Enum.KeyCode[v])
    end
})

local ConsoleSec = SettingTab:Section({ Title = "Console Manager", Icon = "code", Opened = true, Box = true })

local VIM = game:GetService("VirtualInputManager")
ConsoleSec:Button({ Title = "Open Roblox Console (F9)", Icon = "square-terminal", Callback = function() pcall(function() VIM:SendKeyEvent(true, Enum.KeyCode.F9, false, game); task.wait(0.05); VIM:SendKeyEvent(false, Enum.KeyCode.F9, false, game) end) end })
local LogService = game:GetService("LogService"); local TweenService = game:GetService("TweenService"); local CoreGui = (gethui and gethui()) or game:GetService("CoreGui")
local TWEEN_INFO = TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local NORMAL_SIZE = UDim2.new(0, 500, 0, 320); local MINIMIZED_SIZE = UDim2.new(0, 500, 0, 30); local MAXIMIZED_SIZE = UDim2.new(0.9, 0, 0.9, 0)
local isMaximized, isMinimized = false, false
local isConsoleOpen = false 
local savedPos = UDim2.new(0.5, -250, 0.5, -160)
local customConsoleGui = Instance.new("ScreenGui"); customConsoleGui.Name = "Purium_PremiumConsole"; customConsoleGui.ResetOnSpawn = false; pcall(function() customConsoleGui.Parent = CoreGui end)
local consoleFrame = Instance.new("Frame", customConsoleGui); consoleFrame.Size = UDim2.new(0, 0, 0, 0); consoleFrame.Position = UDim2.new(0.5, 0, 0.5, 0); consoleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25); consoleFrame.BorderSizePixel = 0; consoleFrame.Visible = false; consoleFrame.ClipsDescendants = true; consoleFrame.Active = true; consoleFrame.Draggable = true
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 10)
local topBar = Instance.new("Frame", consoleFrame); topBar.Size = UDim2.new(1, 0, 0, 30); topBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35); topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)
local fixSquare = Instance.new("Frame", topBar); fixSquare.Size = UDim2.new(1, 0, 0, 10); fixSquare.Position = UDim2.new(0, 0, 1, -10); fixSquare.BackgroundColor3 = Color3.fromRGB(35, 35, 35); fixSquare.BorderSizePixel = 0
local title = Instance.new("TextLabel", topBar); title.Size = UDim2.new(1, -100, 1, 0); title.Position = UDim2.new(0, 80, 0, 0); title.BackgroundTransparency = 1; title.Text = "Purium Custome Console"; title.TextColor3 = Color3.fromRGB(200, 200, 200); title.Font = Enum.Font.GothamBold; title.TextSize = 13; title.TextXAlignment = Enum.TextXAlignment.Left
local btnContainer = Instance.new("Frame", topBar); btnContainer.Size = UDim2.new(0, 60, 1, 0); btnContainer.Position = UDim2.new(0, 10, 0, 0); btnContainer.BackgroundTransparency = 1
local listLayoutBtns = Instance.new("UIListLayout", btnContainer); listLayoutBtns.FillDirection = Enum.FillDirection.Horizontal; listLayoutBtns.VerticalAlignment = Enum.VerticalAlignment.Center; listLayoutBtns.Padding = UDim.new(0, 8)
local btnClose = Instance.new("TextButton", btnContainer); btnClose.Size = UDim2.new(0, 12, 0, 12); btnClose.BackgroundColor3 = Color3.fromRGB(255, 95, 86); btnClose.Text = ""; Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1, 0)
local btnMinimize = Instance.new("TextButton", btnContainer); btnMinimize.Size = UDim2.new(0, 12, 0, 12); btnMinimize.BackgroundColor3 = Color3.fromRGB(255, 189, 46); btnMinimize.Text = ""; Instance.new("UICorner", btnMinimize).CornerRadius = UDim.new(1, 0)
local btnMaximize = Instance.new("TextButton", btnContainer); btnMaximize.Size = UDim2.new(0, 12, 0, 12); btnMaximize.BackgroundColor3 = Color3.fromRGB(39, 201, 63); btnMaximize.Text = ""; Instance.new("UICorner", btnMaximize).CornerRadius = UDim.new(1, 0)
local scrollFrame = Instance.new("ScrollingFrame", consoleFrame); scrollFrame.Size = UDim2.new(1, -10, 1, -40); scrollFrame.Position = UDim2.new(0, 5, 0, 35); scrollFrame.BackgroundTransparency = 1; scrollFrame.ScrollBarThickness = 3; scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80); scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0); scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
local listLayout = Instance.new("UIListLayout", scrollFrame); listLayout.SortOrder = Enum.SortOrder.LayoutOrder; listLayout.Padding = UDim.new(0, 3)
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
    
    local closeTween = TweenService:Create(consoleFrame, TWEEN_INFO, { 
        Size = UDim2.new(0, 0, 0, 0), 
        Position = UDim2.new(
            consoleFrame.Position.X.Scale, 
            consoleFrame.Position.X.Offset + (consoleFrame.AbsoluteSize.X/2), 
            consoleFrame.Position.Y.Scale, 
            consoleFrame.Position.Y.Offset + (consoleFrame.AbsoluteSize.Y/2)
        ) 
    })
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
local function addLog(message, msgType)
    logCount = logCount + 1; if logCount > 150 then local oldestLog = scrollFrame:FindFirstChildWhichIsA("TextLabel"); if oldestLog then oldestLog:Destroy() logCount = logCount - 1 end end
    local logLbl = Instance.new("TextLabel", scrollFrame); logLbl.Size = UDim2.new(1, 0, 0, 18); logLbl.BackgroundTransparency = 1; logLbl.Font = Enum.Font.Code; logLbl.TextSize = 13; logLbl.TextXAlignment = Enum.TextXAlignment.Left; logLbl.TextWrapped = true; logLbl.AutomaticSize = Enum.AutomaticSize.Y
    if msgType == Enum.MessageType.MessageInfo then logLbl.TextColor3 = Color3.fromRGB(0, 200, 255); logLbl.Text = " [INFO] " .. tostring(message)
    elseif msgType == Enum.MessageType.MessageWarning then logLbl.TextColor3 = Color3.fromRGB(255, 200, 0); logLbl.Text = " [WARN] " .. tostring(message)
    elseif msgType == Enum.MessageType.MessageError then logLbl.TextColor3 = Color3.fromRGB(255, 80, 80); logLbl.Text = " [ERROR] " .. tostring(message)
    else logLbl.TextColor3 = Color3.fromRGB(220, 220, 220); logLbl.Text = " [LOG] " .. tostring(message) end
    scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteWindowSize.Y + 9999)
end
LogService.MessageOut:Connect(addLog)

ConsoleSec:Button({ Title = "Open Custome Console", Icon = "terminal", Callback = function() openConsole() end })
ConsoleSec:Button({
 Title = "Test Console",
 Icon = "flask-conical", 
 Callback = function() 
 print("This is a LOG.");
 warn("This is a WARNING."); 
 error("This is an ERROR."); 
 pcall(function() game:GetService("TestService"):Message("This is an INFO.") end) end })
 ConsoleSec:Button({ Title = "Clear Console Data", Icon = "trash", Callback = function() for _, child in ipairs(scrollFrame:GetChildren()) do if child:IsA("TextLabel") then child:Destroy() end end logCount = 0; WindUI:Notify({Title = "Console", Content = "Clear All Custome Console!!"}) end })
print("successfully loaded all asset!")
---------------------------------------------
-- Part 1 : Main
---------------------------------------------
print("Loading script maybe take a few seconds to complete")
game:GetService("StarterGui"):SetCore("SendNotification", { Title = "Purium On Top!", Text = "Loading Script...", Duration = 3 })
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | SBSD |", Icon = "door-open", Author = "Version : 0.0.3", Folder = "Purium_SBSD",
    Size = UDim2.fromOffset(580, 460), MinSize = Vector2.new(560, 350), MaxSize = Vector2.new(850, 560),
    Transparent = true, Theme = "Dark", Resizable = true, SideBarWidth = 200, BackgroundImageTransparency = 0.42,
    HideSearchBar = true, ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium") end }
})

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
    Name = "Night",
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

Window:Tag({ Title = "v1.6.6", Icon = "github", Color = Color3.fromRGB(48, 255, 106), Radius = 10 })

local autoLoadPath = "Purium_SBSD/AutoLoad.txt"
local function getAutoLoad()
    local success, result = pcall(function() if isfile(autoLoadPath) then return readfile(autoLoadPath) end end)
    return (success and result) and result or "none"
end
local function setAutoLoad(name)
    pcall(function() if not isfolder("Purium_SBSD") then makefolder("Purium_SBSD") end writefile(autoLoadPath, name) end)
end
local InfoTab = Window:Tab({ Title = "Information", Icon = "info" })
local MainTab = Window:Tab({ Title = "Main", Icon = "leaf" })
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })
local _call19 = game:GetService('RunService')
local _call21 = game:GetService('VirtualInputManager')
local _LocalPlayer22 = game:GetService('Players').LocalPlayer
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")
local _farmSpeed = 10 
local _FarmStep = 1
local _HasWaited = false
local function UniversalClick(guiButton)
    pcall(function()
        GuiService.SelectedObject = guiButton
        _call21:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
        task.wait(0.05)
        _call21:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
        GuiService.SelectedObject = nil
    end)
    pcall(function()
        local vu = game:GetService("VirtualUser")
        vu:ClickButton1(Vector2.new(guiButton.AbsolutePosition.X + guiButton.AbsoluteSize.X / 2, guiButton.AbsolutePosition.Y + guiButton.AbsoluteSize.Y / 2))
    end)
    pcall(function()
        if getconnections then
            for _, conn in pairs(getconnections(guiButton.MouseButton1Click)) do conn:Fire() end
            for _, conn in pairs(getconnections(guiButton.Activated)) do conn:Fire() end
        end
    end)
end
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
    Desc = "[+] Improved Auto Farm\n[+] Added Auto Rejoin Game\n[+] Fixed Stats UI\n[+] Fixed Not Auto teleport choose map, mode\n[+] Change UI For More Stable To Use!",
})
local AutoFarmSection = MainTab:Section({ Title = "Auto Farm Mode", Icon = "swords", Opened = true, Box = true })
AutoFarmSection:Toggle({
    Title = "Start Autofarm",
    Desc = "Enable To Start Farm",
    Flag = "AutoFarmToggle",
    Value = false,
    Callback = function(_Value)
        _G.AutoFarmActive = _Value
        if _Value then
            _FarmStep = 1
            _HasWaited = false
            _G.IsNoclipping = false
            task.spawn(function()
                local _call29 = workspace:FindFirstChild('SafePlatform') or Instance.new('Part')
                if not _call29.Parent then
                    _call29.Size = Vector3.new(50, 5, 50); _call29.Anchored = true
                    _call29.Position = Vector3.new(36.8919563, 400, -4.66330338)
                    _call29.Transparency = 1; _call29.Name = 'SafePlatform'; _call29.Parent = workspace
                end
                _G.ClearLoop = _call19.Stepped:Connect(function()
                    if workspace:FindFirstChild('Fprojs') then workspace.Fprojs:ClearAllChildren() end
                    if _G.AutoFarmActive and _G.IsNoclipping then
                        local char = _LocalPlayer22.Character
                        if char then
                            for _, part in pairs(char:GetDescendants()) do
                                if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                            end
                        end
                    end
                end)
                while _G.AutoFarmActive do
                    pcall(function()
                        local char = _LocalPlayer22.Character
                        if not char or not char:FindFirstChild('HumanoidRootPart') or (char:FindFirstChild('Humanoid') and char.Humanoid.Health <= 0) then task.wait(1); return end
                        local hrp = char.HumanoidRootPart

                        if game.PlaceId == 14852797539 then
                            _G.IsNoclipping = false 
                            hrp.CFrame = CFrame.new(-82, 20, 157)
                            task.wait(1)
                            local closestElevator = nil; local shortestDist = 50
                            for _, obj in pairs(workspace:GetDescendants()) do
                                if obj:IsA("BasePart") then
                                    local dist = (obj.Position - hrp.Position).Magnitude
                                    if dist < shortestDist and dist > 1 then
                                        if obj:FindFirstChildOfClass("TouchTransmitter") or obj:FindFirstChildOfClass("ProximityPrompt") or string.find(string.lower(obj.Name), "door") or string.find(string.lower(obj.Name), "elevator") or string.find(string.lower(obj.Name), "tp") then
                                            shortestDist = dist; closestElevator = obj
                                        end
                                    end
                                end
                            end
                            if closestElevator then
                                hrp.CFrame = closestElevator.CFrame; task.wait(0.5)
                                local prompt = closestElevator:FindFirstChildOfClass("ProximityPrompt")
                                if prompt then fireproximityprompt(prompt) end
                            end
                            task.wait(2) 
                        else
                            local playerGui = _LocalPlayer22:FindFirstChild('PlayerGui')
                            local charClass = playerGui and playerGui:FindFirstChild('CharClass')
                            local hasUI = charClass and charClass:FindFirstChild('Scroll') and charClass.Scroll.Visible == true

                            if hrp.Position.Y > 200 and hrp.Position.Y < 350 and _FarmStep >= 3 then
                                _FarmStep = 1; _HasWaited = false; _G.IsNoclipping = false; task.wait(1)
                            end
                            if _FarmStep < 4 then _G.IsNoclipping = false end

                            if _FarmStep == 1 then
                                if hasUI then _FarmStep = 2 else
                                    local sandBtn = workspace:FindFirstChild('lobby') and workspace.lobby:FindFirstChild('btns') and workspace.lobby.btns:FindFirstChild('Sand')
                                    if sandBtn then
                                        hrp.CFrame = CFrame.new(1.6481026411057, 238.91009521484, 17.765621185303); task.wait(0.3)
                                        local prompt = sandBtn:FindFirstChild('ProximityPrompt')
                                        if prompt then
                                            prompt.HoldDuration = 0; fireproximityprompt(prompt)
                                            _call21:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.2); _call21:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        end
                                    end
                                end
                            elseif _FarmStep == 2 then
                                if hasUI then
                                    local scroll = charClass.Scroll
                                    local saw = scroll:FindFirstChild('Frame') and scroll.Frame:FindFirstChild('Saw')
                                    if saw then
                                        local pObj = saw.Parent
                                        while pObj and pObj:IsA("GuiObject") do
                                            pcall(function() pObj.ClipsDescendants = false end)
                                            pObj = pObj.Parent
                                        end
                                        pcall(function()
                                            saw.AnchorPoint = Vector2.new(0.5, 0.5)
                                            saw.Position = UDim2.new(0.5, 0, 0.5, 0)
                                            saw.Size = UDim2.new(100, 0, 100, 0)
                                            saw.ZIndex = 999999999
                                            saw.Active = true
                                        end)
                                        task.wait(0.2)
                                        UniversalClick(saw)
                                        pcall(function()
                                            local cam = workspace.CurrentCamera
                                            local mX, mY = cam.ViewportSize.X/2, cam.ViewportSize.Y/2
                                            _call21:SendMouseButtonEvent(mX, mY, 0, true, game, 1)
                                            task.wait(0.05)
                                            _call21:SendMouseButtonEvent(mX, mY, 0, false, game, 1)
                                        end)
                                        task.wait(1)
                                    end
                                else _FarmStep = 3 end
                            elseif _FarmStep == 3 then
                                local enemy = workspace:FindFirstChild('Enemies') and workspace.Enemies:FindFirstChild('Enhanced Supreme Boombox 2')
                                if enemy then _FarmStep = 4; _HasWaited = false else
                                    local mapBtn = workspace:FindFirstChild('Map') and workspace.Map:FindFirstChild('om_jangan_om')
                                    if mapBtn then
                                        hrp.CFrame = CFrame.new(366.5907, 14.6574, -294.5058); task.wait(0.5)
                                        local prompt = mapBtn:FindFirstChild('ProximityPrompt')
                                        if prompt then
                                            prompt.HoldDuration = 0; fireproximityprompt(prompt)
                                            _call21:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.2); _call21:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                        end
                                        task.wait(2)
                                    end
                                end
                            elseif _FarmStep == 4 then
                                local enemy = workspace:FindFirstChild('Enemies') and workspace.Enemies:FindFirstChild('Enhanced Supreme Boombox 2')
                                if enemy and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                                    if not _HasWaited then
                                        _G.IsNoclipping = false 
                                        if _call29 then hrp.CFrame = _call29.CFrame * CFrame.new(0, 3, 0) end
                                        task.wait(_farmSpeed); _HasWaited = true 
                                    end
                                    if _HasWaited then
                                        _G.IsNoclipping = true 
                                        hrp.CFrame = enemy.HumanoidRootPart.CFrame
                                        task.spawn(function()
                                            _call21:SendKeyEvent(true, Enum.KeyCode.F, false, game); task.wait(0.05); _call21:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                        end)
                                    end
                                else
                                    _HasWaited = false; _G.IsNoclipping = false
                                    if _call29 then hrp.CFrame = _call29.CFrame * CFrame.new(0, 3, 0) end
                                end
                            end
                        end
                    end)
                    task.wait(0.05) 
                end
                if _call29 then _call29:Destroy() end
            end)
        else
            _G.IsNoclipping = false
            if _G.ClearLoop then _G.ClearLoop:Disconnect() end
        end
    end
})
AutoFarmSection:Toggle({
    Title = "Show Stats",
    Desc = "Show Points earned & current",
    Flag = "ShowStatsToggle",
    Value = false,
    Callback = function(Value)
        if Value then
            local _call150 = Instance.new('ScreenGui', game:GetService("CoreGui"))
            _call150.Name = 'StatsGUI'
            local _call152 = Instance.new('Frame', _call150)
            _call152.Name = 'Quorum'
            _call152.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            _call152.BorderColor3 = Color3.fromRGB(255, 255, 255)
            _call152.BorderSizePixel = 0
            _call152.Position = UDim2.new(0.7, 0, 0.22, 0)
            _call152.Size = UDim2.new(0.29, 0, 0.46, 0)
            local _call154 = Instance.new('UICorner', _call152)
            _call154.CornerRadius = UDim.new(0, 20)
            local _call156 = Instance.new('TextLabel', _call152)
            _call156.Name = 'Points'
            _call156.Size = UDim2.new(0.47, 0, 0.15, 0); _call156.Position = UDim2.new(0, 0, 0.04, 0)
            _call156.BackgroundTransparency = 1; _call156.TextColor3 = Color3.fromRGB(255, 255, 255)
            _call156.Font = Enum.Font.PermanentMarker; _call156.TextScaled = true; _call156.Text = 'POINTS:'
            local _call158 = Instance.new('TextLabel', _call152)
            _call158.Name = 'Counter'
            _call158.Size = UDim2.new(0.45, 0, 0.15, 0); _call158.Position = UDim2.new(0.5, 0, 0.04, 0)
            _call158.BackgroundTransparency = 1; _call158.TextColor3 = Color3.fromRGB(255, 255, 255)
            _call158.Font = Enum.Font.PermanentMarker; _call158.TextScaled = true; _call158.Text = '0'
            local _call160 = Instance.new('TextLabel', _call152)
            _call160.Name = 'PointsEarned'
            _call160.Size = UDim2.new(0.47, 0, 0.15, 0); _call160.Position = UDim2.new(0, 0, 0.23, 0)
            _call160.BackgroundTransparency = 1; _call160.TextColor3 = Color3.fromRGB(255, 255, 255)
            _call160.Font = Enum.Font.PermanentMarker; _call160.TextScaled = true; _call160.Text = 'EARNED:'
            local _call162 = Instance.new('TextLabel', _call152)
            _call162.Name = 'CounterEarned'
            _call162.Size = UDim2.new(0.45, 0, 0.15, 0); _call162.Position = UDim2.new(0.5, 0, 0.23, 0)
            _call162.BackgroundTransparency = 1; _call162.TextColor3 = Color3.fromRGB(255, 255, 255)
            _call162.Font = Enum.Font.PermanentMarker; _call162.TextScaled = true; _call162.Text = '0'
            local _call164 = Instance.new('TextLabel', _call152)
            _call164.Name = 'TimeElapsed'
            _call164.Size = UDim2.new(0.77, 0, 0.3, 0); _call164.Position = UDim2.new(0.11, 0, 0.38, 0)
            _call164.BackgroundTransparency = 1; _call164.TextColor3 = Color3.fromRGB(255, 255, 255)
            _call164.Font = Enum.Font.PermanentMarker; _call164.TextScaled = true; _call164.Text = 'TIME ELAPSED:'
            local _call166 = Instance.new('TextLabel', _call152)
            _call166.Name = 'TimeCount'
            _call166.Size = UDim2.new(0.74, 0, 0.26, 0); _call166.Position = UDim2.new(0.11, 0, 0.59, 0)
            _call166.BackgroundTransparency = 1; _call166.TextColor3 = Color3.fromRGB(255, 255, 255)
            _call166.Font = Enum.Font.PermanentMarker; _call166.TextScaled = true; _call166.Text = '00:00:00'
            local _points = _LocalPlayer22:WaitForChild('leaderstats'):WaitForChild('Points')
            local _startPoints = _points.Value
            local _startTime = os.time()
            _G.StatsLoop = _call19.RenderStepped:Connect(function()
                if _points then
                    local currentPoints = _points.Value
                    _call158.Text = tostring(currentPoints)
                    _call162.Text = tostring(currentPoints - _startPoints)
                    local elapsed = os.time() - _startTime
                    local hours = math.floor(elapsed / 3600)
                    local minutes = math.floor((elapsed % 3600) / 60)
                    local seconds = elapsed % 60
                    _call166.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
                end
            end)
        else
            if game:GetService("CoreGui"):FindFirstChild("StatsGUI") then game:GetService("CoreGui").StatsGUI:Destroy() end
            if _G.StatsLoop then _G.StatsLoop:Disconnect() end
        end
    end
})
AutoFarmSection:Slider({ Title = "Wait time before attack", Desc = "Less = Faster But Ban Risk", Step = 1, Value = { Min = 1, Max = 60, Default = 10 }, Flag = "FarmSpeedSlider", Callback = function(Value) _farmSpeed = Value end })
MainTab:Space() 
---------------------------------------------
-- Part 2 : Settings
---------------------------------------------
local SupportSection = MainTab:Section({ Title = "Others", Icon = "wrench", Opened = true, Box = true })
SupportSection:Toggle({ Title = "Auto Rejoin (Anti-Disconnect)", Desc = "Automatically reconnect when disconnected or kicked", Flag = "AutoRejoinToggle", Value = false, Callback = function(Value) if Value then _G.RejoinConnection = GuiService.ErrorMessageChanged:Connect(function() task.wait(0.5) if #game:GetService("Players"):GetPlayers() <= 1 then TeleportService:Teleport(game.PlaceId, _LocalPlayer22) else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _LocalPlayer22) end end) else if _G.RejoinConnection then _G.RejoinConnection:Disconnect(); _G.RejoinConnection = nil end end end })
SupportSection:Button({ Title = "Rejoin Server (Manual)", Desc = "Use when stuck in terrain", Callback = function() if #game:GetService("Players"):GetPlayers() <= 1 then TeleportService:Teleport(game.PlaceId, _LocalPlayer22) else TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _LocalPlayer22) end end })
SupportSection:Button({ Title = "Infinite Yield", Desc = "Run Infinite Yield", Callback = function() loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))() end })
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
SettingTab:Space()

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

-- KHUNG CHÍNH (Background)
local consoleFrame = Instance.new("Frame", customConsoleGui); consoleFrame.Size = UDim2.new(0, 0, 0, 0); consoleFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
consoleFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) 
consoleFrame.BorderSizePixel = 0; consoleFrame.Visible = false; consoleFrame.ClipsDescendants = true; consoleFrame.Active = true; consoleFrame.Draggable = true
Instance.new("UICorner", consoleFrame).CornerRadius = UDim.new(0, 10)

-- TOPBAR (Tràn viền)
local topBar = Instance.new("Frame", consoleFrame); topBar.Size = UDim2.new(1, 0, 0, 30); topBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25); topBar.BorderSizePixel = 0
Instance.new("UICorner", topBar).CornerRadius = UDim.new(0, 10)
local fixSquare = Instance.new("Frame", topBar); fixSquare.Size = UDim2.new(1, 0, 0, 10); fixSquare.Position = UDim2.new(0, 0, 1, -10); fixSquare.BackgroundColor3 = Color3.fromRGB(25, 25, 25); fixSquare.BorderSizePixel = 0

-- TIÊU ĐỀ
local title = Instance.new("TextLabel", topBar); title.Size = UDim2.new(1, -100, 1, 0); title.Position = UDim2.new(0, 15, 0, 0); title.BackgroundTransparency = 1; title.Text = "Purium Premium Console"; title.TextColor3 = Color3.fromRGB(200, 200, 200); title.Font = Enum.Font.GothamBold; title.TextSize = 13; title.TextXAlignment = Enum.TextXAlignment.Left

-- VÙNG 3 NÚT MACOS BÊN PHẢI
local btnContainer = Instance.new("Frame", topBar); btnContainer.Size = UDim2.new(0, 60, 1, 0); btnContainer.AnchorPoint = Vector2.new(1, 0); btnContainer.Position = UDim2.new(1, -10, 0, 0); btnContainer.BackgroundTransparency = 1
local listLayoutBtns = Instance.new("UIListLayout", btnContainer); listLayoutBtns.FillDirection = Enum.FillDirection.Horizontal; listLayoutBtns.VerticalAlignment = Enum.VerticalAlignment.Center; listLayoutBtns.Padding = UDim.new(0, 8)
local btnMinimize = Instance.new("TextButton", btnContainer); btnMinimize.Size = UDim2.new(0, 12, 0, 12); btnMinimize.BackgroundColor3 = Color3.fromRGB(255, 189, 46); btnMinimize.Text = ""; Instance.new("UICorner", btnMinimize).CornerRadius = UDim.new(1, 0)
local btnMaximize = Instance.new("TextButton", btnContainer); btnMaximize.Size = UDim2.new(0, 12, 0, 12); btnMaximize.BackgroundColor3 = Color3.fromRGB(39, 201, 63); btnMaximize.Text = ""; Instance.new("UICorner", btnMaximize).CornerRadius = UDim.new(1, 0)
local btnClose = Instance.new("TextButton", btnContainer); btnClose.Size = UDim2.new(0, 12, 0, 12); btnClose.BackgroundColor3 = Color3.fromRGB(255, 95, 86); btnClose.Text = ""; Instance.new("UICorner", btnClose).CornerRadius = UDim.new(1, 0)

-- VÙNG LOGS
local scrollFrame = Instance.new("ScrollingFrame", consoleFrame); scrollFrame.Size = UDim2.new(1, -10, 1, -40); scrollFrame.Position = UDim2.new(0, 5, 0, 35); scrollFrame.BackgroundTransparency = 1; scrollFrame.ScrollBarThickness = 3; scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80); scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0); scrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
local listLayout = Instance.new("UIListLayout", scrollFrame); listLayout.SortOrder = Enum.SortOrder.LayoutOrder; listLayout.Padding = UDim.new(0, 3)

-- HÀM ANIMATION
local function openConsole() if isConsoleOpen then return end isConsoleOpen = true; consoleFrame.Visible = true; local targetSize = NORMAL_SIZE; local targetPos = savedPos; if isMaximized then targetSize = MAXIMIZED_SIZE; targetPos = UDim2.new(0.05, 0, 0.05, 0) elseif isMinimized then targetSize = MINIMIZED_SIZE end TweenService:Create(consoleFrame, TWEEN_INFO, {Size = targetSize, Position = targetPos}):Play() end
local function hideConsole() if not isConsoleOpen then return end isConsoleOpen = false; if not isMaximized and not isMinimized then savedPos = consoleFrame.Position end local closeTween = TweenService:Create(consoleFrame, TWEEN_INFO, { Size = UDim2.new(0, 0, 0, 0), Position = UDim2.new(consoleFrame.Position.X.Scale, consoleFrame.Position.X.Offset + (consoleFrame.AbsoluteSize.X/2), consoleFrame.Position.Y.Scale, consoleFrame.Position.Y.Offset + (consoleFrame.AbsoluteSize.Y/2)) }); closeTween:Play(); task.delay(0.3, function() if not isConsoleOpen then consoleFrame.Visible = false end end) end

btnClose.MouseButton1Click:Connect(hideConsole)
btnMinimize.MouseButton1Click:Connect(function() if not isConsoleOpen then return end isMinimized = not isMinimized if isMinimized then if not isMaximized then savedPos = consoleFrame.Position end TweenService:Create(consoleFrame, TWEEN_INFO, {Size = MINIMIZED_SIZE}):Play(); scrollFrame.Visible = false else scrollFrame.Visible = true; local targetSize = isMaximized and MAXIMIZED_SIZE or NORMAL_SIZE; TweenService:Create(consoleFrame, TWEEN_INFO, {Size = targetSize}):Play() end end)
btnMaximize.MouseButton1Click:Connect(function() if not isConsoleOpen or isMinimized then return end isMaximized = not isMaximized if isMaximized then savedPos = consoleFrame.Position; TweenService:Create(consoleFrame, TWEEN_INFO, { Size = MAXIMIZED_SIZE, Position = UDim2.new(0.05, 0, 0.05, 0) }):Play() else TweenService:Create(consoleFrame, TWEEN_INFO, { Size = NORMAL_SIZE, Position = savedPos }):Play() end end)

-- HÀM XỬ LÝ LOGS VÀ LỌC MÀU
local logCount = 0
local function addLog(message, msgType)
    logCount = logCount + 1; if logCount > 150 then local oldestLog = scrollFrame:FindFirstChildWhichIsA("TextLabel"); if oldestLog then oldestLog:Destroy() logCount = logCount - 1 end end
    local logLbl = Instance.new("TextLabel", scrollFrame); logLbl.Size = UDim2.new(1, 0, 0, 18); logLbl.BackgroundTransparency = 1; logLbl.Font = Enum.Font.Code; logLbl.TextSize = 13; logLbl.TextXAlignment = Enum.TextXAlignment.Left; logLbl.TextWrapped = true; logLbl.AutomaticSize = Enum.AutomaticSize.Y
    
    if msgType == Enum.MessageType.MessageInfo then 
        logLbl.TextColor3 = Color3.fromRGB(0, 200, 255); logLbl.Text = " [INFO] " .. tostring(message)
    elseif msgType == Enum.MessageType.MessageWarning then 
        logLbl.TextColor3 = Color3.fromRGB(255, 200, 0); logLbl.Text = " [WARN] " .. tostring(message)
    elseif msgType == Enum.MessageType.MessageError then 
        logLbl.TextColor3 = Color3.fromRGB(255, 80, 80); logLbl.Text = " [ERROR] " .. tostring(message)
    else 
        logLbl.TextColor3 = Color3.fromRGB(220, 220, 220); logLbl.Text = " [LOG] " .. tostring(message) 
    end
    
    -- Delay siêu nhỏ để UI kịp cập nhật kích thước Text trước khi cuộn
    task.defer(function()
        scrollFrame.CanvasPosition = Vector2.new(0, scrollFrame.AbsoluteWindowSize.Y + 9999)
    end)
end

-- KẾT NỐI SỰ KIỆN: BẮT 100% CÁC LOG VÀ LỖI
LogService.MessageOut:Connect(addLog)
game:GetService("ScriptContext").Error:Connect(function(message, trace, script)
    -- Hàm này đảm bảo bắt gọn mọi lỗi từ Executor và Roblox
    addLog(tostring(message) .. " | " .. tostring(script), Enum.MessageType.MessageError)
end)
ConsoleSec:Button({ Title = "Open Custome Console", Icon = "terminal", Callback = function() openConsole() end })
ConsoleSec:Button({ 
    Title = "Test All Logs Colors", 
    Icon = "flask-conical", 
    Callback = function() 
        print("This is a normal LOG message.")
        warn("This is a WARNING message.")
        
        -- Gọi Info trước
        pcall(function() game:GetService("TestService"):Message("This is an INFO message.") end)
        
        -- Đưa Error vào luồng riêng để không làm ngắt script hiện tại
        task.spawn(function()
            error("This is an ERROR message.")
        end)
    end 
})
 ConsoleSec:Button({ 
     Title = "Clear Console Data", 
      Icon = "trash", 
      Callback = function() for _, child in ipairs(scrollFrame:GetChildren()) do if child:IsA("TextLabel") then child:Destroy() end end logCount = 0; WindUI:Notify({Title = "Console", Content = "Clear All Custome Console!!"}) end })
print("successfully loaded all asset!")
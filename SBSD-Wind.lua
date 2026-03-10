---------------------------------------------
-- Part 1 : Auto Farm & Diệt Lỗi Console
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
task.spawn(function()
    task.wait(1)
    pcall(function()
        Window:Dialog({
            Title = "Welcome To Purium Script!!",
            Content = "Thanks you guys for using my script!",
            Buttons = {
                { Title = "I Don't Care", Callback = function() end },
                { Title = "Yayyyy!!", Callback = function() end, Variant = "Primary" }
            }
        })
    end)
end)
Window:EditOpenButton({
    Title = "Open Ui",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- ĐÃ ĐỔI SANG GRADIENT TRẮNG ĐEN
        Color3.fromHex("1e1e1e"), 
        Color3.fromHex("000000")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
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
local MainTab = Window:Tab({ Title = "Main", Icon = "Swords" })
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

print("successfully loaded all asset!")




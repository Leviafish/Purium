game:GetService("StarterGui"):SetCore(
        "SendNotification",
        {
          Title = "Purium On Top!",
          Text = "Join Discord For More Information!",
          Duration = 2
        }
      )

local Fluent, SaveManager, InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/discoart/FluentPlus/refs/heads/main/release.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Purium Hub [Premium] | SBSD |",
    SubTitle = "Version 0.0.3",
    Search = true,
    Icon = "rbxassetid://121302760641013",
    TabWidth = 145,
    Size = UDim2.fromOffset(460, 340),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightAlt,

    UserInfo = true,
    UserInfoTop = false,
    UserInfoTitle = game:GetService("Players").LocalPlayer.DisplayName,
    UserInfoSubtitle = "I Love SBSD",
    UserInfoSubtitleColor = Color3.fromRGB(71, 123, 255)
})

local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local ExistingUI = CoreGui:FindFirstChild("PuriumHubMinimizeUI")
if ExistingUI then
    ExistingUI:Destroy()
end

local DragUI = Instance.new("ScreenGui")
DragUI.Name = "PuriumHubMinimizeUI"
DragUI.ResetOnSpawn = false
DragUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
DragUI.Parent = CoreGui


local Button = Instance.new("ImageButton")
Button.Parent = DragUI
Button.Size = UDim2.new(0, 50, 0, 50)
Button.Position = UDim2.new(0, 10, 1, -85)
Button.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Button.BackgroundTransparency = 0.3
Button.BorderSizePixel = 0
Button.ClipsDescendants = true
Button.Image = "rbxassetid://109647470925993" -- Thay icon nếu muốn
Button.ScaleType = Enum.ScaleType.Fit
Button.Active = true
Button.ZIndex = 1000


local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(1, 0)
UICorner.Parent = Button


local tweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local function ToggleUI()
    if Window.Minimized then
        Window:Minimize(false) 
    else
        Window:Minimize(true) 
    end
end

local isDragging = false
local dragThreshold = 10

Button.MouseButton1Click:Connect(function()
    if isDragging then return end

    TweenService:Create(Button, tweenInfo, {
        BackgroundTransparency = 0.5,
        Size = UDim2.new(0, 45, 0, 45),
        Rotation = 5
    }):Play()
    task.wait(0.1)
    TweenService:Create(Button, tweenInfo, {
        BackgroundTransparency = 0.3,
        Size = UDim2.new(0, 50, 0, 50),
        Rotation = 0
    }):Play()

    ToggleUI()
end)

Button.MouseEnter:Connect(function()
    TweenService:Create(Button, tweenInfo, {Size = UDim2.new(0, 55, 0, 55)}):Play()
end)

Button.MouseLeave:Connect(function()
    TweenService:Create(Button, tweenInfo, {Size = UDim2.new(0, 50, 0, 50)}):Play()
end)


local dragging, dragStart, startPos

local function StartDrag(input)
    isDragging = false
    dragging = true
    dragStart = input.Position
    startPos = Button.Position

    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then
            dragging = false
        end
    end)
end

local function OnDrag(input)
    if dragging then
        local delta = (input.Position - dragStart).Magnitude
        if delta > dragThreshold then
            isDragging = true
        end
        Button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + (input.Position.X - dragStart.X),
            startPos.Y.Scale,
            startPos.Y.Offset + (input.Position.Y - dragStart.Y)
        )
    end
end

Button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        StartDrag(input)
    end
end)

Button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        OnDrag(input)
    end
end)
  
local Tabs = {
    Main0=Window:AddTab({ Title="Infomation", Icon = "info" }),
    Main1=Window:AddTab({ Title="Main", Icon = "swords" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local _call19 = game:GetService('RunService')
local _call21 = game:GetService('VirtualInputManager')
local _LocalPlayer22 = game:GetService('Players').LocalPlayer
local TeleportService = game:GetService("TeleportService")
local GuiService = game:GetService("GuiService")

local _farmSpeed = 10 
_G.AutoFarmActive = false
local _FarmStep = 1
local _HasWaited = false

Tabs.Main0:AddParagraph({
    Title = "✨Welcome To Purium Hub✨",
    Content = "☄️Note : Thank You For Using My Script :D !!❤️",
})

    Tabs.Main0:AddParagraph({
        Title = "Support :",
        Content = "Support all Mobile executors.\nSupport all Pc executors."
    })

Tabs.Main0:AddButton({
    Title = "🌌Discord🌌",
    Description = "☄️Join discord for more information & support!✨",
    Callback = function()
      setclipboard("https://discord.gg/3fbA4kNZtJ")
      warn("Link Discord copied to clipboard: " .. "https://discord.gg/3fbA4kNZtJ") 
            game:GetService("StarterGui"):SetCore(
        "SendNotification",
        {
          Title = "Link Discord Copied!",
          Text = "Link Copied.",
          Duration = 2
        }
      )
    end
})

Tabs.Main0:AddParagraph({
        Title = "Changlog Update :",
        Content = "[+] Improved Auto Farm\n[+] Added Auto Rejoin Game\n[+] Fixed Stats UI\n[+] Fixed Not Auto teleport choose map, mode\n[+] Like Change The Other ui Link to get more Stable"
    })
    
Tabs.Main1:AddSection("↳ Auto Farm Point")

Tabs.Main1:AddToggle("StartFarm", { 
Title = "Start Autofarm", 
Default = false
 }):OnChanged(function(_Value)
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

            -- NỘI TẠI: Liên tục xóa đạn và Bật Noclip THEO ĐIỀU KIỆN
            _G.ClearLoop = _call19.Stepped:Connect(function()
                if workspace:FindFirstChild('Fprojs') then workspace.Fprojs:ClearAllChildren() end
                
                -- CHỈ KÍCH HOẠT NOCLIP KHI ĐANG LAO VÀO ĐÁNH QUÁI
                if _G.AutoFarmActive and _G.IsNoclipping then
                    local char = _LocalPlayer22.Character
                    if char then
                        for _, part in pairs(char:GetDescendants()) do
                            if part:IsA("BasePart") and part.CanCollide then
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)

            while _G.AutoFarmActive do
                pcall(function()
                    local _Character70 = _LocalPlayer22.Character
                    if not _Character70 or not _Character70:FindFirstChild('HumanoidRootPart') or (_Character70:FindFirstChild('Humanoid') and _Character70.Humanoid.Health <= 0) then
                        task.wait(1); return 
                    end
                    local _HumanoidRootPart73 = _Character70.HumanoidRootPart

                    if game.PlaceId == 14852797539 then
                        _G.IsNoclipping = false -- Tắt noclip khi ở sảnh
                        
                        -- LOBBY: TÌM VÀ VÀO THANG MÁY
                        _HumanoidRootPart73.CFrame = CFrame.new(-82, 20, 157)
                        task.wait(1)
                        local closestElevator = nil
                        local shortestDist = 50
                        
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if obj:IsA("BasePart") then
                                local dist = (obj.Position - _HumanoidRootPart73.Position).Magnitude
                                if dist < shortestDist and dist > 1 then
                                    if obj:FindFirstChildOfClass("TouchTransmitter") or obj:FindFirstChildOfClass("ProximityPrompt") or string.find(string.lower(obj.Name), "door") or string.find(string.lower(obj.Name), "elevator") or string.find(string.lower(obj.Name), "tp") then
                                        shortestDist = dist; closestElevator = obj
                                    end
                                end
                            end
                        end
                        
                        if closestElevator then
                            _HumanoidRootPart73.CFrame = closestElevator.CFrame
                            task.wait(0.5)
                            local prompt = closestElevator:FindFirstChildOfClass("ProximityPrompt")
                            if prompt then fireproximityprompt(prompt) end
                        end
                        task.wait(2) 
                    else
                        -- IN-GAME: CHẠY AUTO FARM
                        local _call90 = _LocalPlayer22:FindFirstChild('PlayerGui'):FindFirstChild('CharClass')
                        local _hasUI = _call90 and _call90:FindFirstChild('Scroll') and _call90.Scroll.Visible == true

                        if _HumanoidRootPart73.Position.Y > 200 and _HumanoidRootPart73.Position.Y < 350 and _FarmStep >= 3 then
                            _FarmStep = 1; _HasWaited = false; _G.IsNoclipping = false; task.wait(1)
                        end

                        -- Luôn tắt Noclip ở các bước chuẩn bị (1, 2, 3)
                        if _FarmStep < 4 then _G.IsNoclipping = false end

                        if _FarmStep == 1 then
                            if _hasUI then _FarmStep = 2 else
                                local _call67 = workspace:FindFirstChild('lobby'):FindFirstChild('btns'):FindFirstChild('Sand')
                                if _call67 then
                                    _HumanoidRootPart73.CFrame = CFrame.new(1.6481026411057, 238.91009521484, 17.765621185303)
                                    task.wait(0.3)
                                    local _call55 = _call67:FindFirstChild('ProximityPrompt')
                                    if _call55 then
                                        _call55.HoldDuration = 0; fireproximityprompt(_call55)
                                        _call21:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.2); _call21:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                    end
                                end
                            end
                        elseif _FarmStep == 2 then
                            if _hasUI then
                                local _Scroll = _call90.Scroll; local _call95 = _Scroll:FindFirstChild('Frame'):FindFirstChild('Saw')
                                if _call95 then
                                    _call95.Position = UDim2.new(0, 0, 0, 0); _call95.Size = UDim2.new(1, 0, 9999, 9999)
                                    _call95.ZIndex = 9999; _Scroll.Position = UDim2.new(0, 0, 0, 0); _Scroll.Size = UDim2.new(9999, 9999, 9999, 9999)
                                    task.wait(0.2); mousemoveabs(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2); task.wait(0.1); mouse1click(); task.wait(1)
                                end
                            else _FarmStep = 3 end
                        elseif _FarmStep == 3 then
                            local _enemy = workspace:FindFirstChild('Enemies') and workspace.Enemies:FindFirstChild('Enhanced Supreme Boombox 2')
                            if _enemy then _FarmStep = 4; _HasWaited = false else
                                local _call120 = workspace:FindFirstChild('Map'):FindFirstChild('om_jangan_om')
                                if _call120 then
                                    _HumanoidRootPart73.CFrame = CFrame.new(366.5907, 14.6574, -294.5058); task.wait(0.5)
                                    local _call61 = _call120:FindFirstChild('ProximityPrompt')
                                    if _call61 then
                                        _call61.HoldDuration = 0; fireproximityprompt(_call61)
                                        _call21:SendKeyEvent(true, Enum.KeyCode.E, false, game); task.wait(0.2); _call21:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                                    end
                                    task.wait(2)
                                end
                            end
                        elseif _FarmStep == 4 then
                            local _call141 = workspace:FindFirstChild('Enemies') and workspace.Enemies:FindFirstChild('Enhanced Supreme Boombox 2')
                            if _call141 and _call141:FindFirstChild("Humanoid") and _call141:FindFirstChild("HumanoidRootPart") and _call141.Humanoid.Health > 0 then
                                
                                if not _HasWaited then
                                    _G.IsNoclipping = false -- Đảm bảo tắt Noclip khi đứng chờ trên bệ
                                    if _call29 then _HumanoidRootPart73.CFrame = _call29.CFrame * CFrame.new(0, 3, 0) end
                                    task.wait(_farmSpeed); _HasWaited = true 
                                end
                                
                                if _HasWaited then
                                    _G.IsNoclipping = true -- BẬT NOCLIP CHUI THẲNG VÀO QUÁI
                                    _HumanoidRootPart73.CFrame = _call141.HumanoidRootPart.CFrame
                                    
                                    task.spawn(function()
                                        _call21:SendKeyEvent(true, Enum.KeyCode.F, false, game)
                                        task.wait(0.05)
                                        _call21:SendKeyEvent(false, Enum.KeyCode.F, false, game)
                                    end)
                                end
                            else
                                _HasWaited = false; _G.IsNoclipping = false -- Tắt Noclip ngay khi quái chết
                                if _call29 then _HumanoidRootPart73.CFrame = _call29.CFrame * CFrame.new(0, 3, 0) end
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
end)

Tabs.Main1:AddToggle("AutoRejoin", { 
    Title = "Auto Rejoin", 
    Description = "Automatic Rejoin when you get kick or disconnect",
    Default = false 
}):OnChanged(function(Value)
    if Value then
        _G.RejoinConnection = GuiService.ErrorMessageChanged:Connect(function()
            task.wait(0.5)
            if #game:GetService("Players"):GetPlayers() <= 1 then
                TeleportService:Teleport(game.PlaceId, _LocalPlayer22)
            else
                TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, _LocalPlayer22)
            end
        end)
    else
        if _G.RejoinConnection then
            _G.RejoinConnection:Disconnect()
            _G.RejoinConnection = nil
        end
    end
end)

-- ==========================================================
-- SHOW STATS VÀ SLIDER SPEED
-- ==========================================================
Tabs.Main1:AddToggle("ShowStats", { Title = "Show Stats", Default = false }):OnChanged(function(Value)
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

        -- [1] POINTS
        local _call156 = Instance.new('TextLabel', _call152)
        _call156.Name = 'Points'
        _call156.Size = UDim2.new(0.47, 0, 0.15, 0); _call156.Position = UDim2.new(0, 0, 0.04, 0)
        _call156.BackgroundTransparency = 1; _call156.TextColor3 = Color3.fromRGB(255, 255, 255)
        _call156.Font = Enum.Font.PermanentMarker; _call156.TextScaled = true
        _call156.Text = 'POINTS:'

        local _call158 = Instance.new('TextLabel', _call152)
        _call158.Name = 'Counter'
        _call158.Size = UDim2.new(0.45, 0, 0.15, 0); _call158.Position = UDim2.new(0.5, 0, 0.04, 0)
        _call158.BackgroundTransparency = 1; _call158.TextColor3 = Color3.fromRGB(255, 255, 255)
        _call158.Font = Enum.Font.PermanentMarker; _call158.TextScaled = true
        _call158.Text = '0'

        -- [2] EARNED
        local _call160 = Instance.new('TextLabel', _call152)
        _call160.Name = 'PointsEarned'
        _call160.Size = UDim2.new(0.47, 0, 0.15, 0); _call160.Position = UDim2.new(0, 0, 0.23, 0)
        _call160.BackgroundTransparency = 1; _call160.TextColor3 = Color3.fromRGB(255, 255, 255)
        _call160.Font = Enum.Font.PermanentMarker; _call160.TextScaled = true
        _call160.Text = 'EARNED:'

        local _call162 = Instance.new('TextLabel', _call152)
        _call162.Name = 'CounterEarned'
        _call162.Size = UDim2.new(0.45, 0, 0.15, 0); _call162.Position = UDim2.new(0.5, 0, 0.23, 0)
        _call162.BackgroundTransparency = 1; _call162.TextColor3 = Color3.fromRGB(255, 255, 255)
        _call162.Font = Enum.Font.PermanentMarker; _call162.TextScaled = true
        _call162.Text = '0'

        -- [3] TIME ELAPSED
        local _call164 = Instance.new('TextLabel', _call152)
        _call164.Name = 'TimeElapsed'
        _call164.Size = UDim2.new(0.77, 0, 0.3, 0); _call164.Position = UDim2.new(0.11, 0, 0.38, 0)
        _call164.BackgroundTransparency = 1; _call164.TextColor3 = Color3.fromRGB(255, 255, 255)
        _call164.Font = Enum.Font.PermanentMarker; _call164.TextScaled = true
        _call164.Text = 'TIME ELAPSED:'

        local _call166 = Instance.new('TextLabel', _call152)
        _call166.Name = 'TimeCount'
        _call166.Size = UDim2.new(0.74, 0, 0.26, 0); _call166.Position = UDim2.new(0.11, 0, 0.59, 0)
        _call166.BackgroundTransparency = 1; _call166.TextColor3 = Color3.fromRGB(255, 255, 255)
        _call166.Font = Enum.Font.PermanentMarker; _call166.TextScaled = true
        _call166.Text = '00:00:00'

        -- Lấy dữ liệu điểm số
        local _points = _LocalPlayer22:WaitForChild('leaderstats'):WaitForChild('Points')
        local _startPoints = _points.Value
        local _startTime = os.time()

        -- Vòng lặp cập nhật liên tục
        _G.StatsLoop = _call19.RenderStepped:Connect(function()
            local currentPoints = _points.Value
            
            -- Cập nhật điểm hiện tại
            _call158.Text = tostring(currentPoints)
            
            -- Cập nhật điểm kiếm được
            _call162.Text = tostring(currentPoints - _startPoints)
            
            -- Cập nhật đồng hồ thời gian
            local elapsed = os.time() - _startTime
            local hours = math.floor(elapsed / 3600)
            local minutes = math.floor((elapsed % 3600) / 60)
            local seconds = elapsed % 60
            _call166.Text = string.format("%02d:%02d:%02d", hours, minutes, seconds)
        end)
    else
        -- Xóa giao diện khi tắt Toggle
        if game:GetService("CoreGui"):FindFirstChild("StatsGUI") then 
            game:GetService("CoreGui").StatsGUI:Destroy() 
        end
        if _G.StatsLoop then 
            _G.StatsLoop:Disconnect() 
        end
    end
end)

Tabs.Main1:AddSlider("FarmSpeed", {
    Title = "Auto Farm Speed",
    Description = "Less = Faster But Ban Risk",
    Default = 10, Min = 1, Max = 60, Rounding = 1, Suffix = " sec",
    Callback = function(Value) _farmSpeed = Value end
})

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Purium")
SaveManager:SetFolder("Purium/SBSD")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
Window:SelectTab(1)
task.wait(1)
Fluent:Notify({ Title = "Purium Hub", Content = "SBSD script loaded successfully!", Duration = 5 })
SaveManager:LoadAutoloadConfig()
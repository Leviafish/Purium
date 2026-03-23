local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
local Window = WindUI:CreateWindow({
    Title = "Purium Hub [By @hlck49] | Auto Farm |", 
    Icon = "door-open", 
    Author = "Version : 4.0 Master", 
    Folder = "Purium_Farm",
    Size = UDim2.fromOffset(580, 460), 
    MinSize = Vector2.new(560, 350), 
    MaxSize = Vector2.new(850, 560),
    Transparent = true, 
    Theme = "Dark", 
    Resizable = true, 
    SideBarWidth = 200, 
    BackgroundImageTransparency = 0.42,
    HideSearchBar = true, 
    ScrollBarEnabled = false,
    User = { Enabled = true, Anonymous = true, Callback = function() print("Purium Farm Loaded") end }
})

Window:EditOpenButton({ Title = "Open Purium", Icon = "monitor", CornerRadius = UDim.new(0,16), Draggable = true })

WindUI:AddTheme({ Name = "Amethyst", Accent = Color3.fromHex("7E2CB6"), Dialog = Color3.fromHex("321E46"), Outline = Color3.fromHex("552D78"), Text = Color3.fromHex("F0F0F0"), Placeholder = Color3.fromHex("AAAAAA"), Background = Color3.fromHex("280C47"), Button = Color3.fromHex("733796"), Icon = Color3.fromHex("AAAAAA"), Toggle = Color3.fromHex("7E2CB6"), Slider = Color3.fromHex("7E2CB6"), Checkbox = Color3.fromHex("7E2CB6"), PanelBackground = Color3.fromHex("FFFFFF"), PanelBackgroundTransparency = 0.95, SliderIcon = Color3.fromHex("AAAAAA"), Primary = Color3.fromHex("7E2CB6"), LabelBackground = Color3.fromHex("000000"), LabelBackgroundTransparency = 0.85 })
Window:Tag({ Title = "Master Farm & Auto Config", Icon = "save", Color = Color3.fromRGB(0, 255, 150), Radius = 10 })

-- =========================================================================
-- KHỞI TẠO SERVICES & BIẾN
-- =========================================================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

_G.IsFarming = false
local farmLoop = nil

local function PressKey(keyCode)
    VirtualInputManager:SendKeyEvent(true, keyCode, false, game)
    task.wait(0.05)
    VirtualInputManager:SendKeyEvent(false, keyCode, false, game)
end

-- =========================================================================
-- HỆ THỐNG ANTI-AFK (15 PHÚT CLICK 1 LẦN)
-- =========================================================================
task.spawn(function()
    while true do
        task.wait(900) -- 900 giây = 15 phút
        pcall(function()
            local cam = Workspace.CurrentCamera
            if cam then
                local center = cam.ViewportSize / 2
                VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, true, game, 0)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(center.X, center.Y, 0, false, game, 0)
            end
        end)
    end
end)

-- =========================================================================
-- GIAO DIỆN QUẢN LÝ VŨ KHÍ (WEAPON MANAGER)
-- =========================================================================
local FarmTab = Window:Tab({ Title = "Auto Farm Setup", Icon = "tractor" })
local WeaponSec = FarmTab:Section({ Title = "Quản lý Vũ khí (Inventory)", Opened = true, Box = true })

_G.SelectedWeapon = "None"
_G.AutoEquip = false

local WeaponDropdown = WeaponSec:Dropdown({ 
    Title = "Choose Weapon", 
    Desc = "Vũ khí sẽ được lấy ra khỏi Balo",
    Flag = "WeaponDropdown_Flag", -- Flag để lưu Config
    Values = {"None"}, 
    Value = "None", 
    Callback = function(val) 
        _G.SelectedWeapon = val 
    end 
})

WeaponSec:Button({
    Title = "Refresh Inventory",
    Desc = "Cập nhật danh sách vũ khí trong hòm đồ",
    Icon = "refresh-ccw",
    Callback = function()
        local list = {}
        local char = LocalPlayer.Character
        local bp = LocalPlayer:FindFirstChild("Backpack")
        
        if char then
            for _, v in ipairs(char:GetChildren()) do
                if v:IsA("Tool") then table.insert(list, v.Name) end
            end
        end
        if bp then
            for _, v in ipairs(bp:GetChildren()) do
                if v:IsA("Tool") then table.insert(list, v.Name) end
            end
        end
        if #list == 0 then table.insert(list, "None") end
        
        WeaponDropdown:Refresh(list)
        WindUI:Notify({Title = "Inventory", Content = "Đã cập nhật danh sách vũ khí!", Duration = 2})
    end
})

WeaponSec:Toggle({ 
    Title = "Auto Equip Selected Weapon", 
    Desc = "Luôn luôn tự động cầm vũ khí đã chọn", 
    Flag = "AutoEquip_Flag", -- Flag để lưu Config
    Value = false, 
    Callback = function(v) 
        _G.AutoEquip = v 
    end
})

-- Động cơ Auto Equip vũ khí
task.spawn(function()
    while task.wait(0.5) do
        if _G.AutoEquip and _G.SelectedWeapon ~= "None" and _G.SelectedWeapon ~= "" then
            pcall(function()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")
                local bp = LocalPlayer:FindFirstChild("Backpack")
                
                if char and hum and bp then
                    local isEquipped = char:FindFirstChild(_G.SelectedWeapon)
                    if not isEquipped then
                        local tool = bp:FindFirstChild(_G.SelectedWeapon)
                        if tool and tool:IsA("Tool") then
                            hum:EquipTool(tool)
                        end
                    end
                end
            end)
        end
    end
end)

FarmTab:Divider()

-- =========================================================================
-- KHU VỰC TREO MÁY CAMERA (FARM ENVIRONMENT)
-- =========================================================================
local FarmSec = FarmTab:Section({ Title = "Khu Vực Treo Máy (Static Farm)", Opened = true, Box = true })

local CAM_PITCH_X = -24.0
local CAM_YAW_Y = -1.9
local CAM_ROLL_Z = 0.0
local CAM_DISTANCE = 12 
local FARM_POSITION = Vector3.new(324, -3, -1750)

FarmSec:Toggle({ 
    Title = "Start Auto Farm (Khóa màn hình & Camera)", 
    Desc = "Dịch chuyển -> Giả lập Shift-Lock -> Khóa Camera", 
    Flag = "StartAutoFarm_Flag", -- Flag để lưu Config
    Value = false, 
    Callback = function(state)
        _G.IsFarming = state
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")

        if state then
            if hrp then
                -- Dịch chuyển & Khóa chân
                hrp.CFrame = CFrame.new(FARM_POSITION)
                hrp.Anchored = true
                task.wait(0.2)

                -- Shift Lock ảo
                PressKey(Enum.KeyCode.LeftShift)
                UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter

                -- Khóa Camera
                Camera.CameraType = Enum.CameraType.Scriptable
                local radX = math.rad(CAM_PITCH_X)
                local radY = math.rad(CAM_YAW_Y)
                local radZ = math.rad(CAM_ROLL_Z)
                
                farmLoop = RunService.RenderStepped:Connect(function()
                    if _G.IsFarming and char and char:FindFirstChild("HumanoidRootPart") then
                        UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
                        hrp.CFrame = CFrame.new(FARM_POSITION) * CFrame.Angles(0, radY, 0)
                        Camera.CFrame = CFrame.new(FARM_POSITION) * CFrame.Angles(radX, radY, radZ) * CFrame.new(0, 0, CAM_DISTANCE)
                    end
                end)
                
                WindUI:Notify({Title = "Farm Setup", Content = "Kích hoạt khu vực Farm thành công!", Duration = 3})
            end
        else
            -- Tắt Farm
            if farmLoop then farmLoop:Disconnect() farmLoop = nil end
            if hrp then hrp.Anchored = false end
            
            Camera.CameraType = Enum.CameraType.Custom
            Camera.CameraSubject = char and char:FindFirstChild("Humanoid")
            UserInputService.MouseBehavior = Enum.MouseBehavior.Default
            
            PressKey(Enum.KeyCode.LeftShift)
        end
    end
})

FarmSec:Button({
    Title = "Khôi phục Camera & Chuột (Cứu Hộ)",
    Icon = "refresh-cw",
    Callback = function()
        if farmLoop then farmLoop:Disconnect() farmLoop = nil end
        Camera.CameraType = Enum.CameraType.Custom
        local char = LocalPlayer.Character
        if char then Camera.CameraSubject = char:FindFirstChild("Humanoid") end
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.Anchored = false end
        _G.IsFarming = false
    end
})

-- =========================================================================
-- SETTINGS & CONFIG MANAGER (TỰ ĐỘNG LƯU/TẢI)
-- =========================================================================
local SettingTab = Window:Tab({ Title = "Settings", Icon = "settings" })
SettingTab:Section({ Title = "Controls", Opened = true }):Keybind({ Title = "Toggle UI Key", Flag = "UIKey_Flag", Value = "G", Callback = function(v) Window:SetToggleKey(Enum.KeyCode[v]) end })

local ConfigSection = SettingTab:Section({ Title = "Config Manager", Icon = "save", Opened = true, Box = true })
local ConfigManager = Window.ConfigManager
local configName = "PuriumSaved"
local configFile = ConfigManager:CreateConfig(configName)
local savedConfigs = ConfigManager:AllConfigs()

local function getAutoLoad() 
    local s, r = pcall(function() 
        if isfile and isfile("PuriumAutoLoad.txt") then return readfile("PuriumAutoLoad.txt") end 
    end)
    if s and r then return r end 
    return "none" 
end

local function setAutoLoad(name) 
    pcall(function() 
        if writefile then writefile("PuriumAutoLoad.txt", name) end 
    end) 
end

if #savedConfigs == 0 then table.insert(savedConfigs, "PuriumSaved") end

local ConfigInput = ConfigSection:Input({ Title = "Tên Config", Value = configName, Callback = function(value) configName = value or "PuriumSaved" end })
local AutoLoadToggle

local ConfigDropdown = ConfigSection:Dropdown({ 
    Title = "Chọn Config Đã Lưu", 
    Values = savedConfigs, 
    Value = configName, 
    AllowNone = false, 
    Callback = function(value) 
        configName = value or "PuriumSaved"
        ConfigInput:Set(configName)
        if AutoLoadToggle then AutoLoadToggle:Set(getAutoLoad() == configName) end 
    end 
})

AutoLoadToggle = ConfigSection:Toggle({ 
    Title = "Auto-Load Config Khi Chạy Script", 
    Value = (getAutoLoad() == configName), 
    Callback = function(Value) 
        if Value then setAutoLoad(configName) else setAutoLoad("none") end 
    end 
})

ConfigSection:Button({ 
    Title = "Save Config (Lưu Cài đặt)", 
    Icon = "save", 
    Callback = function() 
        configFile = ConfigManager:CreateConfig(configName)
        if configFile:Save() then 
            local newList = ConfigManager:AllConfigs()
            if #newList == 0 then table.insert(newList, "PuriumSaved") end
            ConfigDropdown:Refresh(newList)
            WindUI:Notify({ Title = "Config System", Content = "Đã lưu cài đặt vào: " .. configName, Duration = 3 }) 
        end 
    end 
})

ConfigSection:Button({ 
    Title = "Load Config (Tải Cài đặt)", 
    Icon = "upload", 
    Callback = function() 
        configFile = ConfigManager:CreateConfig(configName)
        if configFile:Load() then 
            WindUI:Notify({ Title = "Config System", Content = "Đã tải cài đặt từ: " .. configName, Duration = 3 }) 
        end 
    end 
})

-- KÍCH HOẠT TỰ ĐỘNG NẠP CONFIG
task.spawn(function() 
    task.wait(1.5) 
    local autoConf = getAutoLoad()
    if autoConf ~= "none" then 
        configName = autoConf
        configFile = ConfigManager:CreateConfig(configName)
        pcall(function() 
            configFile:Load()
            WindUI:Notify({ Title = "Auto-Load Active", Content = "Đã nạp tự động: " .. configName, Duration = 4 }) 
        end) 
    end 
end)

print("Purium Master Farm Setup & Config Loaded!")

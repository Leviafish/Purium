Library = {}
SaveTheme = {}

local themes = {
    -- Đã thêm các theme mới vào chỉ mục (index)
    index = {'Dark', 'Amethyst','Rose','Light','Ocean','Galaxy','Clover', 'SBSD-Gold', 'Wind-Amethyst', 'Fluent-Dark'},
    
    -- --- GIỮ NGUYÊN CÁC THEME CŨ CỦA BẠN ---
    Dark = {['Shadow'] = Color3.fromRGB(15, 15, 15),['Background'] = Color3.fromRGB(20, 20, 20),['Page'] = Color3.fromRGB(25, 25, 25),['Main'] = Color3.fromRGB(255, 255, 255),['Text & Icon'] = Color3.fromRGB(200, 200, 200),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(25, 25, 25),['True'] = {['Toggle Background'] = Color3.fromRGB(255, 255, 255),['Toggle Value'] = Color3.fromRGB(0, 0, 0),},['False'] = {['Toggle Background'] = Color3.fromRGB(40, 40, 40),['Toggle Value'] = Color3.fromRGB(255, 255, 255),}},['Label'] = {['Background'] = Color3.fromRGB(25, 25, 25),},['Dropdown'] = {['Background'] = Color3.fromRGB(25, 25, 25),['Value Background'] = Color3.fromRGB(35, 35, 35),}}},
    Amethyst = {['Shadow'] = Color3.fromRGB(25, 10, 50),['Background'] = Color3.fromRGB(20, 10, 30),['Page'] = Color3.fromRGB(25, 15, 40),['Main'] = Color3.fromRGB(180, 100, 255),['Text & Icon'] = Color3.fromRGB(220, 200, 255),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(25, 15, 40),['True'] = {['Toggle Background'] = Color3.fromRGB(180, 100, 255),['Toggle Value'] = Color3.fromRGB(255, 255, 255),},['False'] = {['Toggle Background'] = Color3.fromRGB(40, 25, 60),['Toggle Value'] = Color3.fromRGB(180, 100, 255),}},['Label'] = {['Background'] = Color3.fromRGB(25, 15, 40),},['Dropdown'] = {['Background'] = Color3.fromRGB(25, 15, 40),['Value Background'] = Color3.fromRGB(40, 25, 65),}}},
    Rose = {['Shadow'] = Color3.fromRGB(50, 15, 25),['Background'] = Color3.fromRGB(30, 10, 20),['Page'] = Color3.fromRGB(40, 15, 25),['Main'] = Color3.fromRGB(255, 100, 150),['Text & Icon'] = Color3.fromRGB(255, 200, 220),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(40, 15, 25),['True'] = {['Toggle Background'] = Color3.fromRGB(255, 100, 150),['Toggle Value'] = Color3.fromRGB(255, 255, 255),},['False'] = {['Toggle Background'] = Color3.fromRGB(60, 25, 40),['Toggle Value'] = Color3.fromRGB(255, 100, 150),}},['Label'] = {['Background'] = Color3.fromRGB(40, 15, 25),},['Dropdown'] = {['Background'] = Color3.fromRGB(40, 15, 25),['Value Background'] = Color3.fromRGB(65, 25, 40),}}},
    Light = {['Shadow'] = Color3.fromRGB(200, 200, 200),['Background'] = Color3.fromRGB(245, 245, 245),['Page'] = Color3.fromRGB(255, 255, 255),['Main'] = Color3.fromRGB(0, 0, 0),['Text & Icon'] = Color3.fromRGB(50, 50, 50),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(255, 255, 255),['True'] = {['Toggle Background'] = Color3.fromRGB(0, 0, 0),['Toggle Value'] = Color3.fromRGB(255, 255, 255),},['False'] = {['Toggle Background'] = Color3.fromRGB(220, 220, 220),['Toggle Value'] = Color3.fromRGB(0, 0, 0),}},['Label'] = {['Background'] = Color3.fromRGB(255, 255, 255),},['Dropdown'] = {['Background'] = Color3.fromRGB(255, 255, 255),['Value Background'] = Color3.fromRGB(240, 240, 240),}}},
    Ocean = {['Shadow'] = Color3.fromRGB(10, 25, 50),['Background'] = Color3.fromRGB(10, 20, 30),['Page'] = Color3.fromRGB(15, 25, 40),['Main'] = Color3.fromRGB(100, 180, 255),['Text & Icon'] = Color3.fromRGB(200, 220, 255),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(15, 25, 40),['True'] = {['Toggle Background'] = Color3.fromRGB(100, 180, 255),['Toggle Value'] = Color3.fromRGB(255, 255, 255),},['False'] = {['Toggle Background'] = Color3.fromRGB(25, 40, 60),['Toggle Value'] = Color3.fromRGB(100, 180, 255),}},['Label'] = {['Background'] = Color3.fromRGB(15, 25, 40),},['Dropdown'] = {['Background'] = Color3.fromRGB(15, 25, 40),['Value Background'] = Color3.fromRGB(25, 40, 65),}}},
    Galaxy = {['Shadow'] = Color3.fromRGB(40, 0, 60),['Background'] = Color3.fromRGB(20, 10, 30),['Page'] = Color3.fromRGB(30, 15, 45),['Main'] = Color3.fromRGB(108, 0, 200),['Text & Icon'] = Color3.fromRGB(220, 220, 255),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(30, 15, 45),['True'] = {['Toggle Background'] = Color3.fromRGB(144, 0, 255),['Toggle Value'] = Color3.fromRGB(255, 255, 255),},['False'] = {['Toggle Background'] = Color3.fromRGB(60, 30, 80),['Toggle Value'] = Color3.fromRGB(120, 100, 180),}},['Label'] = {['Background'] = Color3.fromRGB(30, 15, 45),},['Dropdown'] = {['Background'] = Color3.fromRGB(30, 15, 45),['Value Background'] = Color3.fromRGB(40, 20, 60),}}},
    Clover = {['Shadow'] = Color3.fromRGB(0, 40, 0),['Background'] = Color3.fromRGB(10, 25, 10),['Page'] = Color3.fromRGB(15, 35, 15),['Main'] = Color3.fromRGB(0, 255, 100),['Text & Icon'] = Color3.fromRGB(200, 255, 200),['Function'] = {['Toggle'] = {['Background'] = Color3.fromRGB(15, 35, 15),['True'] = {['Toggle Background'] = Color3.fromRGB(0, 255, 100),['Toggle Value'] = Color3.fromRGB(0, 0, 0),},['False'] = {['Toggle Background'] = Color3.fromRGB(25, 55, 25),['Toggle Value'] = Color3.fromRGB(0, 255, 100),}},['Label'] = {['Background'] = Color3.fromRGB(15, 35, 15),},['Dropdown'] = {['Background'] = Color3.fromRGB(15, 35, 15),['Value Background'] = Color3.fromRGB(25, 50, 25),}}},

    -- --- CÁC THEME MỚI ĐƯỢC THÊM VÀO ---
    ['SBSD-Gold'] = {
        ['Shadow'] = Color3.fromHex("151515"),
        ['Background'] = Color3.fromHex("0A0A0A"),
        ['Page'] = Color3.fromHex("121212"),
        ['Main'] = Color3.fromHex("FFD700"),
        ['Text & Icon'] = Color3.fromRGB(255, 255, 255),
        ['Function'] = {
            ['Toggle'] = {
                ['Background'] = Color3.fromHex("121212"),
                ['True'] = {['Toggle Background'] = Color3.fromHex("FFD700"),['Toggle Value'] = Color3.fromRGB(0, 0, 0)},
                ['False'] = {['Toggle Background'] = Color3.fromHex("252525"),['Toggle Value'] = Color3.fromHex("FFD700")}
            },
            ['Label'] = {['Background'] = Color3.fromHex("121212")},
            ['Dropdown'] = {['Background'] = Color3.fromHex("121212"),['Value Background'] = Color3.fromHex("252525")}
        }
    },
    ['Wind-Amethyst'] = {
        ['Shadow'] = Color3.fromHex("321E46"),
        ['Background'] = Color3.fromHex("0F0A16"),
        ['Page'] = Color3.fromHex("1A1225"),
        ['Main'] = Color3.fromHex("7E2CB6"),
        ['Text & Icon'] = Color3.fromRGB(240, 240, 240),
        ['Function'] = {
            ['Toggle'] = {
                ['Background'] = Color3.fromHex("1A1225"),
                ['True'] = {['Toggle Background'] = Color3.fromHex("7E2CB6"),['Toggle Value'] = Color3.fromRGB(255, 255, 255)},
                ['False'] = {['Toggle Background'] = Color3.fromHex("321E46"),['Toggle Value'] = Color3.fromHex("7E2CB6")}
            },
            ['Label'] = {['Background'] = Color3.fromHex("1A1225")},
            ['Dropdown'] = {['Background'] = Color3.fromHex("1A1225"),['Value Background'] = Color3.fromHex("321E46")}
        }
    },
    ['Fluent-Dark'] = {
        ['Shadow'] = Color3.fromHex("1C1C1C"),
        ['Background'] = Color3.fromHex("1C1C1C"),
        ['Page'] = Color3.fromHex("252525"),
        ['Main'] = Color3.fromHex("0078D4"),
        ['Text & Icon'] = Color3.fromRGB(255, 255, 255),
        ['Function'] = {
            ['Toggle'] = {
                ['Background'] = Color3.fromHex("252525"),
                ['True'] = {['Toggle Background'] = Color3.fromHex("0078D4"),['Toggle Value'] = Color3.fromRGB(255, 255, 255)},
                ['False'] = {['Toggle Background'] = Color3.fromHex("3A3A3A"),['Toggle Value'] = Color3.fromHex("0078D4")}
            },
            ['Label'] = {['Background'] = Color3.fromHex("252525")},
            ['Dropdown'] = {['Background'] = Color3.fromHex("252525"),['Value Background'] = Color3.fromHex("3A3A3A")}
        }
    }
}

local _call11 = game:GetService('TweenService')
local _call13 = game:GetService('UserInputService')
-- [[ DUMMY UI - PHẦN 2: SYSTEM VARIABLES & UTILS ]]

local _call11 = game:GetService('TweenService')
local _call13 = game:GetService('UserInputService')
local _call15 = game:GetService('RunService')
local _call17 = game:GetService('CoreGui')
local _call19 = game:GetService('HttpService')

local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Hàm tạo bo góc và hiệu ứng đổ bóng (Giữ nguyên logic 5000 dòng)
local function _createCorner(parent, radius)
	local corner = Instance.new("UICorner")
	corner.CornerRadius = radius or UDim.new(0, 8)
	corner.Parent = parent
	return corner
end

local function _createStroke(parent, color, thickness, transparency)
	local stroke = Instance.new("UIStroke")
	stroke.Color = color or Color3.fromRGB(255, 255, 255)
	stroke.Thickness = thickness or 1
	stroke.Transparency = transparency or 0.8
	stroke.Parent = parent
	return stroke
end

-- Logic kéo thả (Draggable) chuyên nghiệp của bạn
local function MakeDraggable(gui)
	local dragging, dragInput, dragStart, startPos
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	_call13.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

-- [[ BẮT ĐẦU LOGIC KHỞI TẠO WINDOW GỐC ]]
function Library:InitWindow(Config)
	local WindowConfig = Config or {}
	local Title = WindowConfig.Title or "Purium Hub"
	local SelectedTheme = themes[WindowConfig.Theme] or themes['SBSD-Gold']
	
	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "Purium_" .. _call19:GenerateGUID(false)
	ScreenGui.Parent = _call17
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

	local MainFrame = Instance.new("Frame")
	MainFrame.Name = "MainFrame"
	MainFrame.Parent = ScreenGui
	MainFrame.BackgroundColor3 = SelectedTheme['Background']
	MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
	MainFrame.Size = UDim2.new(0, 550, 0, 400)
	MainFrame.ClipsDescendants = true
	_createCorner(MainFrame, UDim.new(0, 10))
	_createStroke(MainFrame, SelectedTheme['Shadow'], 2, 0.5)
	MakeDraggable(MainFrame)

	-- Thanh tiêu đề (TopBar)
	local TopBar = Instance.new("Frame")
	TopBar.Name = "TopBar"
	TopBar.Parent = MainFrame
	TopBar.BackgroundColor3 = SelectedTheme['Page']
	TopBar.Size = UDim2.new(1, 0, 0, 40)
	_createCorner(TopBar, UDim.new(0, 10))

	local WindowTitle = Instance.new("TextLabel")
	WindowTitle.Name = "WindowTitle"
	WindowTitle.Parent = TopBar
	WindowTitle.BackgroundTransparency = 1
	WindowTitle.Position = UDim2.new(0, 15, 0, 0)
	WindowTitle.Size = UDim2.new(1, -30, 1, 0)
	WindowTitle.Font = Enum.Font.GothamBold
	WindowTitle.Text = Title
	WindowTitle.TextColor3 = SelectedTheme['Text & Icon']
	WindowTitle.TextSize = 14
	WindowTitle.TextXAlignment = Enum.TextXAlignment.Left

    -- Container chứa các Tab
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = MainFrame
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 10, 0, 50)
    TabContainer.Size = UDim2.new(0, 150, 1, -60)
    TabContainer.ScrollBarThickness = 0
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabContainer
    TabListLayout.Padding = UDim.new(0, 5)

    -- Page Container (Nơi hiển thị nội dung các Tab)
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = MainFrame
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 170, 0, 50)
    PageContainer.Size = UDim2.new(1, -180, 1, -60)

    -- Logic chuyển đổi Theme động (Giữ nguyên từ code cũ)
    local function UpdateTheme(NewThemeName)
        local theme = themes[NewThemeName]
        if theme then
            MainFrame.BackgroundColor3 = theme['Background']
            TopBar.BackgroundColor3 = theme['Page']
            WindowTitle.TextColor3 = theme['Text & Icon']
            -- ... các logic cập nhật màu sắc khác cho hàng ngàn object bên dưới
        end
    end

	-- Trả về object Window gốc
	local WindowObj = {
        MainFrame = MainFrame,
        PageContainer = PageContainer,
        TabContainer = TabContainer,
        SelectedTheme = SelectedTheme,
        UpdateTheme = UpdateTheme
    }
-- [[ DUMMY UI - PHẦN 3: TAB & ELEMENTS LOGIC ]]

function WindowObj:CreateTab(Name, Icon)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = Name .. "_Tab"
    TabButton.Parent = self.TabContainer
    TabButton.BackgroundColor3 = self.SelectedTheme['Page']
    TabButton.Size = UDim2.new(1, -10, 0, 35)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = "  " .. Name
    TabButton.TextColor3 = self.SelectedTheme['Text & Icon']
    TabButton.TextSize = 13
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false
    _createCorner(TabButton, UDim.new(0, 6))

    local Page = Instance.new("ScrollingFrame")
    Page.Name = Name .. "_Page"
    Page.Parent = self.PageContainer
    Page.BackgroundTransparency = 1
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.Visible = false
    Page.ScrollBarThickness = 2
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local PageLayout = Instance.new("UIListLayout")
    PageLayout.Parent = Page
    PageLayout.Padding = UDim.new(0, 8)
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Tự động điều chỉnh kích thước Canvas
    PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 10)
    end)

    -- Logic chuyển Tab
    TabButton.MouseButton1Click:Connect(function()
        for _, p in pairs(self.PageContainer:GetChildren()) do
            p.Visible = false
        end
        Page.Visible = true
        -- Hiệu ứng đổi màu Tab đang chọn
        _call11:Create(TabButton, TweenInfo.new(0.3), {BackgroundColor3 = self.SelectedTheme['Main']}):Play()
    end)

    local TabMethods = {}

    -- 1. Tạo Button
    function TabMethods:CreateButton(Config)
        local ButtonFrame = Instance.new("Frame")
        ButtonFrame.Parent = Page
        ButtonFrame.BackgroundColor3 = WindowObj.SelectedTheme['Function']['Button']['Background']
        ButtonFrame.Size = UDim2.new(1, -10, 0, 40)
        _createCorner(ButtonFrame)

        local TextBtn = Instance.new("TextButton")
        TextBtn.Parent = ButtonFrame
        TextBtn.BackgroundTransparency = 1
        TextBtn.Size = UDim2.new(1, 0, 1, 0)
        TextBtn.Font = Enum.Font.GothamSemibold
        TextBtn.Text = Config.Title
        TextBtn.TextColor3 = WindowObj.SelectedTheme['Text & Icon']
        TextBtn.TextSize = 14

        TextBtn.MouseButton1Click:Connect(function()
            -- Hiệu ứng Ripple (Nếu file của bạn có logic này thì dán vào đây)
            pcall(Config.Callback)
        end)
        return ButtonFrame
    end

    -- 2. Tạo Toggle
    function TabMethods:CreateToggle(Config)
        local Toggled = Config.Value or false
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Parent = Page
        ToggleFrame.BackgroundColor3 = WindowObj.SelectedTheme['Function']['Toggle']['Background']
        ToggleFrame.Size = UDim2.new(1, -10, 0, 40)
        _createCorner(ToggleFrame)

        local Title = Instance.new("TextLabel")
        Title.Parent = ToggleFrame
        Title.Text = "  " .. Config.Title
        Title.TextColor3 = WindowObj.SelectedTheme['Text & Icon']
        -- ... (Logic vẽ nút gạt On/Off của bạn ở đây)

        local ClickBtn = Instance.new("TextButton")
        ClickBtn.Parent = ToggleFrame
        ClickBtn.BackgroundTransparency = 1
        ClickBtn.Size = UDim2.new(1, 0, 1, 0)
        ClickBtn.Text = ""

        ClickBtn.MouseButton1Click:Connect(function()
            Toggled = not Toggled
            -- Tween màu sắc theo theme SBSD/Wind mới
            local TargetColor = Toggled and WindowObj.SelectedTheme['Function']['Toggle']['True']['Toggle Background'] or WindowObj.SelectedTheme['Function']['Toggle']['False']['Toggle Background']
            _call11:Create(ToggleFrame, TweenInfo.new(0.3), {BackgroundColor3 = TargetColor}):Play()
            pcall(Config.Callback, Toggled)
        end)
    end

    -- 3. Tạo Slider (Giữ nguyên logic 5000 dòng của bạn)
    function TabMethods:CreateSlider(Config)
        -- (Dán logic Slider cực kỳ chi tiết của bạn vào đây)
        -- Đảm bảo sử dụng WindowObj.SelectedTheme['Main'] để khớp màu Gold/Amethyst
    end

    return TabMethods
end
-- [[ DUMMY UI - PHẦN 4: ADVANCED ELEMENTS & WRAPPER ]]

    -- 4. Tạo Dropdown
    function TabMethods:CreateDropdown(Config)
        local DropdownFrame = Instance.new("Frame")
        DropdownFrame.Parent = Page
        DropdownFrame.BackgroundColor3 = WindowObj.SelectedTheme['Function']['Dropdown']['Background']
        DropdownFrame.Size = UDim2.new(1, -10, 0, 40)
        _createCorner(DropdownFrame)

        local Title = Instance.new("TextLabel")
        Title.Parent = DropdownFrame
        Title.Text = "  " .. Config.Title
        Title.TextColor3 = WindowObj.SelectedTheme['Text & Icon']
        Title.BackgroundTransparency = 1
        Title.Size = UDim2.new(1, 0, 1, 0)
        Title.Font = Enum.Font.Gotham
        Title.TextSize = 13
        Title.TextXAlignment = Enum.TextXAlignment.Left

        -- (Logic xổ xuống và chọn Item của bạn ở đây...)
        -- Hãy đảm bảo các Item sử dụng WindowObj.SelectedTheme['Function']['Dropdown']['Value Background']
    end

    -- 5. Tạo Section (Nhóm các thành phần)
    function TabMethods:CreateSection(Name)
        local SectionFrame = Instance.new("Frame")
        SectionFrame.Parent = Page
        SectionFrame.BackgroundTransparency = 1
        SectionFrame.Size = UDim2.new(1, -10, 0, 25)

        local SectionText = Instance.new("TextLabel")
        SectionText.Parent = SectionFrame
        SectionText.Text = Name:upper()
        SectionText.TextColor3 = WindowObj.SelectedTheme['Main'] -- Sử dụng màu chủ đạo của Theme
        SectionText.Font = Enum.Font.GothamBold
        SectionText.TextSize = 11
        SectionText.Size = UDim2.new(1, 0, 1, 0)
        SectionText.TextXAlignment = Enum.TextXAlignment.Left
    end

    return TabMethods
end

-- [[ HỆ THỐNG THÔNG BÁO (NOTIFICATION) ]]
function Library:Notify(Config)
    -- Sử dụng logic thông báo Purium của bạn ở đây
    -- Ví dụ: tạo một Frame nhỏ ở góc màn hình với Title và Content
    print("[Purium Notify]: " .. tostring(Config.Content or Config.Text))
end

-- =========================================================
-- PHẦN QUAN TRỌNG: BỘ CHUYỂN ĐỔI SANG CẤU TRÚC WINDUI
-- =========================================================
function Library:CreateWindow(Settings)
    -- Gọi hàm InitWindow gốc để vẽ UI
    local OriginalWindow = self:InitWindow({
        Title = Settings.Title or "Purium Hub",
        Theme = Settings.Theme or "SBSD-Gold"
    })

    local WindStyle = {}

    -- Chuyển đổi Window:Tab()
    function WindStyle:Tab(TabCfg)
        local OriginalTab = OriginalWindow:CreateTab(TabCfg.Title or "Tab", TabCfg.Icon or "")
        local Elements = {}

        -- Chuyển đổi sang Tab:Toggle()
        function Elements:Toggle(TogCfg)
            return OriginalTab:CreateToggle({
                Title = TogCfg.Title,
                Value = TogCfg.Value or false,
                Callback = TogCfg.Callback
            })
        end

        -- Chuyển đổi sang Tab:Button()
        function Elements:Button(ButCfg)
            return OriginalTab:CreateButton({
                Title = ButCfg.Title,
                Callback = ButCfg.Callback
            })
        end

        -- Chuyển đổi sang Tab:Slider()
        function Elements:Slider(SliCfg)
            return OriginalTab:CreateSlider({
                Title = SliCfg.Title,
                Min = SliCfg.Min or 0,
                Max = SliCfg.Max or 100,
                Value = SliCfg.Default or SliCfg.Value or 50,
                Callback = SliCfg.Callback
            })
        end

        -- Chuyển đổi sang Tab:Dropdown()
        function Elements:Dropdown(DropCfg)
            return OriginalTab:CreateDropdown({
                Title = DropCfg.Title,
                List = DropCfg.Values or DropCfg.List or {},
                Callback = DropCfg.Callback
            })
        end

        return Elements
    end

    -- Chuyển đổi Window:Notify()
    function WindStyle:Notify(NotifyCfg)
        Library:Notify({
            Title = NotifyCfg.Title,
            Content = NotifyCfg.Content or NotifyCfg.Text,
            Duration = NotifyCfg.Duration or 5
        })
    end

    return WindStyle
end

-- CUỐI CÙNG: Trả về Library
return Library

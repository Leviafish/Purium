-- LuaNotify.lua | Library File
-- Host on GitHub Raw or Pastebin. Use the Loader to call it.

if _G.__LuaNotifyLoaded then return end
_G.__LuaNotifyLoaded = true

-- ════════════════════════════════════════════
--  Services
-- ════════════════════════════════════════════
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Players      = game:GetService("Players")

local LocalPlayer
repeat LocalPlayer = Players.LocalPlayer if not LocalPlayer then task.wait() end until LocalPlayer

local PlayerGui
repeat PlayerGui = LocalPlayer:FindFirstChild("PlayerGui") if not PlayerGui then task.wait() end until PlayerGui

-- ════════════════════════════════════════════
--  Config  (Loader can override via _G.LuaNotifyCFG)
-- ════════════════════════════════════════════
local CFG = {
    Position    = "TR",   -- TR | TL | BR | BL
    TimerMode   = 1,      -- 1 = countdown number | 2 = floating bar
    MaxVisible  = 5,
    DefaultTime = 5,
}

if type(_G.LuaNotifyCFG) == "table" then
    for k, v in pairs(_G.LuaNotifyCFG) do CFG[k] = v end
end

CFG.TimerMode = tonumber(CFG.TimerMode) or 1
if CFG.TimerMode ~= 1 and CFG.TimerMode ~= 2 then CFG.TimerMode = 1 end

-- ════════════════════════════════════════════
--  Preset colors
-- ════════════════════════════════════════════
local PRESETS = {
    green  = Color3.fromRGB(68,  210, 105),
    red    = Color3.fromRGB(248,  70,  70),
    yellow = Color3.fromRGB(235, 192,  32),
    white  = Color3.fromRGB(220, 220, 230),
    blue   = Color3.fromRGB(80,  160, 255),
    purple = Color3.fromRGB(180,  90, 255),
    orange = Color3.fromRGB(255, 140,  40),
}

-- ════════════════════════════════════════════
--  Type definitions  (accent + icon + label)
-- ════════════════════════════════════════════
local TYPES = {
    success = { accent = PRESETS.green,  iconBg = Color3.fromRGB(16,48,28),  icon = "✔", label = "SUCCESS" },
    info    = { accent = PRESETS.green,  iconBg = Color3.fromRGB(16,48,28),  icon = "●", label = "INFO"    },
    warning = { accent = PRESETS.yellow, iconBg = Color3.fromRGB(48,40,6),   icon = "▲", label = "WARNING" },
    error   = { accent = PRESETS.red,    iconBg = Color3.fromRGB(52,10,10),  icon = "✖", label = "ERROR"   },
}

-- ════════════════════════════════════════════
--  Resolve Color field
--  Accepts: "green" | "red" | {r,g,b} | Color3
-- ════════════════════════════════════════════
local function resolveColor(raw)
    if not raw then return nil end
    if typeof(raw) == "Color3" then return raw end
    if type(raw) == "string" then
        local s = raw:lower():gsub("%s","")
        return PRESETS[s]  -- nil if not a preset = use type default
    end
    if type(raw) == "table" and raw[1] and raw[2] and raw[3] then
        return Color3.fromRGB(
            math.clamp(raw[1],0,255),
            math.clamp(raw[2],0,255),
            math.clamp(raw[3],0,255)
        )
    end
    return nil
end

-- ════════════════════════════════════════════
--  Resolve asset ID
--  Accepts: "rbxassetid://123" | "123" | 123 | "https://..."
-- ════════════════════════════════════════════
local function resolveAsset(raw)
    if not raw or raw == "" then return nil end
    local s = tostring(raw):match("^%s*(.-)%s*$")
    if s == "" then return nil end
    if s:lower():find("^rbxassetid://") then return s end
    if s:match("^%d+$") then return "rbxassetid://" .. s end
    if s:lower():find("^https?://") then return s end
    return s
end

-- ════════════════════════════════════════════
--  Build ScreenGui
-- ════════════════════════════════════════════
if PlayerGui:FindFirstChild("__LuaNotify__") then
    PlayerGui:FindFirstChild("__LuaNotify__"):Destroy()
end

local Screen = Instance.new("ScreenGui")
Screen.Name           = "__LuaNotify__"
Screen.ResetOnSpawn   = false
Screen.IgnoreGuiInset = true
Screen.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Screen.DisplayOrder   = 9999
Screen.Parent         = PlayerGui

-- Full-screen container so cards can sit anywhere
local Container = Instance.new("Frame")
Container.Name                   = "Container"
Container.BackgroundTransparency = 1
Container.BorderSizePixel        = 0
Container.Size                   = UDim2.new(1, 0, 1, 0)
Container.ClipsDescendants       = false
Container.Parent                 = Screen

-- Derived position flags
local isRight  = CFG.Position:sub(2,2) == "R"
local isBottom = CFG.Position:sub(1,1) == "B"
local EDGE     = 18   -- px from screen edge
local GAP      = 8    -- px between cards

-- ════════════════════════════════════════════
--  Tween helpers
-- ════════════════════════════════════════════
local function tw(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local OUT    = TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local IN_    = TweenInfo.new(0.20, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local SPRING = TweenInfo.new(0.52, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
local function LIN(t) return TweenInfo.new(t, Enum.EasingStyle.Linear) end

-- ════════════════════════════════════════════
--  Stack
-- ════════════════════════════════════════════
local active = {}

-- Final resting X position for a card (UDim2 X part)
local function restX(cardW)
    if isRight then
        return UDim2.new(1, -(cardW + EDGE), 0, 0)
    else
        return UDim2.new(0, EDGE, 0, 0)
    end
end

-- Off-screen start X position
local function offX(cardW)
    if isRight then
        return UDim2.new(1, EDGE + 60, 0, 0)   -- off right edge
    else
        return UDim2.new(0, -(cardW + 60), 0, 0)  -- off left edge
    end
end

-- Reposition all visible cards in a clean stack
local function reflow()
    local slot = 0
    for i = #active, 1, -1 do
        local e = active[i]
        if not e.dismissed then
            local yOff = isBottom
                and -(EDGE + slot * (e.cardH + GAP) + e.cardH)
                or   EDGE  + slot * (e.cardH + GAP)

            local rx = restX(e.cardW)
            tw(e.frame, OUT, {
                Position = UDim2.new(
                    rx.X.Scale, rx.X.Offset,
                    isBottom and 1 or 0, yOff
                )
            })
            slot += 1
        end
    end
end

-- ════════════════════════════════════════════
--  Dismiss
-- ════════════════════════════════════════════
local function dismiss(entry)
    if entry.dismissed then return end
    entry.dismissed = true

    pcall(function() if entry.autoThread  then task.cancel(entry.autoThread)  end end)
    pcall(function() if entry.countThread then task.cancel(entry.countThread) end end)

    -- Slide off screen
    local cur = entry.frame.Position
    local ox  = offX(entry.cardW)
    tw(entry.frame, IN_, {
        Position = UDim2.new(ox.X.Scale, ox.X.Offset, cur.Y.Scale, cur.Y.Offset),
        BackgroundTransparency = 1,
    })

    for _, d in ipairs(entry.frame:GetDescendants()) do
        pcall(function()
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                tw(d, IN_, { TextTransparency = 1 })
            elseif d:IsA("ImageLabel") then
                tw(d, IN_, { ImageTransparency = 1, BackgroundTransparency = 1 })
            elseif d:IsA("Frame") then
                tw(d, IN_, { BackgroundTransparency = 1 })
            end
        end)
    end

    pcall(function()
        if entry.sound then entry.sound:Stop() entry.sound:Destroy() end
    end)

    -- Destroy after slide — two layers to guarantee it
    local gone = false
    local function kill()
        if gone then return end
        gone = true
        pcall(function() entry.frame:Destroy() end)
        for i = #active, 1, -1 do
            if active[i] == entry then table.remove(active, i) break end
        end
        reflow()
    end

    task.delay(0.22, kill)
    task.delay(0.55, kill)  -- hard fallback
end

-- ════════════════════════════════════════════
--  NOTIFY
-- ════════════════════════════════════════════
local function Notify(arg1, arg2, arg3)

    -- Accept table OR string call
    local cfg
    if type(arg1) == "table" then
        cfg = arg1
    else
        cfg = {
            Description = tostring(arg1 or ""),
            Type        = tostring(arg2 or "info"),
            Time        = tonumber(arg3) or CFG.DefaultTime,
        }
    end

    -- ── Read fields ──────────────────────────────────────────
    local title    = tostring(cfg.Title       or "")
    local desc     = tostring(cfg.Description or "")
    local nType    = tostring(cfg.Type        or "info"):lower()
    local duration = tonumber(cfg.Time)        or CFG.DefaultTime
    local imgId    = resolveAsset(cfg.Image)
    local sndId    = resolveAsset(cfg.Sound)
    local color    = resolveColor(cfg.Color)   -- optional accent override

    -- Size: {width, height} or nil = auto
    local cardW = 310
    local cardH = nil  -- determined below

    if type(cfg.Size) == "table" then
        cardW = tonumber(cfg.Size[1]) or cardW
        cardH = tonumber(cfg.Size[2])
    elseif type(cfg.Size) == "number" then
        cardW = cfg.Size
    end

    -- Validate
    if not TYPES[nType] then nType = "info" end
    duration = math.clamp(duration, 1, 60)

    local T      = TYPES[nType]
    local accent = color or T.accent   -- color override wins
    local iconBg = T.iconBg
    local hasImg = imgId ~= nil

    -- Auto height
    if not cardH then
        cardH = hasImg and 90 or 74
    end

    local leftX = hasImg and 68 or 46  -- text starts after image or icon

    -- ── Cull oldest if full ───────────────────────────────────
    if #active >= CFG.MaxVisible then
        dismiss(active[1])
        task.wait(0.04)
    end

    -- ── Card ─────────────────────────────────────────────────
    local card = Instance.new("Frame")
    card.Name                   = "NotifCard"
    card.Size                   = UDim2.new(0, cardW, 0, cardH)
    card.BackgroundColor3       = Color3.fromRGB(14, 16, 22)
    card.BackgroundTransparency = 0
    card.BorderSizePixel        = 0
    card.ClipsDescendants       = false
    card.ZIndex                 = 100
    card.Parent                 = Container

    -- Initial off-screen position
    local ox    = offX(cardW)
    local initY = isBottom and -(EDGE + cardH) or EDGE
    card.Position = UDim2.new(ox.X.Scale, ox.X.Offset, isBottom and 1 or 0, initY)

    Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke")
    stroke.Color           = Color3.fromRGB(42, 46, 62)
    stroke.Thickness       = 1
    stroke.Transparency    = 0.15
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent          = card

    -- Left accent strip
    local strip = Instance.new("Frame")
    strip.Size             = UDim2.new(0, 3, 1, -18)
    strip.Position         = UDim2.new(0, 0, 0, 9)
    strip.BackgroundColor3 = accent
    strip.BackgroundTransparency = 0
    strip.BorderSizePixel  = 0
    strip.ZIndex           = 101
    strip.Parent           = card
    Instance.new("UICorner", strip).CornerRadius = UDim.new(0, 3)

    -- ── Image or Icon ─────────────────────────────────────────
    if hasImg then
        local imgFrame = Instance.new("Frame")
        imgFrame.Size             = UDim2.new(0, 52, 0, 52)
        imgFrame.Position         = UDim2.new(0, 7, 0.5, -26)
        imgFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 40)
        imgFrame.BackgroundTransparency = 0
        imgFrame.BorderSizePixel  = 0
        imgFrame.ZIndex           = 101
        imgFrame.Parent           = card
        Instance.new("UICorner", imgFrame).CornerRadius = UDim.new(0, 8)

        local imgLbl = Instance.new("ImageLabel")
        imgLbl.Size                   = UDim2.new(1, 0, 1, 0)
        imgLbl.BackgroundTransparency = 1
        imgLbl.Image                  = imgId
        imgLbl.ScaleType              = Enum.ScaleType.Crop
        imgLbl.ImageTransparency      = 0
        imgLbl.ZIndex                 = 102
        imgLbl.Parent                 = imgFrame
        Instance.new("UICorner", imgLbl).CornerRadius = UDim.new(0, 8)
    else
        local iconBox = Instance.new("Frame")
        iconBox.Size             = UDim2.new(0, 28, 0, 28)
        iconBox.Position         = UDim2.new(0, 9, 0, 11)
        iconBox.BackgroundColor3 = iconBg
        iconBox.BackgroundTransparency = 0
        iconBox.BorderSizePixel  = 0
        iconBox.ZIndex           = 101
        iconBox.Parent           = card
        Instance.new("UICorner", iconBox).CornerRadius = UDim.new(0, 7)

        local iconLbl = Instance.new("TextLabel")
        iconLbl.Size                  = UDim2.new(1, 0, 1, 0)
        iconLbl.BackgroundTransparency= 1
        iconLbl.Text                  = T.icon
        iconLbl.TextColor3            = accent
        iconLbl.TextTransparency      = 0
        iconLbl.Font                  = Enum.Font.GothamBold
        iconLbl.TextSize              = 13
        iconLbl.ZIndex                = 102
        iconLbl.Parent                = iconBox
    end

    -- ── Badge (type label) ────────────────────────────────────
    local badgeW = cardW - leftX - (CFG.TimerMode == 1 and 50 or 28)

    local badge = Instance.new("TextLabel")
    badge.Size                  = UDim2.new(0, badgeW, 0, 14)
    badge.Position              = UDim2.new(0, leftX, 0, 8)
    badge.BackgroundTransparency= 1
    badge.Text                  = T.label
    badge.TextColor3            = accent
    badge.TextTransparency      = 0
    badge.Font                  = Enum.Font.GothamBold
    badge.TextSize              = 9
    badge.TextXAlignment        = Enum.TextXAlignment.Left
    badge.ZIndex                = 101
    badge.Parent                = card

    -- ── Timer Mode 1: countdown number ───────────────────────
    local countdownLbl = nil
    if CFG.TimerMode == 1 then
        countdownLbl = Instance.new("TextLabel")
        countdownLbl.Size                  = UDim2.new(0, 42, 0, 14)
        countdownLbl.Position              = UDim2.new(1, -46, 1, -17)
        countdownLbl.BackgroundTransparency= 1
        countdownLbl.Text                  = duration .. "s"
        countdownLbl.TextColor3            = Color3.fromRGB(55, 55, 66)
        countdownLbl.TextTransparency      = 0
        countdownLbl.Font                  = Enum.Font.GothamBold
        countdownLbl.TextSize              = 11
        countdownLbl.TextXAlignment        = Enum.TextXAlignment.Right
        countdownLbl.ZIndex                = 103
        countdownLbl.Parent                = card
    end

    -- ── Timer Mode 2: floating bar ────────────────────────────
    -- Sits 6px above the bottom, inset 10px each side, 2px tall
    -- Looks like it's floating inside the card, not glued to edge
    local barFill = nil
    if CFG.TimerMode == 2 then
        local barBg = Instance.new("Frame")
        barBg.Size             = UDim2.new(1, -20, 0, 2)
        barBg.Position         = UDim2.new(0, 10, 1, -8)   -- 8px above bottom
        barBg.BackgroundColor3 = Color3.fromRGB(28, 30, 44)
        barBg.BackgroundTransparency = 0
        barBg.BorderSizePixel  = 0
        barBg.ClipsDescendants = true
        barBg.ZIndex           = 101
        barBg.Parent           = card
        Instance.new("UICorner", barBg).CornerRadius = UDim.new(1, 0)

        barFill = Instance.new("Frame")
        barFill.Size             = UDim2.new(1, 0, 1, 0)
        barFill.BackgroundColor3 = accent
        barFill.BackgroundTransparency = 0
        barFill.BorderSizePixel  = 0
        barFill.ZIndex           = 102
        barFill.Parent           = barBg
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(1, 0)
    end

    -- ── Title ─────────────────────────────────────────────────
    local textY    = 22
    local bottomPad = CFG.TimerMode == 1 and 18 or 14

    if title ~= "" then
        local titleLbl = Instance.new("TextLabel")
        titleLbl.Size                  = UDim2.new(0, cardW - leftX - 26, 0, 17)
        titleLbl.Position              = UDim2.new(0, leftX, 0, textY)
        titleLbl.BackgroundTransparency= 1
        titleLbl.Text                  = title
        titleLbl.TextColor3            = Color3.fromRGB(226, 228, 244)
        titleLbl.TextTransparency      = 0
        titleLbl.Font                  = Enum.Font.GothamBold
        titleLbl.TextSize              = 13
        titleLbl.TextTruncate          = Enum.TextTruncate.AtEnd
        titleLbl.TextXAlignment        = Enum.TextXAlignment.Left
        titleLbl.ZIndex                = 101
        titleLbl.Parent                = card
        textY += 17
    end

    -- ── Description ───────────────────────────────────────────
    if desc ~= "" then
        local descLbl = Instance.new("TextLabel")
        descLbl.Size                  = UDim2.new(0, cardW - leftX - 26, 0, cardH - textY - bottomPad)
        descLbl.Position              = UDim2.new(0, leftX, 0, textY)
        descLbl.BackgroundTransparency= 1
        descLbl.Text                  = desc
        descLbl.TextColor3            = Color3.fromRGB(165, 168, 192)
        descLbl.TextTransparency      = 0
        descLbl.Font                  = Enum.Font.Gotham
        descLbl.TextSize              = 11
        descLbl.TextWrapped           = true
        descLbl.TextXAlignment        = Enum.TextXAlignment.Left
        descLbl.TextYAlignment        = Enum.TextYAlignment.Top
        descLbl.ZIndex                = 101
        descLbl.Parent                = card
    end

    -- ── Close button ──────────────────────────────────────────
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size                  = UDim2.new(0, 18, 0, 18)
    closeBtn.Position              = UDim2.new(1, -22, 0, 5)
    closeBtn.BackgroundTransparency= 1
    closeBtn.Text                  = "✕"
    closeBtn.TextColor3            = Color3.fromRGB(60, 64, 86)
    closeBtn.TextTransparency      = 0
    closeBtn.Font                  = Enum.Font.GothamBold
    closeBtn.TextSize              = 10
    closeBtn.ZIndex                = 103
    closeBtn.Parent                = card

    -- ── Shimmer ───────────────────────────────────────────────
    local shimmer = Instance.new("Frame")
    shimmer.Size             = UDim2.new(0.45, 0, 1, 0)
    shimmer.Position         = UDim2.new(-0.45, 0, 0, 0)
    shimmer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    shimmer.BackgroundTransparency = 0.87
    shimmer.BorderSizePixel  = 0
    shimmer.ZIndex           = 104
    shimmer.Parent           = card
    Instance.new("UICorner", shimmer).CornerRadius = UDim.new(0, 10)

    -- ── Sound ─────────────────────────────────────────────────
    local soundObj = nil
    if sndId then
        pcall(function()
            soundObj = Instance.new("Sound")
            soundObj.SoundId = sndId
            soundObj.Volume  = 0.5
            soundObj.Parent  = SoundService
            soundObj:Play()
        end)
    end

    -- ── Register ──────────────────────────────────────────────
    local entry = {
        frame       = card,
        cardW       = cardW,
        cardH       = cardH,
        dismissed   = false,
        autoThread  = nil,
        countThread = nil,
        sound       = soundObj,
    }
    table.insert(active, entry)
    reflow()  -- sets correct Y before we slide in

    -- ── Slide in ──────────────────────────────────────────────
    task.delay(0.03, function()
        if entry.dismissed then return end
        local p  = card.Position
        local rx = restX(cardW)

        -- Start off screen, spring to resting X
        card.Position = UDim2.new(ox.X.Scale, ox.X.Offset, p.Y.Scale, p.Y.Offset)
        tw(card, SPRING, {
            Position = UDim2.new(rx.X.Scale, rx.X.Offset, p.Y.Scale, p.Y.Offset)
        })
    end)

    -- Shimmer sweep after slide
    task.delay(0.18, function()
        if entry.dismissed then return end
        tw(shimmer, TweenInfo.new(0.65, Enum.EasingStyle.Sine),
            { Position = UDim2.new(1.1, 0, 0, 0) })
    end)

    -- ── Mode 1: countdown tick ────────────────────────────────
    if CFG.TimerMode == 1 and countdownLbl then
        entry.countThread = task.spawn(function()
            local rem = duration
            while rem > 0 and not entry.dismissed do
                countdownLbl.Text = rem .. "s"
                local pct  = rem / duration
                local gray = math.floor(48 + pct * 18)
                countdownLbl.TextColor3 = Color3.fromRGB(gray, gray, gray + 10)
                task.wait(1)
                rem -= 1
            end
            if not entry.dismissed then
                countdownLbl.Text = "0s"
            end
        end)
    end

    -- ── Mode 2: bar drain ─────────────────────────────────────
    if CFG.TimerMode == 2 and barFill then
        tw(barFill, LIN(duration), { Size = UDim2.new(0, 0, 1, 0) })
    end

    -- ── Hover ─────────────────────────────────────────────────
    card.MouseEnter:Connect(function()
        tw(stroke,   TweenInfo.new(0.15), { Color = accent, Transparency = 0.05 })
        tw(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(205,208,228) })
    end)
    card.MouseLeave:Connect(function()
        tw(stroke,   TweenInfo.new(0.15), { Color = Color3.fromRGB(42,46,62), Transparency = 0.15 })
        tw(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(60,64,86) })
    end)

    closeBtn.MouseButton1Click:Connect(function() dismiss(entry) end)

    -- ── Auto-dismiss ──────────────────────────────────────────
    -- Primary: fires at exact duration
    entry.autoThread = task.delay(duration, function()
        dismiss(entry)
    end)

    -- Backup: fires 0.7s later, force-kills if somehow still alive
    task.delay(duration + 0.7, function()
        if entry.dismissed then return end
        entry.dismissed = true
        pcall(function() entry.frame:Destroy() end)
        pcall(function() if entry.sound then entry.sound:Destroy() end end)
        for i = #active, 1, -1 do
            if active[i] == entry then table.remove(active, i) break end
        end
        reflow()
    end)
end

-- ════════════════════════════════════════════
--  Export
-- ════════════════════════════════════════════
_G.Notify = Notify
pcall(function() getgenv().Notify = Notify end)

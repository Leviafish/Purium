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
repeat
    LocalPlayer = Players.LocalPlayer
    if not LocalPlayer then task.wait() end
until LocalPlayer

local PlayerGui
repeat
    PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not PlayerGui then task.wait() end
until PlayerGui

-- ════════════════════════════════════════════
--  Config defaults  (Loader overrides via _G.LuaNotifyCFG)
-- ════════════════════════════════════════════
local CFG = {
    Position    = "TR",   -- TR | TL | BR | BL
    TimerMode   = 1,      -- 1 = countdown number | 2 = floating bar
    MaxVisible  = 5,
    DefaultTime = 5,
}

if type(_G.LuaNotifyCFG) == "table" then
    for k, v in pairs(_G.LuaNotifyCFG) do
        CFG[k] = v
    end
end

CFG.TimerMode = tonumber(CFG.TimerMode) or 1
if CFG.TimerMode ~= 1 and CFG.TimerMode ~= 2 then
    CFG.TimerMode = 1
end

-- ════════════════════════════════════════════
--  Position flags  (derived once from CFG)
-- ════════════════════════════════════════════
local POS     = tostring(CFG.Position):upper()
local isRight  = POS:sub(2,2) == "R"
local isBottom = POS:sub(1,1) == "B"
local EDGE     = 18   -- px from screen edge
local GAP      = 8    -- px gap between cards

-- ════════════════════════════════════════════
--  Preset accent colors
-- ════════════════════════════════════════════
local COLOR = {
    green   = Color3.fromRGB( 68, 210, 105),
    lime    = Color3.fromRGB(140, 230,  50),
    red     = Color3.fromRGB(248,  70,  70),
    orange  = Color3.fromRGB(255, 140,  40),
    yellow  = Color3.fromRGB(235, 192,  32),
    blue    = Color3.fromRGB( 80, 160, 255),
    cyan    = Color3.fromRGB( 40, 210, 230),
    purple  = Color3.fromRGB(180,  90, 255),
    pink    = Color3.fromRGB(255, 100, 180),
    white   = Color3.fromRGB(220, 220, 230),
    gray    = Color3.fromRGB(140, 140, 155),
}

-- ════════════════════════════════════════════
--  Notification type defaults
-- ════════════════════════════════════════════
local TYPES = {
    success = { accent = COLOR.green,  icon = "✔", label = "SUCCESS", iconBg = Color3.fromRGB(16, 48, 28) },
    info    = { accent = COLOR.blue,   icon = "●", label = "INFO",    iconBg = Color3.fromRGB(14, 36, 72) },
    warning = { accent = COLOR.yellow, icon = "▲", label = "WARNING", iconBg = Color3.fromRGB(48, 40,  6) },
    error   = { accent = COLOR.red,    icon = "✖", label = "ERROR",   iconBg = Color3.fromRGB(52, 10, 10) },
}

-- ════════════════════════════════════════════
--  Resolve Color field
--  "green" | "red" | {r,g,b} | Color3 | nil
-- ════════════════════════════════════════════
local function resolveColor(raw)
    if not raw then return nil end
    if typeof(raw) == "Color3" then return raw end
    if type(raw) == "string" then
        return COLOR[raw:lower():gsub("%s", "")]  -- nil if unknown = use type default
    end
    if type(raw) == "table" and raw[1] and raw[2] and raw[3] then
        return Color3.fromRGB(
            math.clamp(math.floor(raw[1]), 0, 255),
            math.clamp(math.floor(raw[2]), 0, 255),
            math.clamp(math.floor(raw[3]), 0, 255)
        )
    end
    return nil
end

-- ════════════════════════════════════════════
--  Resolve asset ID
--  rbxassetid://123 | "123" | 123 | https://...
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

-- Full-screen transparent container
local Container = Instance.new("Frame")
Container.Name                   = "Container"
Container.BackgroundTransparency = 1
Container.BorderSizePixel        = 0
Container.Size                   = UDim2.new(1, 0, 1, 0)
Container.ClipsDescendants       = false
Container.Parent                 = Screen

-- ════════════════════════════════════════════
--  Position helpers  (clean, explicit, correct)
-- ════════════════════════════════════════════

--  Final resting position for a card in stack slot `slot` (0-indexed)
local function restPos(cardW, cardH, slot)
    local xScale  = isRight and 1 or 0
    local xOffset = isRight and -(cardW + EDGE) or EDGE

    local yScale  = isBottom and 1 or 0
    local yOffset = isBottom
        and -(EDGE + slot * (cardH + GAP) + cardH)
        or   EDGE + slot * (cardH + GAP)

    return UDim2.new(xScale, xOffset, yScale, yOffset)
end

--  Off-screen start position (same Y as rest, X is off the edge)
local function offScreenPos(cardW, cardH)
    local xScale  = isRight and 1 or 0
    local xOffset = isRight and (EDGE + cardW + 60) or -(cardW + 60)

    local yScale  = isBottom and 1 or 0
    local yOffset = isBottom and -(EDGE + cardH) or EDGE

    return UDim2.new(xScale, xOffset, yScale, yOffset)
end

-- ════════════════════════════════════════════
--  Tween helpers
-- ════════════════════════════════════════════
local function tw(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local T_OUT    = TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local T_IN     = TweenInfo.new(0.20, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local T_SPRING = TweenInfo.new(0.52, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
local function T_LIN(t) return TweenInfo.new(t, Enum.EasingStyle.Linear) end

-- ════════════════════════════════════════════
--  Stack
-- ════════════════════════════════════════════
local active = {}   -- { frame, cardW, cardH, dismissed, autoThread, countThread, sound }

local function reflow()
    local slot = 0
    for i = #active, 1, -1 do
        local e = active[i]
        if not e.dismissed then
            tw(e.frame, T_OUT, {
                Position = restPos(e.cardW, e.cardH, slot)
            })
            slot += 1
        end
    end
end

-- ════════════════════════════════════════════
--  Dismiss  (double-kill guarantee)
-- ════════════════════════════════════════════
local function dismiss(entry)
    if entry.dismissed then return end
    entry.dismissed = true

    pcall(function() if entry.autoThread  then task.cancel(entry.autoThread)  end end)
    pcall(function() if entry.countThread then task.cancel(entry.countThread) end end)

    -- Slide off-screen (same Y, X flies off the correct edge)
    local cur = entry.frame.Position
    local off = offScreenPos(entry.cardW, entry.cardH)

    tw(entry.frame, T_IN, {
        Position = UDim2.new(off.X.Scale, off.X.Offset, cur.Y.Scale, cur.Y.Offset),
        BackgroundTransparency = 1,
    })

    for _, d in ipairs(entry.frame:GetDescendants()) do
        pcall(function()
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                tw(d, T_IN, { TextTransparency = 1 })
            elseif d:IsA("ImageLabel") then
                tw(d, T_IN, { ImageTransparency = 1, BackgroundTransparency = 1 })
            elseif d:IsA("Frame") then
                tw(d, T_IN, { BackgroundTransparency = 1 })
            end
        end)
    end

    pcall(function()
        if entry.sound then
            entry.sound:Stop()
            entry.sound:Destroy()
        end
    end)

    -- Destroy after slide — primary + hard fallback
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
    task.delay(0.60, kill)
end

-- ════════════════════════════════════════════
--  Instance helper  (avoids repetition)
-- ════════════════════════════════════════════
local function make(cls, props, parent)
    local obj = Instance.new(cls)
    for k, v in pairs(props) do
        obj[k] = v
    end
    if parent then obj.Parent = parent end
    return obj
end

local function corner(r, parent)
    make("UICorner", { CornerRadius = UDim.new(0, r) }, parent)
end

-- ════════════════════════════════════════════
--  NOTIFY  (main function)
-- ════════════════════════════════════════════
local function Notify(arg1, arg2, arg3)

    -- Accept table OR legacy string call: Notify("msg", "type", seconds)
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

    -- ── Read all fields ──────────────────────────────────────
    local title    = tostring(cfg.Title            or "")
    local desc     = tostring(cfg.Description      or "")
    local nType    = tostring(cfg.Type             or "info"):lower()
    local duration = tonumber(cfg.Time)             or CFG.DefaultTime
    local imgId    = resolveAsset(cfg.Image)
    local bgImgId  = resolveAsset(cfg.BackgroundImage)
    local sndId    = resolveAsset(cfg.Sound)
    local color    = resolveColor(cfg.Color)        -- overrides type accent
    local bgColor  = resolveColor(cfg.BackgroundColor) -- custom card background color

    -- Size: {width, height} table, or nil = auto
    local cardW, cardH = 300, nil
    if type(cfg.Size) == "table" then
        cardW = tonumber(cfg.Size[1]) or cardW
        cardH = tonumber(cfg.Size[2]) or nil
    elseif type(cfg.Size) == "number" then
        cardW = cfg.Size
    end

    -- Validate type
    if not TYPES[nType] then nType = "info" end
    duration = math.clamp(duration, 1, 60)

    local T      = TYPES[nType]
    local accent = color or T.accent    -- Color field wins over type default
    local hasImg = imgId ~= nil
    local hasBg  = bgImgId ~= nil

    -- Auto height to match Roblox notification feel
    if not cardH then
        cardH = hasImg and 88 or 70
    end

    -- Text content starts after icon or image
    local leftX = hasImg and 67 or 45

    -- Cull oldest if full
    if #active >= CFG.MaxVisible then
        dismiss(active[1])
        task.wait(0.04)
    end

    -- ── Card ─────────────────────────────────────────────────
    -- Background color: custom > dark default
    local cardBgColor = bgColor or Color3.fromRGB(14, 16, 22)

    local card = make("Frame", {
        Name                   = "NotifCard",
        Size                   = UDim2.new(0, cardW, 0, cardH),
        BackgroundColor3       = cardBgColor,
        BackgroundTransparency = 0,
        BorderSizePixel        = 0,
        ClipsDescendants       = false,
        ZIndex                 = 100,
        Position               = offScreenPos(cardW, cardH),
    }, Container)

    corner(10, card)

    -- Border stroke
    local stroke = make("UIStroke", {
        Color           = Color3.fromRGB(42, 46, 62),
        Thickness       = 1,
        Transparency    = 0.15,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, card)

    -- ── Background image (sits over bg color, under all content) ──
    if hasBg then
        local bgImg = make("ImageLabel", {
            Name                   = "BgImage",
            Size                   = UDim2.new(1, 0, 1, 0),
            Position               = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Image                  = bgImgId,
            ImageTransparency      = 0.55,   -- subtle, keeps text readable
            ScaleType              = Enum.ScaleType.Crop,
            ZIndex                 = 100,    -- just above card bg, below content
        }, card)
        corner(10, bgImg)
    end

    -- ── Left accent strip ────────────────────────────────────
    local strip = make("Frame", {
        Size             = UDim2.new(0, 3, 1, -18),
        Position         = UDim2.new(0, 0, 0, 9),
        BackgroundColor3 = accent,
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        ZIndex           = 101,
    }, card)
    corner(3, strip)

    -- ── Image  OR  Icon ──────────────────────────────────────
    if hasImg then
        local imgFrame = make("Frame", {
            Size             = UDim2.new(0, 50, 0, 50),
            Position         = UDim2.new(0, 8, 0.5, -25),
            BackgroundColor3 = Color3.fromRGB(26, 28, 40),
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ZIndex           = 101,
        }, card)
        corner(8, imgFrame)

        local imgLbl = make("ImageLabel", {
            Size                   = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image                  = imgId,
            ScaleType              = Enum.ScaleType.Crop,
            ImageTransparency      = 0,
            ZIndex                 = 102,
        }, imgFrame)
        corner(8, imgLbl)
    else
        -- Icon box color tinted by accent (dark version)
        local iconBgCol = T.iconBg
        local iconBox = make("Frame", {
            Size             = UDim2.new(0, 28, 0, 28),
            Position         = UDim2.new(0, 9, 0, 10),
            BackgroundColor3 = iconBgCol,
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ZIndex           = 101,
        }, card)
        corner(7, iconBox)

        make("TextLabel", {
            Size                  = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency= 1,
            Text                  = T.icon,
            TextColor3            = accent,   -- icon uses accent color
            TextTransparency      = 0,
            Font                  = Enum.Font.GothamBold,
            TextSize              = 13,
            ZIndex                = 102,
        }, iconBox)
    end

    -- ── Badge (type label, accent colored) ──────────────────
    local badgeW = cardW - leftX - (CFG.TimerMode == 1 and 50 or 26)

    make("TextLabel", {
        Size                  = UDim2.new(0, badgeW, 0, 14),
        Position              = UDim2.new(0, leftX, 0, 7),
        BackgroundTransparency= 1,
        Text                  = T.label,
        TextColor3            = accent,   -- badge uses accent color
        TextTransparency      = 0,
        Font                  = Enum.Font.GothamBold,
        TextSize              = 9,
        TextXAlignment        = Enum.TextXAlignment.Left,
        ZIndex                = 101,
    }, card)

    -- ── Mode 1: countdown number (bottom-right, dark gray) ───
    local countdownLbl = nil
    if CFG.TimerMode == 1 then
        countdownLbl = make("TextLabel", {
            Size                  = UDim2.new(0, 40, 0, 14),
            Position              = UDim2.new(1, -44, 1, -17),
            BackgroundTransparency= 1,
            Text                  = duration .. "s",
            TextColor3            = Color3.fromRGB(55, 55, 66),
            TextTransparency      = 0,
            Font                  = Enum.Font.GothamBold,
            TextSize              = 11,
            TextXAlignment        = Enum.TextXAlignment.Right,
            ZIndex                = 103,
        }, card)
    end

    -- ── Mode 2: floating bar (2px, inset, above bottom) ─────
    local barFill = nil
    if CFG.TimerMode == 2 then
        local barBg = make("Frame", {
            Size             = UDim2.new(1, -20, 0, 2),
            Position         = UDim2.new(0, 10, 1, -8),   -- 8px above bottom, inset
            BackgroundColor3 = Color3.fromRGB(28, 30, 44),
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ClipsDescendants = true,
            ZIndex           = 101,
        }, card)
        corner(99, barBg)   -- fully round ends (pill shape)

        barFill = make("Frame", {
            Size             = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = accent,   -- bar uses accent color
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ZIndex           = 102,
        }, barBg)
        corner(99, barFill)
    end

    -- ── Title ────────────────────────────────────────────────
    local textY     = 21
    local bottomPad = CFG.TimerMode == 1 and 18 or 14

    if title ~= "" then
        make("TextLabel", {
            Size                  = UDim2.new(0, cardW - leftX - 24, 0, 17),
            Position              = UDim2.new(0, leftX, 0, textY),
            BackgroundTransparency= 1,
            Text                  = title,
            TextColor3            = Color3.fromRGB(226, 228, 244),
            TextTransparency      = 0,
            Font                  = Enum.Font.GothamBold,
            TextSize              = 13,
            TextTruncate          = Enum.TextTruncate.AtEnd,
            TextXAlignment        = Enum.TextXAlignment.Left,
            ZIndex                = 101,
        }, card)
        textY += 17
    end

    -- ── Description ─────────────────────────────────────────
    if desc ~= "" then
        make("TextLabel", {
            Size                  = UDim2.new(0, cardW - leftX - 24, 0, cardH - textY - bottomPad),
            Position              = UDim2.new(0, leftX, 0, textY),
            BackgroundTransparency= 1,
            Text                  = desc,
            TextColor3            = Color3.fromRGB(168, 171, 195),
            TextTransparency      = 0,
            Font                  = Enum.Font.Gotham,
            TextSize              = 11,
            TextWrapped           = true,
            TextXAlignment        = Enum.TextXAlignment.Left,
            TextYAlignment        = Enum.TextYAlignment.Top,
            ZIndex                = 101,
        }, card)
    end

    -- ── Close button ─────────────────────────────────────────
    local closeBtn = make("TextButton", {
        Size                  = UDim2.new(0, 18, 0, 18),
        Position              = UDim2.new(1, -22, 0, 5),
        BackgroundTransparency= 1,
        Text                  = "✕",
        TextColor3            = Color3.fromRGB(60, 64, 86),
        TextTransparency      = 0,
        Font                  = Enum.Font.GothamBold,
        TextSize              = 10,
        ZIndex                = 103,
    }, card)

    -- ── Shimmer flash ────────────────────────────────────────
    local shimmer = make("Frame", {
        Size             = UDim2.new(0.45, 0, 1, 0),
        Position         = UDim2.new(-0.45, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.87,
        BorderSizePixel  = 0,
        ZIndex           = 104,
    }, card)
    corner(10, shimmer)

    -- ── Sound ────────────────────────────────────────────────
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

    -- ── Register entry ────────────────────────────────────────
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

    -- Reflow first so the correct Y is set, THEN slide in from X
    reflow()

    task.delay(0.03, function()
        if entry.dismissed then return end

        -- Grab the Y that reflow just set, keep it, only fix X
        local curPos = card.Position
        local rest   = restPos(cardW, cardH, 0)   -- slot doesn't matter, we keep Y

        -- Start off screen on the correct side
        local offX = offScreenPos(cardW, cardH)
        card.Position = UDim2.new(offX.X.Scale, offX.X.Offset, curPos.Y.Scale, curPos.Y.Offset)

        -- Spring to resting X, same Y
        tw(card, T_SPRING, {
            Position = UDim2.new(rest.X.Scale, rest.X.Offset, curPos.Y.Scale, curPos.Y.Offset)
        })
    end)

    -- Shimmer sweep
    task.delay(0.18, function()
        if entry.dismissed then return end
        tw(shimmer, TweenInfo.new(0.65, Enum.EasingStyle.Sine),
            { Position = UDim2.new(1.1, 0, 0, 0) })
    end)

    -- ── Mode 1: tick countdown ────────────────────────────────
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

    -- ── Mode 2: drain bar ────────────────────────────────────
    if CFG.TimerMode == 2 and barFill then
        tw(barFill, T_LIN(duration), { Size = UDim2.new(0, 0, 1, 0) })
    end

    -- ── Hover ────────────────────────────────────────────────
    card.MouseEnter:Connect(function()
        tw(stroke,   TweenInfo.new(0.15), { Color = accent, Transparency = 0.05 })
        tw(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(205, 208, 228) })
    end)
    card.MouseLeave:Connect(function()
        tw(stroke,   TweenInfo.new(0.15), { Color = Color3.fromRGB(42,46,62), Transparency = 0.15 })
        tw(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(60,64,86) })
    end)

    closeBtn.MouseButton1Click:Connect(function() dismiss(entry) end)

    -- ── Auto-dismiss  (primary + hard backup) ────────────────
    entry.autoThread = task.delay(duration, function()
        dismiss(entry)
    end)

    task.delay(duration + 0.8, function()
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
--  Export globally
--  _G.Notify       → LocalScript / Module
--  getgenv().Notify → executor environments
-- ════════════════════════════════════════════
_G.Notify = Notify
pcall(function() getgenv().Notify = Notify end)

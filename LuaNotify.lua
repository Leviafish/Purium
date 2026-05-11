--[[
    LuaNotify.lua  |  Library File
    ────────────────────────────────────────────────────────
    Upload this file to GitHub Raw or Pastebin.
    Use LuaNotify_Loader.lua in your scripts — not this file.

    FIXED IN THIS VERSION:
      • Position (TR/TL/BR/BL) now works correctly
      • No flash/glitch before card slides in
      • Close button always works (correct ZIndex + Active)
      • Hover: border glow + nudge toward screen center
      • Click/hold: subtle dark press feedback
      • TimerMode 1 (countdown) ticks every second reliably
      • TimerMode 2 (bar) drains smoothly with pill shape
      • Color changes ALL elements: strip + icon + badge + bar
      • BackgroundColor and BackgroundImage both supported
      • Auto-dismiss guaranteed with primary + hard backup
      • Shimmer has Active=false so it never blocks clicks
]]

-- ─────────────────────────────────────────────────────────
--  Guard: only run once even if loadstring called twice
-- ─────────────────────────────────────────────────────────
if _G.__LuaNotifyLoaded then return end
_G.__LuaNotifyLoaded = true

-- ─────────────────────────────────────────────────────────
--  Services
-- ─────────────────────────────────────────────────────────
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local Players      = game:GetService("Players")

-- Safe wait for LocalPlayer and PlayerGui (executor + LocalScript safe)
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

-- ─────────────────────────────────────────────────────────
--  Config  (Loader sets _G.LuaNotifyCFG before loadstring)
-- ─────────────────────────────────────────────────────────
local CFG = {
    Position    = "TR",  -- TR | TL | BR | BL
    TimerMode   = 1,     -- 1 = countdown number  |  2 = progress bar
    MaxVisible  = 5,
    DefaultTime = 5,
}

if type(_G.LuaNotifyCFG) == "table" then
    for k, v in pairs(_G.LuaNotifyCFG) do CFG[k] = v end
end

-- Validate TimerMode
CFG.TimerMode = tonumber(CFG.TimerMode) or 1
if CFG.TimerMode ~= 1 and CFG.TimerMode ~= 2 then CFG.TimerMode = 1 end

-- ─────────────────────────────────────────────────────────
--  Position flags  (computed once from CFG.Position)
-- ─────────────────────────────────────────────────────────
local POS       = tostring(CFG.Position or "TR"):upper()
local IS_RIGHT  = POS:sub(2, 2) == "R"   -- true for TR and BR
local IS_BOTTOM = POS:sub(1, 1) == "B"   -- true for BR and BL
local EDGE      = 16   -- px gap from screen edge
local GAP       = 8    -- px gap between stacked cards

-- ─────────────────────────────────────────────────────────
--  Preset colours
-- ─────────────────────────────────────────────────────────
local COLORS = {
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
    teal    = Color3.fromRGB( 30, 200, 170),
    gold    = Color3.fromRGB(255, 200,  50),
    magenta = Color3.fromRGB(230,  50, 200),
    navy    = Color3.fromRGB( 20,  40, 120),
    brown   = Color3.fromRGB(180, 100,  40),
    coral   = Color3.fromRGB(255, 100,  80),
}

-- ─────────────────────────────────────────────────────────
--  Type definitions (default accent + icon per type)
-- ─────────────────────────────────────────────────────────
local TYPES = {
    success = {
        accent = COLORS.green,
        icon   = "✔",
        label  = "SUCCESS",
        iconBg = Color3.fromRGB(14, 44, 24),
    },
    info = {
        accent = COLORS.blue,
        icon   = "●",
        label  = "INFO",
        iconBg = Color3.fromRGB(12, 32, 68),
    },
    warning = {
        accent = COLORS.yellow,
        icon   = "▲",
        label  = "WARNING",
        iconBg = Color3.fromRGB(44, 38,  4),
    },
    error = {
        accent = COLORS.red,
        icon   = "✖",
        label  = "ERROR",
        iconBg = Color3.fromRGB(48,  8,  8),
    },
}

-- ─────────────────────────────────────────────────────────
--  Helpers: Color + Asset resolvers
-- ─────────────────────────────────────────────────────────
local function resolveColor(raw)
    if not raw or raw == "" then return nil end
    if typeof(raw) == "Color3" then return raw end
    if type(raw) == "string"   then return COLORS[raw:lower():gsub("%s+", "")] end
    if type(raw) == "table" and raw[1] and raw[2] and raw[3] then
        return Color3.fromRGB(
            math.clamp(math.round(raw[1]), 0, 255),
            math.clamp(math.round(raw[2]), 0, 255),
            math.clamp(math.round(raw[3]), 0, 255)
        )
    end
    return nil
end

local function resolveAsset(raw)
    if not raw or raw == "" then return nil end
    local s = tostring(raw):match("^%s*(.-)%s*$")
    if s == "" then return nil end
    if s:lower():find("^rbxassetid://") then return s end
    if s:match("^%d+$") then return "rbxassetid://" .. s end
    if s:lower():find("^https?://") then return s end
    return nil
end

-- ─────────────────────────────────────────────────────────
--  Instance builder + UICorner shortcut
-- ─────────────────────────────────────────────────────────
local function new(cls, props, parent)
    local obj = Instance.new(cls)
    for k, v in pairs(props) do obj[k] = v end
    if parent then obj.Parent = parent end
    return obj
end

local function addCorner(r, parent)
    new("UICorner", { CornerRadius = UDim.new(0, r) }, parent)
end

-- ─────────────────────────────────────────────────────────
--  Tween helpers
-- ─────────────────────────────────────────────────────────
local function tw(obj, ti, props)
    TweenService:Create(obj, ti, props):Play()
end

local TI_IN     = TweenInfo.new(0.45, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
local TI_OUT    = TweenInfo.new(0.22, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local TI_REFLOW = TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local TI_HOVER  = TweenInfo.new(0.14, Enum.EasingStyle.Quad,  Enum.EasingDirection.Out)
local function TI_LIN(t) return TweenInfo.new(t, Enum.EasingStyle.Linear) end

-- ─────────────────────────────────────────────────────────
--  Build ScreenGui + Container  (before Notify so they are
--  captured as upvalues — the correct Lua approach)
-- ─────────────────────────────────────────────────────────
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

-- Full-screen container. Cards sit inside here using absolute pixel offsets.
-- X=0, Y=0 is the top-left corner; X=1,Y=1 (scale) is bottom-right.
local Container = Instance.new("Frame")
Container.Name                   = "Container"
Container.BackgroundTransparency = 1
Container.BorderSizePixel        = 0
Container.Size                   = UDim2.new(1, 0, 1, 0)
Container.ClipsDescendants       = false
Container.Parent                 = Screen

-- ─────────────────────────────────────────────────────────
--  Position math (all in absolute pixel offsets)
--
--  We use scale=0 for X always, so:
--    X offset = pixel distance from left edge of screen
--    For right-aligned: X = ScreenWidth - cardW - EDGE
--                       but we can't know ScreenWidth at this point.
--
--  SOLUTION: use scale for X too.
--    Right side: scale=1, offset=-(cardW+EDGE)  →  right edge minus width
--    Left  side: scale=0, offset=EDGE            →  left edge plus padding
--
--  Y:
--    Top   side: scale=0, offset = EDGE + slot*(cardH+GAP)
--    Bottom side: scale=1, offset = -(EDGE + slot*(cardH+GAP) + cardH)
-- ─────────────────────────────────────────────────────────

-- Compute resting UDim2 position for a card at a given slot
local function computeRestPos(cardW, cardH, slot)
    local xScale  = IS_RIGHT and 1 or 0
    local xOffset = IS_RIGHT and -(cardW + EDGE) or EDGE

    local yScale  = IS_BOTTOM and 1 or 0
    local yOffset = IS_BOTTOM
        and -(EDGE + slot * (cardH + GAP) + cardH)
        or   EDGE + slot * (cardH + GAP)

    return UDim2.new(xScale, xOffset, yScale, yOffset)
end

-- Compute off-screen starting position (same Y as rest, X flies off edge)
local function computeOffPos(cardW, cardH, slot)
    -- Off-screen X: push 80px beyond the edge the card comes from
    local xScale  = IS_RIGHT and 1 or 0
    local xOffset = IS_RIGHT and (cardW + EDGE + 80) or -(cardW + 80)

    -- Y is the same as resting Y (no vertical movement during slide-in)
    local yScale  = IS_BOTTOM and 1 or 0
    local yOffset = IS_BOTTOM
        and -(EDGE + slot * (cardH + GAP) + cardH)
        or   EDGE + slot * (cardH + GAP)

    return UDim2.new(xScale, xOffset, yScale, yOffset)
end

-- ─────────────────────────────────────────────────────────
--  Active stack
-- ─────────────────────────────────────────────────────────
local active = {}

-- Smooth restack of all visible cards
local function reflow()
    local slot = 0
    for i = #active, 1, -1 do
        local e = active[i]
        if not e.dismissed then
            tw(e.frame, TI_REFLOW, {
                Position = computeRestPos(e.cardW, e.cardH, slot)
            })
            slot += 1
        end
    end
end

-- ─────────────────────────────────────────────────────────
--  Dismiss a card
-- ─────────────────────────────────────────────────────────
local function dismiss(entry)
    if entry.dismissed then return end
    entry.dismissed = true

    -- Cancel timer threads
    pcall(function() if entry.autoThread  then task.cancel(entry.autoThread)  end end)
    pcall(function() if entry.countThread then task.cancel(entry.countThread) end end)

    -- Slide card off-screen (keep Y, fly X off the correct edge)
    local cur      = entry.frame.Position
    local xScale   = IS_RIGHT and 1 or 0
    local xOff     = IS_RIGHT and (entry.cardW + EDGE + 80) or -(entry.cardW + 80)

    tw(entry.frame, TI_OUT, {
        Position = UDim2.new(xScale, xOff, cur.Y.Scale, cur.Y.Offset),
        BackgroundTransparency = 1,
    })

    -- Fade all children
    for _, d in ipairs(entry.frame:GetDescendants()) do
        pcall(function()
            if d:IsA("TextLabel") or d:IsA("TextButton") then
                tw(d, TI_OUT, { TextTransparency = 1 })
            elseif d:IsA("ImageLabel") then
                tw(d, TI_OUT, { ImageTransparency = 1, BackgroundTransparency = 1 })
            elseif d:IsA("Frame") then
                tw(d, TI_OUT, { BackgroundTransparency = 1 })
            elseif d:IsA("UIStroke") then
                tw(d, TI_OUT, { Transparency = 1 })
            end
        end)
    end

    -- Stop sound
    pcall(function()
        if entry.sound then entry.sound:Stop() entry.sound:Destroy() end
    end)

    -- Destroy after slide animation — primary + hard fallback
    local killed = false
    local function kill()
        if killed then return end
        killed = true
        pcall(function() entry.frame:Destroy() end)
        for i = #active, 1, -1 do
            if active[i] == entry then table.remove(active, i) break end
        end
        reflow()
    end

    task.delay(0.24, kill)
    task.delay(0.80, kill)  -- guaranteed kill
end

-- ─────────────────────────────────────────────────────────
--  NOTIFY  —  the main function
-- ─────────────────────────────────────────────────────────
local function Notify(arg1, arg2, arg3)

    -- Accept table call OR legacy string call: Notify("msg","type", 5)
    local cfg
    if type(arg1) == "table" then
        cfg = arg1
    else
        cfg = {
            Description = tostring(arg1 or ""),
            Type        = tostring(arg2 or "info"),
            Time        = tonumber(arg3),
        }
    end

    -- ── Parse ────────────────────────────────────────────────
    local title    = tostring(cfg.Title       or "")
    local desc     = tostring(cfg.Description or "")
    local nType    = tostring(cfg.Type        or "info"):lower()
    local duration = tonumber(cfg.Time)        or CFG.DefaultTime
    local imgId    = resolveAsset(cfg.Image)
    local bgImgId  = resolveAsset(cfg.BackgroundImage)
    local sndId    = resolveAsset(cfg.Sound)
    local accent   = resolveColor(cfg.Color)           -- nil = use type default
    local bgColor  = resolveColor(cfg.BackgroundColor) -- nil = dark default

    -- Size: {width, height} or nil = auto
    local cardW = 300
    local cardH = nil
    if type(cfg.Size) == "table" then
        cardW = math.clamp(tonumber(cfg.Size[1]) or 300, 160, 700)
        cardH = tonumber(cfg.Size[2]) or nil
    elseif type(cfg.Size) == "number" then
        cardW = math.clamp(cfg.Size, 160, 700)
    end

    -- Validate type
    if not TYPES[nType] then nType = "info" end
    duration = math.clamp(duration, 1, 60)

    local T        = TYPES[nType]
    accent         = accent or T.accent        -- Color field overrides type default
    local hasImg   = imgId ~= nil
    local hasBgImg = bgImgId ~= nil
    local cardBg   = bgColor or Color3.fromRGB(14, 16, 22)

    -- Auto card height
    if not cardH then cardH = hasImg and 86 or 70 end

    -- Text content starts after icon (44px) or image (66px)
    local textLeft = hasImg and 66 or 44

    -- ── Cull oldest if stack is full ──────────────────────────
    if #active >= CFG.MaxVisible then
        dismiss(active[1])
        task.wait(0.03)
    end

    -- ── Compute this card's slot BEFORE inserting into active ─
    -- slot = number of currently visible (non-dismissed) cards
    local slot = 0
    for _, e in ipairs(active) do
        if not e.dismissed then slot += 1 end
    end

    -- ── Card frame ────────────────────────────────────────────
    -- Position starts OFF-SCREEN at correct Y — NO flash at wrong place
    local startPos = computeOffPos(cardW, cardH, slot)
    local restPos  = computeRestPos(cardW, cardH, slot)

    local card = new("Frame", {
        Name                   = "NotifCard",
        Size                   = UDim2.new(0, cardW, 0, cardH),
        Position               = startPos,         -- correct Y, off-screen X
        BackgroundColor3       = cardBg,
        BackgroundTransparency = 0,
        BorderSizePixel        = 0,
        ClipsDescendants       = false,
        ZIndex                 = 100,
        Active                 = false,             -- frame does NOT eat mouse events
    }, Container)

    addCorner(10, card)

    -- Border (accent-coloured, dim at rest, bright on hover)
    local stroke = new("UIStroke", {
        Color           = accent,
        Thickness       = 1,
        Transparency    = 0.72,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, card)

    -- ── Background image ──────────────────────────────────────
    if hasBgImg then
        local bgImg = new("ImageLabel", {
            Name                   = "BgImage",
            Size                   = UDim2.new(1, 0, 1, 0),
            Position               = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1,
            Image                  = bgImgId,
            ImageTransparency      = 0.52,
            ScaleType              = Enum.ScaleType.Crop,
            ZIndex                 = 100,
        }, card)
        addCorner(10, bgImg)
    end

    -- ── Left accent strip (accent color) ──────────────────────
    local strip = new("Frame", {
        Size             = UDim2.new(0, 3, 1, -18),
        Position         = UDim2.new(0, 0, 0, 9),
        BackgroundColor3 = accent,
        BackgroundTransparency = 0,
        BorderSizePixel  = 0,
        ZIndex           = 101,
    }, card)
    addCorner(3, strip)

    -- ── Image OR Icon ─────────────────────────────────────────
    if hasImg then
        local imgBox = new("Frame", {
            Size             = UDim2.new(0, 48, 0, 48),
            Position         = UDim2.new(0, 9, 0.5, -24),
            BackgroundColor3 = Color3.fromRGB(20, 22, 34),
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ZIndex           = 101,
        }, card)
        addCorner(8, imgBox)

        local imgLbl = new("ImageLabel", {
            Size                   = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image                  = imgId,
            ScaleType              = Enum.ScaleType.Crop,
            ImageTransparency      = 0,
            ZIndex                 = 102,
        }, imgBox)
        addCorner(8, imgLbl)
    else
        local iconBox = new("Frame", {
            Size             = UDim2.new(0, 28, 0, 28),
            Position         = UDim2.new(0, 9, 0, 10),
            BackgroundColor3 = T.iconBg,
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ZIndex           = 101,
        }, card)
        addCorner(7, iconBox)

        -- Icon color = accent (so custom Color changes the icon too)
        new("TextLabel", {
            Size                   = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text                   = T.icon,
            TextColor3             = accent,
            TextTransparency       = 0,
            Font                   = Enum.Font.GothamBold,
            TextSize               = 13,
            ZIndex                 = 102,
        }, iconBox)
    end

    -- ── Badge (label, accent color) ───────────────────────────
    local badgeW = cardW - textLeft - (CFG.TimerMode == 1 and 50 or 26)

    new("TextLabel", {
        Size                   = UDim2.new(0, badgeW, 0, 14),
        Position               = UDim2.new(0, textLeft, 0, 7),
        BackgroundTransparency = 1,
        Text                   = T.label,
        TextColor3             = accent,   -- accent color
        TextTransparency       = 0,
        Font                   = Enum.Font.GothamBold,
        TextSize               = 9,
        TextXAlignment         = Enum.TextXAlignment.Left,
        ZIndex                 = 101,
    }, card)

    -- ── Timer Mode 1: countdown number ────────────────────────
    local countdownLbl = nil
    if CFG.TimerMode == 1 then
        countdownLbl = new("TextLabel", {
            Size                   = UDim2.new(0, 44, 0, 14),
            Position               = UDim2.new(1, -48, 1, -18),
            BackgroundTransparency = 1,
            Text                   = tostring(duration) .. "s",
            TextColor3             = Color3.fromRGB(52, 52, 65),  -- dark gray
            TextTransparency       = 0,
            Font                   = Enum.Font.GothamBold,
            TextSize               = 11,
            TextXAlignment         = Enum.TextXAlignment.Right,
            ZIndex                 = 103,
        }, card)
    end

    -- ── Timer Mode 2: floating progress bar ───────────────────
    -- 2px tall, 10px inset each side, 9px above bottom → looks floating
    local barFill = nil
    if CFG.TimerMode == 2 then
        local barBg = new("Frame", {
            Size             = UDim2.new(1, -20, 0, 2),
            Position         = UDim2.new(0, 10, 1, -9),
            BackgroundColor3 = Color3.fromRGB(24, 26, 40),
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ClipsDescendants = true,
            ZIndex           = 101,
        }, card)
        addCorner(99, barBg)  -- pill shape

        barFill = new("Frame", {
            Size             = UDim2.new(1, 0, 1, 0),
            BackgroundColor3 = accent,   -- accent color
            BackgroundTransparency = 0,
            BorderSizePixel  = 0,
            ZIndex           = 102,
        }, barBg)
        addCorner(99, barFill)
    end

    -- ── Title ─────────────────────────────────────────────────
    local textY     = 21
    local bottomPad = CFG.TimerMode == 1 and 20 or 14

    if title ~= "" then
        new("TextLabel", {
            Size                   = UDim2.new(0, cardW - textLeft - 28, 0, 17),
            Position               = UDim2.new(0, textLeft, 0, textY),
            BackgroundTransparency = 1,
            Text                   = title,
            TextColor3             = Color3.fromRGB(228, 230, 246),
            TextTransparency       = 0,
            Font                   = Enum.Font.GothamBold,
            TextSize               = 13,
            TextTruncate           = Enum.TextTruncate.AtEnd,
            TextXAlignment         = Enum.TextXAlignment.Left,
            ZIndex                 = 101,
        }, card)
        textY += 17
    end

    -- ── Description ───────────────────────────────────────────
    if desc ~= "" then
        new("TextLabel", {
            Size                   = UDim2.new(0, cardW - textLeft - 28, 0, math.max(cardH - textY - bottomPad, 12)),
            Position               = UDim2.new(0, textLeft, 0, textY),
            BackgroundTransparency = 1,
            Text                   = desc,
            TextColor3             = Color3.fromRGB(164, 168, 194),
            TextTransparency       = 0,
            Font                   = Enum.Font.Gotham,
            TextSize               = 11,
            TextWrapped            = true,
            TextXAlignment         = Enum.TextXAlignment.Left,
            TextYAlignment         = Enum.TextYAlignment.Top,
            ZIndex                 = 101,
        }, card)
    end

    -- ── Close button (ZIndex 105 = highest, always clickable) ─
    local closeBtn = new("TextButton", {
        Name                   = "CloseBtn",
        Size                   = UDim2.new(0, 20, 0, 20),
        Position               = UDim2.new(1, -24, 0, 5),
        BackgroundColor3       = Color3.fromRGB(30, 32, 44),
        BackgroundTransparency = 1,
        Text                   = "✕",
        TextColor3             = Color3.fromRGB(65, 68, 90),
        TextTransparency       = 0,
        Font                   = Enum.Font.GothamBold,
        TextSize               = 11,
        AutoButtonColor        = false,
        Active                 = true,   -- button captures clicks
        ZIndex                 = 105,    -- above everything
    }, card)
    addCorner(5, closeBtn)

    -- ── Shimmer flash (Active=false → never blocks clicks) ────
    local shimmer = new("Frame", {
        Size             = UDim2.new(0.5, 0, 1, 0),
        Position         = UDim2.new(-0.5, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.88,
        BorderSizePixel  = 0,
        Active           = false,   -- NEVER eats mouse events
        ZIndex           = 104,
    }, card)
    addCorner(10, shimmer)

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

    -- ── Register entry in active stack ────────────────────────
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

    -- Reflow older cards into new positions first
    reflow()

    -- ── Slide in: spring from off-screen to rest position ─────
    -- Card starts at correct Y (no reflow needed after this)
    -- Only X animates — no Y jump, no flash
    tw(card, TI_IN, { Position = restPos })

    -- Shimmer sweep after card arrives
    task.delay(0.28, function()
        if entry.dismissed then return end
        tw(shimmer, TweenInfo.new(0.55, Enum.EasingStyle.Sine),
            { Position = UDim2.new(1.1, 0, 0, 0) })
    end)

    -- ── Timer Mode 1: countdown tick ──────────────────────────
    if CFG.TimerMode == 1 and countdownLbl then
        entry.countThread = task.spawn(function()
            local rem = duration
            while not entry.dismissed and rem >= 0 do
                -- Guard against the label being destroyed
                local ok = pcall(function()
                    countdownLbl.Text = rem .. "s"
                    local pct  = rem / duration
                    local gray = math.floor(52 + pct * 22)
                    countdownLbl.TextColor3 = Color3.fromRGB(gray, gray, gray + 8)
                end)
                if not ok then break end
                if rem == 0 then break end
                task.wait(1)
                rem -= 1
            end
        end)
    end

    -- ── Timer Mode 2: bar drain tween ─────────────────────────
    if CFG.TimerMode == 2 and barFill then
        tw(barFill, TI_LIN(duration), { Size = UDim2.new(0, 0, 1, 0) })
    end

    -- ── Hover: border glow + nudge toward screen center ───────
    -- Nudge direction: right-aligned cards nudge left, left-aligned nudge right
    local nudge = IS_RIGHT and -5 or 5

    card.MouseEnter:Connect(function()
        tw(stroke, TI_HOVER, { Transparency = 0.08 })   -- border glows brighter
        tw(closeBtn, TI_HOVER, {
            TextColor3             = Color3.fromRGB(210, 212, 232),
            BackgroundTransparency = 0.55,
        })
        -- Nudge card slightly toward screen center
        local p = card.Position
        tw(card, TI_HOVER, {
            Position = UDim2.new(p.X.Scale, p.X.Offset + nudge, p.Y.Scale, p.Y.Offset)
        })
    end)

    card.MouseLeave:Connect(function()
        tw(stroke, TI_HOVER, { Transparency = 0.72 })
        tw(closeBtn, TI_HOVER, {
            TextColor3             = Color3.fromRGB(65, 68, 90),
            BackgroundTransparency = 1,
        })
        -- Snap back to exact rest X
        local p = card.Position
        tw(card, TI_HOVER, {
            Position = UDim2.new(restPos.X.Scale, restPos.X.Offset, p.Y.Scale, p.Y.Offset)
        })
    end)

    -- ── Click/hold feedback ───────────────────────────────────
    local PRESS_COLOR = Color3.fromRGB(
        math.clamp(cardBg.R * 255 - 10, 0, 255),
        math.clamp(cardBg.G * 255 - 10, 0, 255),
        math.clamp(cardBg.B * 255 - 10, 0, 255)
    )
    card.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            tw(card, TI_HOVER, { BackgroundColor3 = PRESS_COLOR })
        end
    end)
    card.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            tw(card, TI_HOVER, { BackgroundColor3 = cardBg })
        end
    end)

    -- ── Close button interactions ─────────────────────────────
    closeBtn.MouseEnter:Connect(function()
        tw(closeBtn, TI_HOVER, {
            TextColor3             = COLORS.red,
            BackgroundTransparency = 0.3,
        })
    end)
    closeBtn.MouseLeave:Connect(function()
        tw(closeBtn, TI_HOVER, {
            TextColor3             = Color3.fromRGB(210, 212, 232),
            BackgroundTransparency = 0.55,
        })
    end)
    closeBtn.MouseButton1Click:Connect(function()
        dismiss(entry)
    end)

    -- ── Auto-dismiss: primary + guaranteed hard backup ─────────
    entry.autoThread = task.delay(duration, function()
        dismiss(entry)
    end)

    -- Hard backup fires 1s after duration — kills card even if dismiss failed
    task.delay(duration + 1.0, function()
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

-- ─────────────────────────────────────────────────────────
--  Export globally
--  _G.Notify       →  standard LocalScripts
--  getgenv().Notify →  executor environments (Synapse etc.)
-- ─────────────────────────────────────────────────────────
_G.Notify = Notify
pcall(function() getgenv().Notify = Notify end)

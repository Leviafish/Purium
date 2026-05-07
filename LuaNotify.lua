--[[
    LuaNotify.lua — LIBRARY FILE
    Upload this to GitHub Raw or Pastebin.
    Do NOT paste this into your script — use the Loader instead.
]]

-- Guard: only load once even if loadstring is called twice
if _G.__LuaNotifyLoaded then return end
_G.__LuaNotifyLoaded = true

-- ─────────────────────────────────────────────────────────
--  Services
-- ─────────────────────────────────────────────────────────
local TweenService  = game:GetService("TweenService")
local SoundService  = game:GetService("SoundService")
local Players       = game:GetService("Players")

-- Wait for LocalPlayer and PlayerGui safely
-- (works in both LocalScript and executor injection)
local LocalPlayer
repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer

local PlayerGui
repeat PlayerGui = LocalPlayer:FindFirstChild("PlayerGui") task.wait() until PlayerGui

-- ─────────────────────────────────────────────────────────
--  Default config (overridden by Loader via _G.LuaNotifyCFG)
-- ─────────────────────────────────────────────────────────
local CFG = {
    Position    = "TR",  -- TR | TL | BR | BL
    MaxVisible  = 5,
    DefaultTime = 5,
    TimerMode   = 1,     -- 1 = countdown number | 2 = progress bar
}

-- Apply any overrides set by the Loader
if type(_G.LuaNotifyCFG) == "table" then
    for k, v in pairs(_G.LuaNotifyCFG) do
        CFG[k] = v
    end
end

-- Resolve TimerMode: nil/"" → 1
CFG.TimerMode = tonumber(CFG.TimerMode) or 1
if CFG.TimerMode ~= 1 and CFG.TimerMode ~= 2 then
    CFG.TimerMode = 1
end

-- ─────────────────────────────────────────────────────────
--  Type styles
-- ─────────────────────────────────────────────────────────
local STYLES = {
    success = { accent = Color3.fromRGB(68, 210, 105), iconBg = Color3.fromRGB(16, 48, 28), icon = "✔", label = "SUCCESS" },
    info    = { accent = Color3.fromRGB(68, 210, 105), iconBg = Color3.fromRGB(16, 48, 28), icon = "●", label = "INFO"    },
    warning = { accent = Color3.fromRGB(235, 192, 32), iconBg = Color3.fromRGB(48, 40,  6), icon = "▲", label = "WARNING" },
    error   = { accent = Color3.fromRGB(248,  70, 70), iconBg = Color3.fromRGB(52, 10, 10), icon = "✖", label = "ERROR"   },
}

-- ─────────────────────────────────────────────────────────
--  Build ScreenGui + Container
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

local isLeft   = CFG.Position:sub(2, 2) == "L"
local isBottom = CFG.Position:sub(1, 1) == "B"

local Container = Instance.new("Frame")
Container.Name                   = "Container"
Container.BackgroundTransparency = 1
Container.BorderSizePixel        = 0
Container.Size                   = UDim2.new(1, 0, 1, 0)
Container.ClipsDescendants       = false
Container.Position               = UDim2.new(0, 0, 0, 0)
Container.Parent                 = Screen

-- ─────────────────────────────────────────────────────────
--  Tween shortcuts
-- ─────────────────────────────────────────────────────────
local function tw(obj, info, props)
    TweenService:Create(obj, info, props):Play()
end

local T_OUT    = TweenInfo.new(0.38, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
local T_IN     = TweenInfo.new(0.20, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
local T_SPRING = TweenInfo.new(0.52, Enum.EasingStyle.Back,  Enum.EasingDirection.Out)
local function T_LIN(s) return TweenInfo.new(s, Enum.EasingStyle.Linear) end

-- ─────────────────────────────────────────────────────────
--  Stack helpers
-- ─────────────────────────────────────────────────────────
local active = {}   -- list of active notification entries

local function getEdgePad() return 18 end
local function getGap()     return 8  end

local function reflow()
    local edgePad = getEdgePad()
    local gap     = getGap()
    local slot    = 0

    for i = #active, 1, -1 do
        local e = active[i]
        if not e.dismissed then
            local yOff = isBottom
                and -(edgePad + slot * (e.cardH + gap) + e.cardH)
                or   edgePad  + slot * (e.cardH + gap)
            tw(e.frame, T_OUT, {
                Position = UDim2.new(
                    isLeft and 0 or 1,
                    isLeft and edgePad or -(e.cardW + edgePad),
                    isBottom and 1 or 0,
                    yOff
                )
            })
            slot += 1
        end
    end
end

-- ─────────────────────────────────────────────────────────
--  Dismiss  (THE FIX: uses pcall guard + guaranteed destroy)
-- ─────────────────────────────────────────────────────────
local function dismiss(entry)
    if entry.dismissed then return end
    entry.dismissed = true

    -- Cancel all running threads immediately
    pcall(function() if entry.autoThread  then task.cancel(entry.autoThread)  end end)
    pcall(function() if entry.countThread then task.cancel(entry.countThread) end end)

    local curPos = entry.frame.Position
    local slideX = isLeft
        and (curPos.X.Offset - entry.cardW - 60)
        or  (curPos.X.Offset + entry.cardW + 60)

    -- Slide out
    tw(entry.frame, T_IN, {
        Position = UDim2.new(curPos.X.Scale, slideX, curPos.Y.Scale, curPos.Y.Offset),
        BackgroundTransparency = 1,
    })

    -- Fade children
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

    -- Stop sound if playing
    pcall(function()
        if entry.sound then
            entry.sound:Stop()
            entry.sound:Destroy()
        end
    end)

    -- Destroy card after slide animation
    -- Uses BOTH delay and a fallback to guarantee removal
    local destroyed = false
    local function destroy()
        if destroyed then return end
        destroyed = true
        pcall(function() entry.frame:Destroy() end)
        for i = #active, 1, -1 do
            if active[i] == entry then table.remove(active, i) break end
        end
        reflow()
    end

    task.delay(0.22, destroy)

    -- Hard fallback: if still alive after 0.5s, force destroy
    task.delay(0.5, destroy)
end

-- ─────────────────────────────────────────────────────────
--  Image / Sound ID resolver
-- ─────────────────────────────────────────────────────────
local function resolveAsset(raw)
    if not raw or raw == "" then return nil end
    raw = tostring(raw):match("^%s*(.-)%s*$")
    if raw == "" then return nil end
    if raw:lower():find("^rbxassetid://") then return raw end
    if raw:match("^%d+$") then return "rbxassetid://" .. raw end
    if raw:lower():find("^https?://") then return raw end
    return raw
end

-- ─────────────────────────────────────────────────────────
--  NOTIFY  — the main function
-- ─────────────────────────────────────────────────────────
local function Notify(cfg)

    -- Support legacy string call: Notify("msg", "type", seconds)
    if type(cfg) ~= "table" then
        cfg = {
            Description = tostring(cfg   or ""),
            Type        = tostring(select(1, ...) or "info"),
            Time        = tonumber(select(2, ...)) or CFG.DefaultTime,
        }
    end

    -- ── Parse notification config ──────────────────────────────
    local title       = tostring(cfg.Title       or "")
    local description = tostring(cfg.Description or "")
    local notifType   = tostring(cfg.Type        or "info"):lower()
    local duration    = tonumber(cfg.Time)        or CFG.DefaultTime
    local imageId     = resolveAsset(cfg.Image)
    local soundId     = resolveAsset(cfg.Sound)

    -- Size: cfg.Size = {width, height}  e.g. {320, 80}
    -- or just a number for width, height stays auto
    local customW, customH
    if type(cfg.Size) == "table" then
        customW = tonumber(cfg.Size[1])
        customH = tonumber(cfg.Size[2])
    elseif type(cfg.Size) == "number" then
        customW = cfg.Size
    end

    -- Validate
    if not STYLES[notifType] then notifType = "info" end
    duration = math.clamp(duration, 1, 60)

    local S      = STYLES[notifType]
    local hasImg = imageId ~= nil

    -- Sizing
    local edgePad = getEdgePad()
    local cardW   = customW or 310
    local imgSize = 52
    local minH    = customH or (hasImg and 90 or 74)
    local cardH   = minH
    local leftX   = hasImg and (imgSize + 16) or 46

    -- Cull oldest if at limit
    if #active >= CFG.MaxVisible then
        dismiss(active[1])
        task.wait(0.05)
    end

    -- ── Card frame ────────────────────────────────────────────
    local card = Instance.new("Frame")
    card.Name                   = "NotifCard"
    card.Size                   = UDim2.new(0, cardW, 0, cardH)
    card.BackgroundColor3       = Color3.fromRGB(14, 16, 22)
    card.BackgroundTransparency = 0
    card.BorderSizePixel        = 0
    card.ClipsDescendants       = false
    card.ZIndex                 = 100
    card.Parent                 = Container

    -- Start off screen
    local startX = isLeft
        and -(edgePad + cardW + 60)
        or  (1 * Screen.AbsoluteSize.X + 60)  -- will be corrected by reflow
    card.Position = UDim2.new(
        isLeft and 0 or 1,
        isLeft and -(cardW + 60) or (cardW + 60),
        isBottom and 1 or 0,
        isBottom and -(edgePad + cardH) or edgePad
    )

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
    strip.BackgroundColor3 = S.accent
    strip.BackgroundTransparency = 0
    strip.BorderSizePixel  = 0
    strip.ZIndex           = 101
    strip.Parent           = card
    Instance.new("UICorner", strip).CornerRadius = UDim.new(0, 3)

    -- ── Image or Icon ─────────────────────────────────────────
    if hasImg then
        local imgFrame = Instance.new("Frame")
        imgFrame.Size             = UDim2.new(0, imgSize, 0, imgSize)
        imgFrame.Position         = UDim2.new(0, 7, 0.5, -imgSize / 2)
        imgFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 40)
        imgFrame.BackgroundTransparency = 0
        imgFrame.BorderSizePixel  = 0
        imgFrame.ZIndex           = 101
        imgFrame.Parent           = card
        Instance.new("UICorner", imgFrame).CornerRadius = UDim.new(0, 8)

        local imgLbl = Instance.new("ImageLabel")
        imgLbl.Size                   = UDim2.new(1, 0, 1, 0)
        imgLbl.BackgroundTransparency = 1
        imgLbl.Image                  = imageId
        imgLbl.ScaleType              = Enum.ScaleType.Crop
        imgLbl.ImageTransparency      = 0
        imgLbl.ZIndex                 = 102
        imgLbl.Parent                 = imgFrame
        Instance.new("UICorner", imgLbl).CornerRadius = UDim.new(0, 8)
    else
        local iconFrame = Instance.new("Frame")
        iconFrame.Size             = UDim2.new(0, 28, 0, 28)
        iconFrame.Position         = UDim2.new(0, 9, 0, 11)
        iconFrame.BackgroundColor3 = S.iconBg
        iconFrame.BackgroundTransparency = 0
        iconFrame.BorderSizePixel  = 0
        iconFrame.ZIndex           = 101
        iconFrame.Parent           = card
        Instance.new("UICorner", iconFrame).CornerRadius = UDim.new(0, 7)

        local iconLbl = Instance.new("TextLabel")
        iconLbl.Size                  = UDim2.new(1, 0, 1, 0)
        iconLbl.BackgroundTransparency= 1
        iconLbl.Text                  = S.icon
        iconLbl.TextColor3            = S.accent
        iconLbl.TextTransparency      = 0
        iconLbl.Font                  = Enum.Font.GothamBold
        iconLbl.TextSize              = 13
        iconLbl.ZIndex                = 102
        iconLbl.Parent                = iconFrame
    end

    -- ── Badge ─────────────────────────────────────────────────
    local badge = Instance.new("TextLabel")
    badge.Size                  = UDim2.new(0, cardW - leftX - (CFG.TimerMode == 1 and 50 or 28), 0, 14)
    badge.Position              = UDim2.new(0, leftX, 0, 8)
    badge.BackgroundTransparency= 1
    badge.Text                  = S.label
    badge.TextColor3            = S.accent
    badge.TextTransparency      = 0
    badge.Font                  = Enum.Font.GothamBold
    badge.TextSize              = 9
    badge.TextXAlignment        = Enum.TextXAlignment.Left
    badge.ZIndex                = 101
    badge.Parent                = card

    -- ── Timer: Mode 1 = countdown number ──────────────────────
    local countdownLbl = nil
    if CFG.TimerMode == 1 then
        countdownLbl = Instance.new("TextLabel")
        countdownLbl.Name                  = "Countdown"
        countdownLbl.Size                  = UDim2.new(0, 42, 0, 14)
        countdownLbl.Position              = UDim2.new(1, -46, 1, -18)
        countdownLbl.BackgroundTransparency= 1
        countdownLbl.Text                  = tostring(duration) .. "s"
        countdownLbl.TextColor3            = Color3.fromRGB(55, 55, 66)
        countdownLbl.TextTransparency      = 0
        countdownLbl.Font                  = Enum.Font.GothamBold
        countdownLbl.TextSize              = 11
        countdownLbl.TextXAlignment        = Enum.TextXAlignment.Right
        countdownLbl.ZIndex                = 103
        countdownLbl.Parent                = card
    end

    -- ── Timer: Mode 2 = progress bar ──────────────────────────
    local barFill = nil
    if CFG.TimerMode == 2 then
        local barBg = Instance.new("Frame")
        barBg.Size             = UDim2.new(1, 0, 0, 3)
        barBg.Position         = UDim2.new(0, 0, 1, -3)
        barBg.BackgroundColor3 = Color3.fromRGB(20, 22, 34)
        barBg.BackgroundTransparency = 0
        barBg.BorderSizePixel  = 0
        barBg.ClipsDescendants = true
        barBg.ZIndex           = 101
        barBg.Parent           = card

        barFill = Instance.new("Frame")
        barFill.Name             = "BarFill"
        barFill.Size             = UDim2.new(1, 0, 1, 0)
        barFill.BackgroundColor3 = S.accent
        barFill.BackgroundTransparency = 0
        barFill.BorderSizePixel  = 0
        barFill.ZIndex           = 102
        barFill.Parent           = barBg
        Instance.new("UICorner", barFill).CornerRadius = UDim.new(0, 2)
    end

    -- ── Title ─────────────────────────────────────────────────
    local textY = 22
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
    local bottomPad = CFG.TimerMode == 1 and 18 or 10
    if description ~= "" then
        local descLbl = Instance.new("TextLabel")
        descLbl.Size                  = UDim2.new(0, cardW - leftX - 26, 0, cardH - textY - bottomPad)
        descLbl.Position              = UDim2.new(0, leftX, 0, textY)
        descLbl.BackgroundTransparency= 1
        descLbl.Text                  = description
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
    closeBtn.Name                  = "Close"
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

    -- ── Shimmer flash on entry ────────────────────────────────
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
    if soundId then
        pcall(function()
            soundObj = Instance.new("Sound")
            soundObj.SoundId    = soundId
            soundObj.Volume     = 0.5
            soundObj.RollOffMode = Enum.RollOffMode.InverseTapered
            soundObj.Parent     = SoundService
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
    reflow()

    -- ── Slide in ──────────────────────────────────────────────
    task.delay(0.03, function()
        if entry.dismissed then return end
        local p = card.Position
        -- reset X to off-screen, then spring to correct position
        card.Position = UDim2.new(
            p.X.Scale,
            isLeft and -(cardW + 60) or (cardW + 60),
            p.Y.Scale,
            p.Y.Offset
        )
        tw(card, T_SPRING, {
            Position = UDim2.new(
                isLeft and 0 or 1,
                isLeft and edgePad or -(cardW + edgePad),
                p.Y.Scale,
                p.Y.Offset
            )
        })
    end)

    -- Shimmer sweep
    task.delay(0.15, function()
        if entry.dismissed then return end
        tw(shimmer, TweenInfo.new(0.65, Enum.EasingStyle.Sine),
            { Position = UDim2.new(1.1, 0, 0, 0) })
    end)

    -- ── Mode 1: countdown tick ────────────────────────────────
    if CFG.TimerMode == 1 and countdownLbl then
        entry.countThread = task.spawn(function()
            local remaining = duration
            while remaining > 0 and not entry.dismissed do
                countdownLbl.Text = tostring(remaining) .. "s"
                local pct  = remaining / duration
                local gray = math.floor(48 + pct * 18)
                countdownLbl.TextColor3 = Color3.fromRGB(gray, gray, gray + 10)
                task.wait(1)
                remaining -= 1
            end
            if not entry.dismissed then
                countdownLbl.Text = "0s"
            end
        end)
    end

    -- ── Mode 2: bar drain tween ───────────────────────────────
    if CFG.TimerMode == 2 and barFill then
        tw(barFill, T_LIN(duration), { Size = UDim2.new(0, 0, 1, 0) })
    end

    -- ── Hover ─────────────────────────────────────────────────
    card.MouseEnter:Connect(function()
        tw(stroke,   TweenInfo.new(0.15), { Color = S.accent, Transparency = 0.08 })
        tw(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(205, 208, 228) })
    end)
    card.MouseLeave:Connect(function()
        tw(stroke,   TweenInfo.new(0.15), { Color = Color3.fromRGB(42,46,62), Transparency = 0.15 })
        tw(closeBtn, TweenInfo.new(0.15), { TextColor3 = Color3.fromRGB(60,64,86) })
    end)

    closeBtn.MouseButton1Click:Connect(function() dismiss(entry) end)

    -- ── AUTO-DISMISS  (THE BUG FIX) ───────────────────────────
    -- Uses task.delay which is frame-accurate.
    -- A second hard-kill fires at duration + 0.5s as guarantee.
    entry.autoThread = task.delay(duration, function()
        dismiss(entry)
    end)

    -- Hard fallback: force destroy even if dismiss somehow fails
    task.delay(duration + 0.6, function()
        if not entry.dismissed then
            entry.dismissed = true
            pcall(function() entry.frame:Destroy() end)
            pcall(function() if entry.sound then entry.sound:Destroy() end end)
            for i = #active, 1, -1 do
                if active[i] == entry then table.remove(active, i) break end
            end
            reflow()
        end
    end)
end

-- ─────────────────────────────────────────────────────────
--  Expose globally
--  _G.Notify       → standard Roblox LocalScripts
--  getgenv().Notify → executor environments (Synapse, SW…)
-- ─────────────────────────────────────────────────────────
_G.Notify = Notify
pcall(function() getgenv().Notify = Notify end)

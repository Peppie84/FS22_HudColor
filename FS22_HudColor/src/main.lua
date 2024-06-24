---
-- COLOR_HUD
--
-- Main class for activating the vanilla temperature information box
-- and changed the information text elements.
--
-- Copyright (c) Peppie84, 2024
--
---@type string directory of the mod.
local modDirectory = g_currentModDirectory or ''
---@type string name of the mod.
local modName = g_currentModName or 'unknown'

COLOR_PRESETS = {
    [1] = {
        -- default
        R = 0.0003,
        G = 0.5647,
        B = 0.9822,
    },
    [2] = {
        -- pink
        R = 1,
        G = 0.561,
        B = 1,
    },
    [3] = {
        -- orange
        R = 1,
        G = 0.369,
        B = 0,
    },
    [4] = {
        -- red
        R = 0.741,
        G = 0.050,
        B = 0.050,
    },
    [5] = {
        -- gray
        R = 0.3,
        G = 0.3,
        B = 0.3,
    },
    [6] = {
        -- green
        R = 0.528,
        G = 1,
        B = 0.075,
    }
}

HudColor = {}

---Event from addModEventListener after loading the map
function HudColor:setPresetColor(colorPresetNum)
    HUD_COLOR = COLOR_PRESETS[colorPresetNum]
    HUD_COLOR = {
        V3 = {
            COLOR = {
                HUD_COLOR.R,
                HUD_COLOR.G,
                HUD_COLOR.B
            },
        },
        V4 = {
            COLOR_100 = {
                HUD_COLOR.R,
                HUD_COLOR.G,
                HUD_COLOR.B,
                1
            },
            COLOR_80 = {
                HUD_COLOR.R,
                HUD_COLOR.G,
                HUD_COLOR.B,
                0.8
            },
            COLOR_40 = {
                HUD_COLOR.R,
                HUD_COLOR.G,
                HUD_COLOR.B,
                0.4
            },
            COLOR_25 = {
                HUD_COLOR.R,
                HUD_COLOR.G,
                HUD_COLOR.B,
                0.25
            }
        }
    }
    GameInfoDisplay.COLOR.ICON = HUD_COLOR.V4.COLOR_100
    GameInfoDisplay.COLOR.CLOCK_HAND_LARGE = HUD_COLOR.V4.COLOR_100
    GameInfoDisplay.COLOR.CLOCK_HAND_SMALL = HUD_COLOR.V4.COLOR_100
    InputHelpDisplay.COLOR.INPUT_GLYPH = HUD_COLOR.V4.COLOR_100
    IngameMap.COLOR.INPUT_ICON = HUD_COLOR.V4.COLOR_80
    SpeedMeterDisplay.COLOR.SPEED_TEXT = HUD_COLOR.V4.COLOR_100
    SpeedMeterDisplay.COLOR.SPEED_UNIT = HUD_COLOR.V4.COLOR_100
    SpeedMeterDisplay.COLOR.GEAR_TEXT = HUD_COLOR.V4.COLOR_100
    SpeedMeterDisplay.COLOR.CRUISE_CONTROL_ON = HUD_COLOR.V4.COLOR_100
    SpeedMeterDisplay.COLOR.GEAR_ICON = HUD_COLOR.V4.COLOR_100
    SpeedMeterDisplay.COLOR.GEAR_SELECTOR = HUD_COLOR.V4.COLOR_40
    VehicleSchemaDisplay.COLOR.TURNED_ON = HUD_COLOR.V3.COLOR
    FillLevelsDisplay.COLOR.BAR_FILLED = HUD_COLOR.V3.COLOR
    ContextActionDisplay.COLOR.INPUT_ICON = HUD_COLOR.V4.COLOR_100
    ContextActionDisplay.COLOR.CONTEXT_ICON = HUD_COLOR.V4.COLOR_100
    ContextActionDisplay.COLOR.ACTION_TEXT = HUD_COLOR.V4.COLOR_100
    HUD.COLOR.TUTORIAL_STATUS_BACKGROUND = HUD_COLOR.V4.COLOR_100
    HUD.COLOR.RADIO_STREAM = HUD_COLOR.V4.COLOR_100
    TopNotification.COLOR.TEXT_TITLE = HUD_COLOR.V4.COLOR_100
    TopNotification.COLOR.ICON = HUD_COLOR.V4.COLOR_100
    KeyValueInfoHUDBox.COLOR.TEXT_HIGHLIGHT = HUD_COLOR.V4.COLOR_100
    AchievementMessage.COLOR.TITLE_TEXT = HUD_COLOR.V4.COLOR_100
    VariableWorkWidthHUDExtension.COLOR.SECTION_ACTIVE = HUD_COLOR.V4.COLOR_100
    VariableWorkWidthHUDExtension.COLOR.SECTION_INACTIVE = HUD_COLOR.V4.COLOR_25
end

g_hudColor = HudColor

source(modDirectory .. 'src/hudcolorgui.lua')

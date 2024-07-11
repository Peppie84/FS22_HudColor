---
-- ColorHudGui
--
-- Class to handle the new ui controls on the settings frame
-- to control the color for the hud and saves the
-- value in the modSettings-folder.
--
-- Copyright (c) Peppie84, 2024
-- https://github.com/Peppie84/FS22_HudColor
--
HudColorGui = {
    MOD_DIRECTORY = g_currentModDirectory,
    MOD_SETTINGS_DIRECTORY = getUserProfileAppPath() .. 'modSettings/',
    MOD_SETTINGS_FILENAME = 'hudcolor.xml',
    MOD_SETTINGS_XML_ROOT_NODE = 'settings',
    CURRENT_MOD = g_currentModName or 'unknown',
    L10N_SYMBOLS = {
        MOD_TITLE = 'mod_title',
        HUD_COLOR_SETTING_LABEL = 'settings_hud_color_label',
        HUD_COLOR_SETTING_RESTART = 'settings_hud_color_label_needs_restart',
        HUD_COLOR_SETTING_DESCRIPTION = 'settings_hud_color_description',
        EASYARMCONTROL_COLOR_OPTION1 = 'settings_hud_color_option1',
        EASYARMCONTROL_COLOR_OPTION2 = 'settings_hud_color_option2',
        EASYARMCONTROL_COLOR_OPTION3 = 'settings_hud_color_option3',
        EASYARMCONTROL_COLOR_OPTION4 = 'settings_hud_color_option4',
        EASYARMCONTROL_COLOR_OPTION5 = 'settings_hud_color_option5',
        EASYARMCONTROL_COLOR_OPTION6 = 'settings_hud_color_option6',
    },
    ENUM_EASYARMCONTROL_INDEX = {
        LABEL = 4,
        DESCRIPTION = 6,
    },
    ENUM_COLORS = {
        DEFAULT = 1,
        PINK = 2,
        ORANGE = 3,
        RED = 4,
        GRAY = 5,
        GREEN = 6,
    },
}

HudColorGui.settings = {}
HudColorGui.settings.colorPreset = 1

---Append to InGameMenuGeneralSettingsFrame.onFrameOpen
---Initialize our gui elements for the settings frame that we need.
function HudColorGui:initGui()
    if not self.initHudColorGuiDone then
        local title = TextElement.new()
        local hudcolorSettingTitleText = g_i18n:getText(HudColorGui.L10N_SYMBOLS.MOD_TITLE, HudColorGui.CURRENT_MOD)
        local hudColorSettingLabelText = g_i18n:getText(HudColorGui.L10N_SYMBOLS.HUD_COLOR_SETTING_LABEL, HudColorGui.CURRENT_MOD)
        local hudColorSettingDescriptionText = g_i18n:getText(HudColorGui.L10N_SYMBOLS.HUD_COLOR_SETTING_DESCRIPTION, HudColorGui.CURRENT_MOD)

        local hudColorSettingOption1Text = g_i18n:getText(HudColorGui.L10N_SYMBOLS.EASYARMCONTROL_COLOR_OPTION1, HudColorGui.CURRENT_MOD)
        local hudColorSettingOption2Text = g_i18n:getText(HudColorGui.L10N_SYMBOLS.EASYARMCONTROL_COLOR_OPTION2, HudColorGui.CURRENT_MOD)
        local hudColorSettingOption3Text = g_i18n:getText(HudColorGui.L10N_SYMBOLS.EASYARMCONTROL_COLOR_OPTION3, HudColorGui.CURRENT_MOD)
        local hudColorSettingOption4Text = g_i18n:getText(HudColorGui.L10N_SYMBOLS.EASYARMCONTROL_COLOR_OPTION4, HudColorGui.CURRENT_MOD)
        local hudColorSettingOption5Text = g_i18n:getText(HudColorGui.L10N_SYMBOLS.EASYARMCONTROL_COLOR_OPTION5, HudColorGui.CURRENT_MOD)
        local hudColorSettingOption6Text = g_i18n:getText(HudColorGui.L10N_SYMBOLS.EASYARMCONTROL_COLOR_OPTION6, HudColorGui.CURRENT_MOD)

        self.HudColor = self.checkUseEasyArmControl:clone()
        self.HudColor.target = HudColorGui
        self.HudColor.id = 'HudColor'
        self.HudColor:setCallback('onClickCallback', 'onHudColorChanged')
        self.HudColor:setTexts({hudColorSettingOption1Text, hudColorSettingOption2Text, hudColorSettingOption3Text, hudColorSettingOption4Text, hudColorSettingOption5Text, hudColorSettingOption6Text})
        self.HudColor.elements[HudColorGui.ENUM_EASYARMCONTROL_INDEX.LABEL]:setText(hudColorSettingLabelText)
        self.HudColor.elements[HudColorGui.ENUM_EASYARMCONTROL_INDEX.DESCRIPTION]:setText(hudColorSettingDescriptionText)

        g_hudColor.HudColorElement = self.HudColor

        title:applyProfile('settingsMenuSubtitle', true)
        title:setText(hudcolorSettingTitleText)

        self.boxLayout:addElement(title)
        self.boxLayout:addElement(self.HudColor)

        self.initHudColorGuiDone = true
    end

    self.HudColor:setState(HudColorGui.settings.colorPreset)
end

---Callback function for our gui element by on change
---@param state number
function HudColorGui:onHudColorChanged(state)
    local hudColorSettingLabelText = g_i18n:getText(HudColorGui.L10N_SYMBOLS.HUD_COLOR_SETTING_LABEL, HudColorGui.CURRENT_MOD)
    local hudColorSettingLabelTextRestart = g_i18n:getText(HudColorGui.L10N_SYMBOLS.HUD_COLOR_SETTING_RESTART, HudColorGui.CURRENT_MOD)
    HudColorGui.settings.colorPreset = state

    if HudColorGui.settings.colorPreset ~= HudColorGui.settings.loadedColorPreset then
        g_hudColor.HudColorElement.elements[HudColorGui.ENUM_EASYARMCONTROL_INDEX.LABEL]:setText(hudColorSettingLabelText ..' '.. hudColorSettingLabelTextRestart )
    else
        g_hudColor.HudColorElement.elements[HudColorGui.ENUM_EASYARMCONTROL_INDEX.LABEL]:setText(hudColorSettingLabelText)
    end

	HudColorGui:saveSettings()
end

---Appand to and InGameMenuGeneralSettingsFrame.updateGameSettings()
---Just udpate the gui
function HudColorGui:updateGui()
    if self.initHudColorGuiDone and self.HudColor ~= nil then
        self.HudColor:setState(HudColorGui.settings.colorPreset)
    end
end

---Save the settings into its own xml under modSettings/ path
function HudColorGui:saveSettings()
	local filename = HudColorGui.MOD_SETTINGS_DIRECTORY .. HudColorGui.MOD_SETTINGS_FILENAME
	local xmlRootNode = HudColorGui.MOD_SETTINGS_XML_ROOT_NODE
	local xmlFile = XMLFile.create("settingsXML", filename, xmlRootNode)

	if xmlFile ~= nil then
		xmlFile:setInt(xmlRootNode .. ".colorPreset", self.settings.colorPreset)

		xmlFile:save()
		xmlFile:delete()
	end
end

---Load the settings xml from modSettings/
function HudColorGui:loadSettings()
    local filename = HudColorGui.MOD_SETTINGS_DIRECTORY .. HudColorGui.MOD_SETTINGS_FILENAME
	local xmlRootNode = HudColorGui.MOD_SETTINGS_XML_ROOT_NODE
	local xmlFile = XMLFile.loadIfExists("settingsXML", filename, xmlRootNode)

	if xmlFile ~= nil then
		HudColorGui.settings.colorPreset = Utils.getNoNil(xmlFile:getInt(xmlRootNode .. ".colorPreset"), HudColorGui.ENUM_COLORS.DEFAULT)
        HudColorGui.settings.loadedColorPreset = HudColorGui.settings.colorPreset
        g_hudColor:setPresetColor(HudColorGui.settings.colorPreset)
        self:updateGui()

		xmlFile:delete()
	end
end

---Init
local function init()
    HudColorGui:loadSettings()
    InGameMenuGeneralSettingsFrame.onFrameOpen = Utils.appendedFunction(InGameMenuGeneralSettingsFrame.onFrameOpen, HudColorGui.initGui)
    InGameMenuGeneralSettingsFrame.updateGameSettings = Utils.appendedFunction(InGameMenuGeneralSettingsFrame.updateGameSettings, HudColorGui.updateGui)
end

init()

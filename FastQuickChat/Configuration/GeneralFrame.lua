-- Erstelle das Hauptkonfigurations-Frame
local frame = CreateFrame("Frame", "FastQuickChat_GenCfgFrame", UIParent)
frame.name = "General"
frame.parent = "FastQuickChat" -- Die Kategorie der Hauptkonfiguration als Parent verwenden
frame:SetSize(400, 300)  -- Optional: Setze die Größe des Frames

-- Die OnAddonLoaded-Funktion wird aufgerufen, wenn das Addon geladen wird
function frame:OnAddonLoaded()
    local l = FastQuickChat_GetLocalization()
    
    -- Titel erstellen
    local title = frame:CreateFontString("FastQuickChat_GenCfgFrame_Title", "OVERLAY", "GameFontHighlightLarge")
    title:SetPoint("TOP", frame, "TOP", 0, -10)
    title:SetText(l["GENERALTITLE"])

    -- Informationstext erstellen
    local info = frame:CreateFontString("FastQuickChat_GenCfgFrame_Info", "OVERLAY", "GameFontHighlight")
    info:SetPoint("TOP", frame, "TOP", 0, -40)
    info:SetText(l["GENERALINFO"])

    -- Zusätzlichen Informationstext erstellen
    local info1 = frame:CreateFontString("FastQuickChat_GenCfgFrame_Info1", "OVERLAY", "GameFontHighlightLarge")
    info1:SetPoint("BOTTOM", frame, "BOTTOM", 0, 10)
    info1:SetText(l["AfterReload"])

    -- CheckButton erstellen
    self:CreateCheckButton("LockFramePosition", l["LockFramePosition"], FQC_Settings.lockFramePosition, function(checked)
        FQC_Settings.lockFramePosition = checked
    end)
end

-- Methode zum Erstellen eines CheckButtons
function frame:CreateCheckButton(name, text, checked, onCheckedChanged)
    local checkButton = CreateFrame("CheckButton", name, frame, "InterfaceOptionsCheckButtonTemplate")
    checkButton:SetPoint("TOPLEFT", 16, -16)
    checkButton.Text:SetText(text)
    checkButton:SetChecked(checked)
    checkButton:SetScript("OnClick", function(self)
        onCheckedChanged(self:GetChecked())
    end)
end

-- Funktion zum Hinzufügen des Panels zu den Interface-Optionen
local function AddOptionsPanel()
    -- Verwende die neuen Methoden zum Hinzufügen des Panels
    local category = Settings.RegisterCanvasLayoutCategory(frame, "FastQuickChat")
    Settings.RegisterAddOnCategory(category)
end

-- Registriere das Optionspanel
AddOptionsPanel()

FastQuickChat.generalConfigurationFrame = frame

-- Registriere Events und initialisiere das Addon
frame:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" and (...) == "FastQuickChat" then
        self:OnAddonLoaded()
    end
end)

frame:RegisterEvent("ADDON_LOADED")

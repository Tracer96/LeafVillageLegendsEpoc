-- LeafVE_ProfilePanel.lua

-- Profile Panel Redesign for WoW Client 3.3.5
-- This file implements a comprehensive profile panel with modern UI elements.

local function CreateMainWindow()
    local frame = CreateFrame("Frame", "ProfilePanel", UIParent)
    frame:SetSize(400, 600)
    frame:SetPoint("CENTER")
    frame:SetBackdrop({bgFile = "Interface\DialogFrame\UI-DialogBox-Background",
                       edgeFile = "Interface\DialogFrame\UI-DialogBox-Border",
                       tile = true, tileSize = 32, edgeSize = 32,
                       insets = {left = 11, right = 12, top = 12, bottom = 11}})
    frame:Show()
    return frame
end

local function CreateNavigationTabs(parent)
    local tabContainer = CreateFrame("Frame", nil, parent)
    tabContainer:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -10)
    tabContainer:SetSize(380, 30)

    local tabs = {} 
    local tabNames = {"Profile", "Stats", "Settings"}
    for i, name in ipairs(tabNames) do
        local tab = CreateFrame("Button", nil, tabContainer)
        tab:SetText(name)
        tab:SetSize(120, 30)
        tab:SetPoint("LEFT", (i - 1) * 130, 0)
        tab:SetNormalFontObject("GameFontNormal")
        tab:SetHighlightFontObject("GameFontHighlight")
        tab:SetScript("OnClick", function() SwitchTab(i) end)
        tabs[i] = tab
    end
    return tabs
end

local function CreateStatsPanel(parent)
    local statsPanel = CreateFrame("Frame", nil, parent)
    statsPanel:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -50)
    statsPanel:SetSize(380, 500)
    statsPanel:Show()

    -- Displaying stats
    local statsData = {"Health: 1000", "Mana: 500", "Level: 10"}
    for i, stat in ipairs(statsData) do
        local statLabel = statsPanel:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        statLabel:SetText(stat)
        statLabel:SetPoint("TOPLEFT", statsPanel, "TOPLEFT", 10, -30 * (i - 1))
    end

    return statsPanel
end

local function CreatePlayerCard(parent)
    local playerCard = CreateFrame("Frame", nil, parent)
    playerCard:SetPoint("TOPLEFT", parent, "TOPLEFT", 10, -30)
    playerCard:SetSize(380, 100)
    playerCard:Show()

    local nameLabel = playerCard:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    nameLabel:SetText("Player Name: PlayerOne")
    nameLabel:SetPoint("TOPLEFT", playerCard, "TOPLEFT", 10, -10)

    return playerCard
end

local function SwitchTab(tabIndex)
    -- Logic for switching between tabs
    print("Switched to tab: " .. tabIndex)
end

-- Main Execution
local mainFrame = CreateMainWindow()
local navigationTabs = CreateNavigationTabs(mainFrame)
local statsPanel = CreateStatsPanel(mainFrame)
local playerCard = CreatePlayerCard(mainFrame)

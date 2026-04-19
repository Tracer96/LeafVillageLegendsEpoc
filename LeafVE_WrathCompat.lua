LeafVE_Wrath = LeafVE_Wrath or {}

LeafVE_Wrath.interface = 30300
LeafVE_Wrath.clientLabel = "Wrath 3.3.5"

function LeafVE_Wrath:GetNumTalentGroups()
  if type(GetNumTalentGroups) == "function" then
    local count = tonumber(GetNumTalentGroups()) or 1
    if count < 1 then count = 1 end
    return count
  end
  return 1
end

function LeafVE_Wrath:GetActiveTalentGroup()
  if type(GetActiveTalentGroup) == "function" then
    local groupIndex = tonumber(GetActiveTalentGroup()) or 1
    if groupIndex < 1 then groupIndex = 1 end
    return groupIndex
  end
  return 1
end

function LeafVE_Wrath:GetTalentTabInfo(tabIndex, talentGroup)
  if type(GetTalentTabInfo) ~= "function" then
    return nil
  end

  if talentGroup and type(GetNumTalentGroups) == "function" then
    local name, icon, pointsSpent = GetTalentTabInfo(tabIndex, false, false, talentGroup)
    if name or icon or pointsSpent then
      return name, icon, pointsSpent
    end
  end

  return GetTalentTabInfo(tabIndex)
end

function LeafVE_Wrath:GetTalentInfo(tabIndex, talentIndex, talentGroup)
  if type(GetTalentInfo) ~= "function" then
    return nil
  end

  if talentGroup and type(GetNumTalentGroups) == "function" then
    local name, icon, tier, column, rank, maxRank = GetTalentInfo(tabIndex, talentIndex, false, false, talentGroup)
    if name or icon or tier or column or rank or maxRank then
      return name, icon, tier, column, rank, maxRank
    end
  end

  return GetTalentInfo(tabIndex, talentIndex)
end

function LeafVE_Wrath:CanUseDualSpec()
  return self:GetNumTalentGroups() > 1 and type(SetActiveTalentGroup) == "function"
end

function LeafVE_Wrath:SwitchToTalentGroup(targetGroup)
  if not self:CanUseDualSpec() then
    return false, "Dual spec is not available for this character."
  end

  local desiredGroup = tonumber(targetGroup) or self:GetActiveTalentGroup()
  if desiredGroup < 1 then desiredGroup = 1 end
  if desiredGroup > self:GetNumTalentGroups() then
    desiredGroup = self:GetNumTalentGroups()
  end

  if desiredGroup == self:GetActiveTalentGroup() then
    return true
  end

  if type(InCombatLockdown) == "function" and InCombatLockdown() then
    return false, "You cannot swap specs while in combat."
  end

  local ok, err = pcall(SetActiveTalentGroup, desiredGroup)
  if not ok then
    return false, tostring(err or "Unable to activate that talent group.")
  end

  return true
end

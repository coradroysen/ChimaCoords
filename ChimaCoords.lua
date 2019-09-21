local zone = nil
local TimeSinceLastUpdate = 0

local function ChimaCoords_UpdateCoordinates(self, elapsed)
  TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed

  if TimeSinceLastUpdate > .05 then
    TimeSinceLastUpdate = 0

    local instanceID = select(8, GetInstanceInfo())


    if instanceID == 0 or instanceID == 1 then
      if zone ~= GetRealZoneText() then
        local mapID = C_Map.GetBestMapForUnit("player")
        WorldMapFrame:SetMapID(mapID)
        zone = GetRealZoneText()
      end

      local map = C_Map.GetBestMapForUnit("player");

      local playerPosition = C_Map.GetPlayerMapPosition(map, "player");
  	  local playerX = math.floor(playerPosition.x * 100);
      local playerY = math.floor(playerPosition.y * 100);

      if WorldMapFrame:IsShown() then
      	if WorldMapFrame.ScrollContainer:IsMouseOver() then
          local cursorPositionX, cursorPositionY = WorldMapFrame.ScrollContainer:GetNormalizedCursorPosition()
      	  local cursorX = math.floor(cursorPositionX * 100);
          local cursorY = math.floor(cursorPositionY * 100);
          coordsTextWM:SetText(GetUnitName("player", false) .. ": " .. playerX .. ", " .. playerY .. "     Cursor: " .. cursorX .. ", " .. cursorY)
        end
      end

      coordsTextMM:SetText(playerX .. ", " .. playerY)
    else
      coordsTextMM:SetText("")
      coordsTextWM:SetText("")
    end
  end
end



function ChimaCoords_OnLoad(self, event, ...)
  self:RegisterEvent("ADDON_LOADED")
end

function ChimaCoords_OnEvent(self, event, ...)
   if event == "ADDON_LOADED" and ... == "ChimaCoords" then
      self:UnregisterEvent("ADDON_LOADED")

  	  coordsFrame:SetScript("OnUpdate", ChimaCoords_UpdateCoordinates)

      Minimap:CreateFontString("coordsTextMM", "ARTWORK", nil)
      coordsTextMM:SetPoint("BOTTOM", "Minimap", "BOTTOM", 1, 12)
      coordsTextMM:SetFont("Fonts\\FRIZQT__.TTF", 10, "THICKOUTLINE")
      coordsTextMM:SetText("")
      coordsTextMM:Show()

      WorldMapFrame.BorderFrame:CreateFontString("coordsTextWM", "ARTWORK", nil)
      coordsTextWM:SetPoint("BOTTOM", 0, 11)
      coordsTextWM:SetFont("Fonts\\FRIZQT__.TTF", 10)
      coordsTextWM:SetText("")
      coordsTextWM:Show()
	end
end

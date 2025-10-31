-----------------------------------
-- Area: Wajaom Woodlands
--  NPC: Pephredo Hive
-----------------------------------
---@type TNpcEntity
local entity = {}
local ID = zones[xi.zone.WAJAOM_WOODLANDS]

entity.onTrigger = function(player, npc)
    local tasteOfHoneyQuestStatus = player:getQuestStatus(xi.questLog.AHT_URHGAN, xi.quest.id.ahtUrhgan.A_TASTE_OF_HONEY)
    local oncePerDayVarName = '[HoneyReceived]HiveID:' .. npc:getID()
    local hasNotReceivedHoneyToday = player:getVar(oncePerDayVarName) ~= 1

    if (tasteOfHoneyQuestStatus == xi.questStatus.QUEST_ACCEPTED or
            tasteOfHoneyQuestStatus == xi.questStatus.QUEST_COMPLETED) and
        hasNotReceivedHoneyToday then
        local wasSuccessful = npcUtil.giveItem(player, xi.item.POT_OF_WHITE_HONEY)

        if wasSuccessful then
            player:setVar(oncePerDayVarName, 1, NextJstDay())
        end
    else
        player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
    end
end

return entity


local function tech_level_up(player,i)
    local unit = player.select_unit
    local tech = unit:get_tech_index(i)
    local level = player:get_tech_level(tech)
    local dis = unit:check_tech(tech)
    local level_max = up.get_tech_max_level(tech)
    local is_max = level - 1 == level_max
    if is_max then
        gameapi.show_msg_to_role(player._base, "[系统信息]该科技已满级", false)
        return
    end
    local cost_gold = up.get_tech_cost_res(tech,level+1,'金币')
    if dis and cost_gold then
        if player:get('金币') >= cost_gold then
            player:add_tech_level(tech,1)
            player:add('金币',-cost_gold)
        else
            gameapi.show_msg_to_role(player._base, "[系统信息]持有资源不足", false)
        end
    else
        gameapi.show_msg_to_role(player._base, "[系统信息]未满足前置条件", false)
    end
end

local function show_tech_tips(player,i)
    up.ui:show('Tips_tech','',player)
    local unit = player.select_unit
    local tech = unit:get_tech_index(i)
    local update = function()
        local level = player:get_tech_level(tech) + 1
        local level_max = up.get_tech_max_level(tech)
        local is_max = level - 1 == level_max
        local name = up.get_tech_name(tech)
        local desc = up.get_tech_desc(tech)
        local icon = up.get_tech_icon(tech,level)
        local gold = 0
        local dis = unit:check_tech(tech)
        if dis then
            up.ui:hide('TipsDis_tech','',player)
        else
            up.ui:show('TipsDis_tech','',player)
        end
        if is_max == false then
            gold = up.get_tech_cost_res(tech,level,'金币')
        else
            up.ui:set_text('TipsDis_tech','该科技已满级',player)
        end
        up.ui:set_text('TipsName_tech', '研发「'..name..'」', player)
        up.ui:set_text('TipsDesc_tech', desc, player)
        up.ui:set_text('TipsLevel_tech', 'Lv.'..level, player)
        up.ui:set_text('TipsGold_tech', gold, player)
        up.ui:set_image('TipsIcon_tech', icon, player)
    end
    update()
    if player.__updateTechTips then player.__updateTechTips:remove() end
    player.__updateTechTips = up.loop(0.03,function()
        update()
    end)
end

up.game:event('UI-事件', function(self, player,event)
    --科技tips
    for i = 1,6 do
        if event == 'techtips_show_'..i then
            show_tech_tips(player,i)
            return
        end
        if event == 'techtips_hide_'..i then
            up.ui:hide('Tips_tech','',player)
            player.__updateTechTips:remove()
            return
        end
        if event == 'tech_click_'..i then
            tech_level_up(player,i)
            return
        end
    end
end)

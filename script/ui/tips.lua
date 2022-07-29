
local function update_skill_tips(player,skill)
    up.ui:show('Tips','',player)
    up.ui:show('TipsCost','',player)
    up.ui:show('TipsLevel','',player)
    up.ui:hide('TipsItem_sell','',player)
    --local skill = player.show_skill_list[i]
    if not skill then return end
    local name = skill:get_name()
    local desc = skill:get'desc'
    local lv = skill:get_level()
    local cd = skill:get'cd'
    local cost = skill:get'cost'
    local icon = skill:get_icon()
    up.ui:set_text('TipsName', name, player)
    up.ui:set_text('TipsDesc', desc, player)
    up.ui:set_text('TipsLevel', 'Lv.'..lv, player)
    if cd == 0 then
        up.ui:set_text('TipsCool', '无冷却', player)
    else
        up.ui:set_text('TipsCool', cd..'S', player)
    end
    if cost == 0 or skill:get_cast_type() == '被动' then
        up.ui:set_text('TipsCost', '无消耗', player)
    else
        up.ui:set_text('TipsCost', cost..'MP', player)
    end
    up.ui:set_image('TipsIcon', icon, player)
end

local function show_skill_tips(player,i)
    up.ui:show('Tips','',player)
    up.ui:show('TipsCost','',player)
    up.ui:show('TipsLevel','',player)
    up.ui:hide('TipsItem_sell','',player)
    local skill = player.show_skill_list[i]
    if not skill then return end
    player.now_skill_tips = skill
    update_skill_tips(player,skill)
end

local function show_item_tips(player,type,i)
    if type == '物品栏' then
        up.ui:show('Tips','',player)
        up.ui:hide('TipsCost','',player)
        up.ui:hide('TipsLevel','',player)
        up.ui:show('TipsItem_sell','',player)
        local item = player.select_unit:get_item(type,i)
        if not item then return end
        local name = item:get_name()
        local desc = item:get_desc()
        local lv = item:get_level()
        local icon = item:get_icon()
        local price_gold = item:get_buy_price'金币'
        up.ui:set_text('TipsName', name, player)
        up.ui:set_text('TipsDesc', desc, player)
        up.ui:set_text('TipsCool', 'Lv.'..lv, player)
        up.ui:set_text('TipsItem_Gold', price_gold, player)
        up.ui:set_image('TipsIcon', icon, player)
    elseif type == '背包' then
        up.ui:show('shop_tips','',player)
        up.ui:show('TipsItem_1','',player)
        --up.ui:show('TipsItem_sell','',player)
        local item = player.select_unit:get_item(type,i+1)
        if not item then return end
        local name = item:get_name()
        local desc = item:get_desc()
        local lv = item:get_level()
        local icon = item:get_icon()
        local price_gold = item:get_buy_price'金币'
        up.ui:set_text('TipsName_1', name, player)
        up.ui:set_text('TipsDesc_1', desc, player)
        up.ui:set_text('TipsLevel_1', lv, player)
        up.ui:set_text('TipsItem_3', price_gold, player)
        up.ui:set_image('TipsIcon_1', icon, player)
    end
end

local function show_buff_tips(player,i)
    up.ui:show('buff_tips','',player)
    local buff = player.select_unit:find_buff_index(i)
    local name = buff:get_name()
    local desc = buff:get_desc()
    local lv = ''
    if buff.skill then
        lv = 'Lv.'..buff.skill:get_level()
    end
    local icon = buff:get_icon()
    local source = buff:get_source()
    local source_tips = '空'
    if source then
        source_tips = source:get_owner():get_name()..'['..source:get_name()..']'
    end
    up.ui:set_image('buff图标', icon, player)
    up.ui:set_text('buff名称', name, player)
    up.ui:set_text('buff描述', desc, player)
    up.ui:set_text('buff等级', lv, player)
    up.ui:set_text('buff来源', source_tips, player)
end



up.game:event('UI-事件', function(self, player,event)
    --print(event == 'skill_tips_show_1')
    for i = 1,36 do
        if event == 'in_bagItem_'..i then
            show_item_tips(player,'背包',i)
            return
        end
    end
    for i = 1,10 do
        if event == 'skill_tips_show_'..i then 
            show_skill_tips(player,i)
            return
        end
    end
    for i = 1,6 do
        if event == 'show_item_tips_'..i then 
            show_item_tips(player,'物品栏',i)
            return
        end
    end
    for i = 1,10 do
        if event == 'bufftips_show_'..i then
            show_buff_tips(player,i)
            return
        end
        if event == 'bufftips_hide_'..i then
            up.ui:hide('buff_tips','',player)
            return
        end
    end
    local item_hide_tips = {
        'None_21',
        'None_33',
        'None_23',
        'None_35',
        'None_31',
        'None_37',
    }
    for i = 1,50 do
        if event == 'None_'..i then
            up.ui:hide('Tips','',player)
            up.ui:hide('shop_tips','',player)
            return
        end
    end
end)

up.game:event('技能-属性变化',function(_,skill)
    local unit = skill:get_owner()
    local player = unit:get_player()
    if player.now_skill_tips == skill then
        update_skill_tips(player,skill)
    end
end)
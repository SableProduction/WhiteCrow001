
require 'ui.select_unit'
require 'ui.select_item'
require 'ui.select_dest'
require 'ui.tips'
require 'ui.shop'
require 'ui.tech'
require 'ui.back_game'
--ui初始化
up.wait(0.033,function()

    local player_table = {}
    for i = 1 , 30 do 
        if gameapi.get_role_by_int(i) then
            table.insert(player_table,up.player(i))
        end
    end
    --初始化

    for _,v in pairs (player_table) do
        local player = v
        --隐藏预设UI

        up.ui:set_prefab_ui_visible(player,false)

        local hide_ui = {
            'attribute_panel',
            'choose_unit_name',
            'choose_unit_showroom',
            'mutl_unit',
            'hp_bar',
            'mp_bar',
            '训练',
            '建造',
            '科技',
            '工作队列',
            'tips'
        }
        for _,ui in pairs(hide_ui) do
            up.ui:hide(ui,'',player)
        end

        --每帧刷新UI状态
        up.loop(0.033,function()
            --  资源
            if player:get_res_icon('金币') then
                up.ui:set_text('金币文字',player:get('金币'),player)
                up.ui:set_image('货币图标1',player:get_res_icon('金币'),player)
            else
                up.ui:hide('货币_1','',player)
            end
            if player:get_res_icon('木材') then
                up.ui:set_text('木材文字',player:get('木材'),player)
                up.ui:set_image('货币图标2',player:get_res_icon('木材'),player)
            else
                up.ui:hide('货币_2','',player)
            end
            if player:get_res_icon('人口') then
                up.ui:set_text('人口文字',player:get('人口'),player)
                up.ui:set_text('人口上限文字',player:get('人口上限'),player)
                up.ui:set_image('货币图标3',player:get_res_icon('人口'),player)
            else
                up.ui:hide('货币_3','',player)
            end

            --左侧英雄列表
            --时间
            local t_hour = string.gsub(string.sub(up.get_game_time(),1,2),'%.','')
            local t_min = string.format("%d",tonumber(string.sub(string.format("%.2f", up.get_game_time()),-2,-1)*60/100))
            if	string.len(t_min) == 1 then
                t_min = "0" .. t_min
            end
            if tonumber(t_hour) >= 6 and tonumber(t_hour) <= 18 then
                up.ui:set_image('image_188',106328,player)
            else
                up.ui:set_image('image_188',106325,player)
            end 
            local time = t_hour..":"..t_min
                
            up.ui:set_text('time_txt',time,player)
            for i=1,6 do
                if not player.herolist then return end
                local hero = player.herolist[i]
                if hero then
                    up.ui:show('英雄列表_'..(i),'',player)
                    up.ui:set_progress('英雄魔法条_'..(i),hero:get'最大魔法值',hero:get'魔法值',player)
                    if hero:is_alive() then
                        up.ui:hide('英雄灰态_'..(i),'',player)
                    else
                        up.ui:show('英雄灰态_'..(i),'',player)
                        up.ui:set_progress('英雄魔法条_'..(i),hero:get'最大魔法值',0,player)
                    end
                    up.ui:set_text('英雄名_'..(i),hero:get_name(),player)
                    up.ui:set_image('英雄头像_'..(i),hero:get_icon(),player)
                    up.ui:set_progress('英雄生命条_'..(i),hero:get'最大生命值',hero:get'生命值',player)
                    
                else
                    up.ui:hide('英雄列表_'..(i),'',player)
                end
            end


        end)
    end
end)

up.game:event('单位-创建',function(_,unit)
    if not unit then
        --print(debug.traceback('------单位-创建------'))
    end
    local player = unit:get_owner()
    if not player.herolist then player.herolist = {} end
    if unit:is_hero() then
        --unit.skill_point = unit:get_level()
        table.insert(player.herolist,unit)
    end
end)

up.game:event('单位-删除',function (_,unit)
    local player = unit:get_owner()
    if not player.herolist then return end
    if not unit:is_hero() then return end
    table.removeValue(player.herolist,unit)
end)

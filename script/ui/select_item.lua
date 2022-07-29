

up.game:event('物品-选中',function (_,player,item)
    local hide_ui = {
        'attribute_panel',
        'hp_bar',
        'mp_bar',
        'mutl_unit',
        'lv_panel',
        'choose_unit_showroom',
        'skill_panel',
        'exp_bar',
        'bagBtn',
        'bag',
        '可破坏物面板',
        'lv_panel',
    }
    for _,ui in pairs(hide_ui) do
        up.ui:hide(ui,'',player)
    end

    local show_ui = {
        'name_panel',
        'choose_unit_icon',
        'main_des',
        '角色'
    }
    for _,ui in pairs(show_ui) do
        up.ui:show(ui,'',player)
    end

    player.select_unitgroup = nil
    player.select_unit = nil
    player.select_target = item
    up.ui:set_text('choose_unit_name',item:get_name(),player)
    up.ui:set_text('main_des',item:get_desc(),player)
    up.ui:set_image('choose_unit_icon',item:get_icon(),player)
    
end)

up.game:event('单位-获得物品',function (_,unit,item)
    for  i = 1 , 32 do 
        if gameapi.get_role_by_int(i) then
            local player = up.player(i)
            if item == player.select_target then
                up.ui:hide('角色','',player)
                player.select_target = nil
            end
        end
    end
end)

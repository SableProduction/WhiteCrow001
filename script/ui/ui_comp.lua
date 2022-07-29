
local ui_comp = {}
ui_comp.unit_base_attr_ui = {
    ['attack_phy'] = 'attack_txt',
    ['defense_phy'] = 'defense_txt',
    ['attack_speed'] = 'attack_speed_txt',
    ['ori_speed'] = 'move_speed_txt',
}
ui_comp.unit_other_attr_ui = {
    ['attack_phy'] = '控制台-属性值-附加攻击',
    ['defense_phy'] = '控制台-属性值-附加护甲',
    ['attack_speed'] = '控制台-属性值-附加攻速',
    ['ori_speed'] = '控制台-属性值-附加移速',
}
ui_comp.hero_base_attr_ui = {
    ['attack_phy'] = 'attack_txt',
    ['defense_phy'] = 'defense_txt',
    ['attack_speed'] = 'attack_speed_txt',
    ['ori_speed'] = 'move_speed_txt',
    ['strength'] = 'attr_strength',
    ['agility'] = 'attr_agility',
    ['intelligence'] = 'attr_intelligence',
}
ui_comp.hero_other_attr_ui = {
    ['attack_phy'] = '控制台-属性值-附加攻击',
    ['defense_phy'] = '控制台-属性值-附加护甲',
    ['attack_speed'] = '控制台-属性值-附加攻速',
    ['ori_speed'] = '控制台-属性值-附加移速',
    ['strength'] = '控制台-属性值-附加力量',
    ['agility'] = '控制台-属性值-附加敏捷',
    ['intelligence'] = '控制台-属性值-附加智力',
}

ui_comp.hero_total_attr_ui = {
    ['attack_phy'] = 'attack_txt',
    ['defense_phy'] = 'defense_txt',
    ['attack_speed'] = 'attack_speed_txt',
    ['ori_speed'] = 'move_speed_txt',
    ['strength'] = 'strength_txt',
    ['agility'] = 'agility_txt',
    ['intelligence'] = 'intelligence_txt',
}

ui_comp.unit_total_attr_ui = {
    ['attack_phy'] = 'attack_txt',
    ['defense_phy'] = 'defense_txt',
    ['attack_speed'] = 'attack_speed_txt',
    ['ori_speed'] = 'move_speed_txt',
}

ui_comp.hero_lmz_ui = {
    'attr_strength',
    'attr_agility',
    'attr_intelligence',
}


ui_comp.tech_list_ui = {}
for i=1,6 do
    table.insert(ui_comp.tech_list_ui,'button_('..i..')')
end


TECH_MAX = 6

return ui_comp

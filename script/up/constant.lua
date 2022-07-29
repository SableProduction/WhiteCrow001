
-- campinfo
RoleResKey = {
    ['金币'] = 'official_res_1',
}

ABILITY_STR_ATTRS = {
	['名称'] = 'name',
	['描述'] = 'description',

    ['name'] = 'name',
    ['desc'] = 'description',
}

ABILITY_FLOAT_ATTRS = {
    ['魔法消耗']='ability_cost',
    ['冷却时间']='cold_down_time',
    ['技能伤害']='ability_damage',
    ['施法距离']='ability_cast_range',
    ['前摇时间']='ability_cast_point',
    ['后摇时间']='ability_bw_point',
    ['施法时间']='ability_channel_time',
    ['准备时间']='ability_prepare_time',
    ['影响范围']='ability_damage_range',
    ['充能冷却']='ability_stack_cd',

    ['cost']='ability_cost',
    ['cd']='cold_down_time',
    ['damage']='ability_damage',
    ['range']='ability_cast_range',
    ['cast_time']='ability_cast_point',
    ['bw_time']='ability_bw_point',
    ['channel_time']='ability_channel_time',
    ['prepare_time']='ability_prepare_time',
    ['area']='ability_damage_range',
    ['stack_cd']='ability_stack_cd',
}

ABILITY_INT_ATTRS = {
    ['最大等级']='ability_max_level',
    ['学习等级']='required_level',
    ['消耗资源类型']='ability_cost_type',
    ['最大充能']='ability_max_stack_count',

    ['max_level']='ability_max_level',
    ['required_level']='required_level',
    ['cast_type']='ability_cost_type',
    ['max_stack']='ability_max_stack_count',
}

ABILITY_BOOL_ATTRS = {
    ['是否是被动']='is_passive',
    ['是否是普攻']='is_attack',
    ['是否是近战']='is_meele',
    ['是否显示施法条']='show_channel_bar',
    ['是否是开关技能']='is_toggle',

    ['is_passive']='is_passive',
    ['is_attack']='is_attack',
    ['is_meele']='is_meele',
    ['show_channel_bar']='show_channel_bar',
    ['is_toggle']='is_toggle',
}

SlotType = {
    ['地面'] = -1,
    ['背包'] = 0,
    ['物品栏'] = 1,
}

AbilityType = {
    ['隐藏'] = 0,
    ['普攻'] = 1,
    ['通用'] = 2,
    ['英雄'] = 3,
}

AbilityTypeId = {
    '隐藏','普攻','通用','英雄'
}

AbilityCastType = {
    ['普攻'] = 1,
    ['主动'] = 2,
    ['被动'] = 3,
    ['建造'] = 4,
    ['魔法书'] = 5,
}

AbilityCastTypeId = {
    '普攻','主动','被动','建造','魔法书'
}

KvType = {
    ['real'] = 'float',
    ['str'] = 'string',
    ['int'] = 'integer',
    ['bool'] = 'boolean',
    ['ui'] = 'ui_comp',
    ['unit'] = 'unit_entity',
    ['unitName'] = 'unit_name',
    ['unitGroup'] = 'unit_group',
    ['item'] = 'item_entity',
    ['itemName'] = 'item_name',
    ['abilityType'] = 'ability_type',
    ['abilityCast'] = 'ability_cast_type',
    ['abilityName'] = 'ability_name',
    ['model'] = 'model',
    ['tech'] = 'tech_key',
    ['buff'] = 'modifier',
}

HarmTextType = {
    ['物理伤害'] = 1,
    ['物理暴击'] = 2,
    ['闪避'] = 3,
    ['治疗'] = 7,
    ['魔法伤害'] = 9,
    ['魔法暴击'] = 10,
    ['无敌'] = 17,
    ['真实伤害'] = 19,
    ['获取金币'] = 30,
    ['获取木材'] = 31,
}

RestrictionId = {
    ['禁止攻击'] = 2^1,
    ['禁止施法'] = 2^2,
    ['禁止移动'] = 2^3,
    ['禁止转向'] = 2^4,
    ['动画定帧'] = 2^5,
    ['无法施加运动'] = 2^6,
    ['无法被锁定'] = 2^7,
    ['无法被选中'] = 2^8,
    ['隐身'] = 2^9,
    ['无视静态阻挡'] = 2^10,
    ['无视动态阻挡'] = 2^11,
    ['免疫死亡'] = 2^12,
    ['无敌'] = 2^13,
    ['无法控制'] = 2^14,
    ['无法被攻击'] = 2^15,
    ['AI无视'] = 2^16,
    ['物理免疫'] = 2^17,
    ['魔法免疫'] = 2^18,
    ['负面魔法效果免疫'] = 2^19,
    ['隐藏'] = 2^20,
}

--UNIT_COMMAND = {
--    [1] = '移动',
--    [2] = '攻击移动',
--    [3] = '攻击目标',
--    [4] = '巡逻',
--    [5] = '停止',
--    [6] = '防守',
--    [7] = '施放技能',
--    [8] = '拾取物品',
--    [9] = '丢弃物品',
--    [10] = '给予物品',
--    [11] = '跟随',
--    [12] = '沿路径移动',
--}

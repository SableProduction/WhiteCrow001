up = {}
-- 常量配置数据 --
PLAYER_CAMP_ID = 1 -- 玩家阵营ID
NEUTRAL_ENEMY_CAMP_ID = 31 -- 中立敌对阵营ID
NEUTRAL_FRIEND_CAMP_ID = 32 -- 中立友善阵营ID
Python = python
New_global_trigger = new_global_trigger
New_modifier_trigger = new_modifier_trigger
New_item_trigger = new_item_trigger

SUMMON_UNITS = {}
MAX_SUMMON_NUM = 5
PLAYER_MAX = 1
ALL_PLAYER = gameapi.get_all_role_ids()
UI_EVENT_LIST = {
    'CameraToUnit',
    'task1',
    'task2',
    'focus_btn_click',
    'defocus_btn_click',
    'close_shop',
    'shop_tab_up',
    'shop_tab_down',
    'back_game',
}
CUSTOM_EVENT_LIST = {
    '注册任务'
}

for i=1,6 do
    table.insert(UI_EVENT_LIST,'ClickHero_'..i)
    table.insert(UI_EVENT_LIST,'show_item_tips_'..i) 
end

for i=1,10 do
    table.insert(UI_EVENT_LIST,'skill_tips_show_'..i)
end

for i=1,32 do
    table.insert(UI_EVENT_LIST,'TouchStart_'..i)
end

for i=1,36 do
    table.insert(UI_EVENT_LIST,'in_bagItem_'..i)
end
--商店
for i=1,4 do
    table.insert(UI_EVENT_LIST,'shop_tab_'..i)
end

for i=1,6 do
    table.insert(UI_EVENT_LIST,'sell_item_show_'..i)
end

--科技
for i=1,6 do
    table.insert(UI_EVENT_LIST,'tech_click_'..i)
    table.insert(UI_EVENT_LIST,'techtips_show_'..i)
    table.insert(UI_EVENT_LIST,'techtips_hide_'..i)
end

--buff
for i=1,10 do
    table.insert(UI_EVENT_LIST,'bufftips_show_'..i)
    table.insert(UI_EVENT_LIST,'bufftips_hide_'..i)
end

for i=1,36 do
    table.insert(UI_EVENT_LIST,'TouchRightClick_'..i)
end
for i=2,53 do
    table.insert(UI_EVENT_LIST,'MouseEnter_'..i)
    table.insert(UI_EVENT_LIST,'MouseLeave_'..i)
end

for i=1,50 do
    table.insert(UI_EVENT_LIST,'None_'..i)
end

require 'up'
--require 'test.test'
---resource block start---
---资源使用声明应在脚本最开始且此部分首尾注释不能修改!!!  xxx_id对照maps/offical_expr_data/trigger_related_xxx.json

local setmetatable = setmetatable

--up.print('lua','初始化成功')

-- up.game:event('游戏-初始化', function(_, data)
--     up.print('test','初始化成功')
    
-- end)

require 'ui'
--require 'game'
-- require 'random_trigger'
-- require 'ltyj'
-- require 'global_protect'





up.game:event('单位-收到指令',function(_,unit,order, ...)

    --如果攻击目标是可破坏物做一个特判
    if order == '命令-攻击' then
        local target = ...
        if target.type == 'destructable' then
            unit:event_dispatch( order..'可破坏物', unit,target)
            return
        end
    end
    unit:event_dispatch(order,unit,...)
end)

local a_type = {
    [0]= '隐藏',
    [1] = '普攻',
    [2] = '通用',
    [3] = '英雄',
}


up.game:event('玩家-打开技能指示器',function(_,player,unit,type,index)
    local skill = unit:find_skill(a_type[type],nil,index)
    up.game:event_dispatch('指示器-显示',player,skill)
end)

up.game:event('玩家-关闭技能指示器',function(_,player,unit,type,index)
    local skill = unit:find_skill(a_type[type],nil,index)
    up.game:event_dispatch('指示器-消失',player,skill)
end)
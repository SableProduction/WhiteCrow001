local math = math
local table = table
local setmetatable = setmetatable
local type = type
local mover_id = 0

local mt = {}
mt.__index = mt

function mt:stop()
    gameapi.break_unit_mover(self.unit._base)
end

function mt:remove()
    gameapi.remove_unit_mover(self.unit._base)
end

local function mover_line(data)
    mover_id = mover_id + 1
    local mover = {}
    mover.unit = data.self
    setmetatable(mover, mt)

    local hit_type = {
        ['敌人'] = 0,
        ['盟友'] = 1,
        ['全部'] = 2,
    }

    gameapi.create_straight_mover(
        data.self._base,
        Fix32(data.angle or 0),
        Fix32(data.dis or 99999),
        Fix32(data.speed or 0),
        Fix32(data.accel or 0),
        Fix32(data.max_speed or 99999),
        Fix32(data.min_speed or 0),
        Fix32(data.height or 0),
        Fix32(data.target_height or 0),
        Fix32(data.parabola_height or 0),
        hit_type[data.hit_type] or 0,
        Fix32(data.hit_area or 0.0),
        data.is_face or false,
        data.is_hit_same or false,
        data.is_block or false,
        data.priority or 1,
        data.is_absolute_height or false,
        function()
            if mover.on_finish then
                mover:on_finish()
            end
        end,
        function()
            if mover.on_break then
                mover:on_break()
            end
        end,
        function()
            if mover.on_remove then
                mover:on_remove()
            end
        end,
        function()
            if mover.on_block then
                mover:on_block()
            end
        end,
        function()
            if mover.on_hit then
                mover:on_hit()
            end
        end
    )
    return mover
end

function up.effect_class.__index:mover_line(data)
    data.self = self
    return mover_line(data)
end

function up.unit_class.__index:mover_line(data)
    data.self = self
    return mover_line(data)
end

--停止单位身上的运动器
function up.unit_class.__index:stop_mover()
    gameapi.break_unit_mover(self._base)
end
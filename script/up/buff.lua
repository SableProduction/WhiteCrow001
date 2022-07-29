local table_insert = table.insert
local setmetatable = setmetatable
local table_remove = table.remove
local math_max = math.max
local math_floor = up.math.floor
local pairs = pairs

local mt = {}
mt.__index = mt
mt.type = 'buff'

local Buffs = {}
function up.actor_buff(u)
    local id = u:api_get_modifier_unique_id()
    local key = u:api_get_modifier_key()
    if not Buffs[id] then
        local data = {}
        data._base = u 
        for k, v in pairs(up.buff[key]) do
            if data[k] == nil then
                data[k] = v
            end
        end
        local buff = setmetatable(data, mt)
        buff._base = u
        buff.target = up.actor_unit(u:api_get_owner())
        if u:api_get_releaser() then
            buff.source = up.actor_unit(u:api_get_releaser())
        else
            buff.source = up.actor_unit(u:api_get_owner())
        end
        buff.id = id
        buff.key = key
        buff.skill = up.actor_skill( globalapi.get_related_ability(u))
        buff.name = gameapi.get_modifier_name_by_type(u:api_get_modifier_key())
        buff.desc = gameapi.get_modifier_desc_by_type(u:api_get_modifier_key())
        buff.icon = gameapi.get_icon_id_by_buff_type(u:api_get_modifier_key())
        
        Buffs[id] = buff
    end
    return Buffs[id]
end

function up.unit_class.__index:add_buff(name)
    return function(bff)
        local u = nil
        if bff.source then
            u = bff.source._base
        end
        local skl = nil
        if bff.skill then
            skl = bff.skill.skill
        end
        if not bff.time then
            bff.time = -1
        end
        if not bff.updata then
            bff.updata = 0
        end
        if not bff.stack then
            bff.stack = 1
        end
        --print('updata',bff.updata)
        local bf = self._base:api_add_modifier(tonumber(name),u,skl,Fix32(bff.time),Fix32(bff.updata),bff.stack)
        local bf2 = up.actor_buff(bf)
        return bf2
    end
end


function up.unit_class.__index.each_buff(self, name)
    local bf_list = self._base:api_get_all_modifiers()
    local group = {}
    for index, value in Python.enumerate(bf_list) do
        local a = up.actor_buff(value)
        table.insert(group,a)
    end
    local n = 0
    return function (t, v)
        n = n + 1
        return t[n]
    end, group
end

--移除buff
function up.unit_class.__index.remove_buff(self, name)
    if type(name) == 'string' then
        name = tonumber(name)
    end
    self._base:api_remove_modifier_type(name)
    self = nil
end

--找buff
function up.unit_class.__index.find_buff(self, name)
    local bff = self._base:api_get_modifier(1,name)
    if bff then
        return up.actor_buff(bff)
    else
        return nil
    end
end

--找指定位置的BUFF
function up.unit_class.__index.find_buff_index(self, index)
    local bf_list = self._base:api_get_all_modifiers()
    local group = {}
    for _, value in Python.enumerate(bf_list) do
        local a = up.actor_buff(value)
        table.insert(group,a)
    end
    local bff = group[index]
    if bff then
        return bff
    else
        return nil
    end
end

--是否有BUFF
function up.unit_class.__index.has_buff(self, name)
    if type(name) == 'string' then
        name = tonumber(name)
    end
    return self._base:api_has_modifier(name)
end

function mt:get_name()
    return self._base:api_get_str_attr("name_str")
end

function mt:get_desc()
    return self._base:api_get_str_attr("description")
end

function mt:get_icon()
    return self.icon
end

function mt:get_source_unit()
    return self.source
end

function mt:get_source_skill()
    return self.skill
end

function mt:remove()
    self._base:api_remove()
end

function mt:add_stack(stack)
    self._base:api_add_buff_layer(stack)
end

function mt:set_stack(stack)
    self._base:api_set_buff_layer(stack)
end

function mt:add_max_stack(stack)
    self._base:api_add_buff_max_layer(stack)
end

--获取效果携带者
function mt:get_owner()
    return self.target
end

--获取效果来源
function mt:get_source()
    return self.source
end

-- function mt:get_pulse()
--     return self._base:
-- end

function mt:add_pulse(time)
    self._base:api_add_cycle_time(time)
end

function mt:set_pulse(time)
    self._base:api_set_cycle_time(time)
end



function mt:add_remaining(time)
    self._base:api_set_buff_residue_time(time)
end

function mt:get_remaining()
    return self._base:api_get_passed_time()
end


--光环
function mt:get_aura_child()
    --return 
end

function mt:get_aura_range()
end

--缺少护盾相关的api

--mt.source =  self._base:api_get_owner()






local event_name = {
	['on_add']          = {20001,EVENT.OBTAIN_MODIFIER,'效果-获得'},
	['on_remove']       = {20002,EVENT.LOSS_MODIFIER,'效果-失去'},
	['on_can_add']      = {20003,EVENT.MODIFIER_GET_BEFORE_CREATE,'效果-即将获得'},
	['on_stack']        = {20004,EVENT.MODIFIER_LAYER_CHANGE,'效果-层数变化'},
	['on_pulse']        = {20005,EVENT.MODIFIER_CYCLE_TRIGGER,'效果-心跳'},
	['on_cover']        = {20006,EVENT.MODIFIER_BE_COVERED,'效果-覆盖'},
}


local function buff_event_init(buff,name)
    local hook = {}
    for k, v in pairs(event_name) do
        if buff[k] then
        else
            local trg = New_modifier_trigger(tonumber(name), v[1], tostring(v[3]), v[2], true)
            buff[k] = function() end
            function trg.on_event(trigger, event, actor, data)
                local bf2 = up.actor_buff(data['__modifier'])
                buff[k](bf2)
            end
        end
    end
end



up.buff = setmetatable({}, {__index = function(self, name)
    self[name] = {}
    setmetatable(self[name], mt)
    buff_event_init(self[name],name)
    return self[name]
end})



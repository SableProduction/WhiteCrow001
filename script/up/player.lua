require"python"
local math = math
local table = table
local setmetatable = setmetatable
local type = type


local mt = {}
mt.__index = mt

--类型
mt.type = 'player'

local Player = {}

function mt:__tostring()
    return ('%s'):format('player')
end

function mt:set_input(bool)
    gameapi.block_global_mouse_event(self._base,bool)
    --gameapi.block_global_key_event(self._base,bool)
end

function mt:refresh_team_list(team_id)
    local u = gameapi.get_unit_ids_in_team(self._base,team_id)
    self._base:role_select_unit(u)
end

function mt:get_team_unit(team_id)
    local u = gameapi.get_unit_ids_in_team(self._base,team_id)
    local group = {}
    for index, value in Python.enumerate(u) do
        local a = up.actor_unit(value)
        table.insert(group,a)
    end
    return group
end

function mt:add(key,value)
    if RoleResKey[key] then key = RoleResKey[key] end
    self._base:change_role_res(key,Fix32(value))
end

function mt:set(key,value)
    if RoleResKey[key] then key = RoleResKey[key] end
    self._base:set_role_res(key,Fix32(value))
end

function mt:get(key)
    if RoleResKey[key] then 
        key = RoleResKey[key] 
        return self._base:get_role_res(key):float()
    end
end

function mt:get_res_icon(key)
    if RoleResKey[key] then 
        key = RoleResKey[key] 
        return gameapi.get_role_res_icon(key)
    end
end

function mt:get_state()
    return self._base:get_role_status()
end

function mt:get_name()
    return self._base:get_role_name()
end

function mt:set_name(name)
    self._base:set_role_name(name)
end

--获取鼠标位置
function mt:get_mouse_pos()
    return up.actor_point(gameapi.get_player_pointing_pos(self._base))
end

--科技
function mt:set_tech_lv(tech,lv)
    self._base:api_set_tech_level(tech,lv)
end

function mt:get_tech_lv(tech)
    return self._base:api_get_tech_level(tech)
end

function mt:msg(text)
    gameapi.show_msg_to_role(self._base,text,false)
end

-- 获取playerID
function mt:get_id()
    return self._base:get_role_id_num()
end
function mt:set_exp_rate(rate)
    self._base:set_role_exp_rate(rate)
end

function mt:get_exp_rate()
    return self._base:get_role_exp_rate()
end

function mt:show_text(text)
    --gameapi.show_msg_to_role(self._base,text,false)
end

function mt:game_win()
    gameapi.set_melee_result_by_role(self._base,'victory',true,false,0,false)
end

function mt:game_bad()
    gameapi.set_melee_result_by_role(self._base,'defeat',true,false,0,false)
end

--科技相关
function mt:get_tech_level(tech)
    return self._base:api_get_tech_level(tech)
end

function mt:add_tech_level(tech,lv)
    return self._base:api_change_tech_level(tech,lv)
end

function mt:set_tech_level(tech,lv)
    return self._base:api_set_tech_level(tech,lv)
end

-- 获取阵营
function mt:get_team()
    return self._base:api_get_camp_id()
end

function mt:set_team(id)
    self._base:set_role_camp_id(id)
end

function mt:create_unit(name,point,angle)
    return up.create_unit(name, point, angle, self)
end

function mt:select(unit,flag)
    if not unit then return end
    if flag then
        self._base:role_select_unit(unit._base)
    else
        up.wait(0.033,function()
            self._base:role_select_unit(unit._base)
        end)
    end
end

function mt:set_born_point(point)
    self._base:set_role_spawn_point(point._base)
end

function mt:get_born_point()
    return up.actor_point(self._base:get_role_spawn_point())
end

function mt:set_alliance_state(role,state)
    self._base:set_role_hostility(role._base,state)
end

function mt:camera_focus(unit)
    gameapi.camera_set_follow_unit(self._base,unit._base)
end


function mt:camera_unfocus()
    gameapi.camera_cancel_follow_unit(self._base)
end

function mt:get_units_by_key(key)
    local group = {}
    local u = gameapi.get_units_by_key(key)
    for index, value in Python.enumerate(u) do
        local a = up.actor_unit(value)
        if a then
            if a:get_owner() == self then
                table.insert(group,a)
            end
        end
    end
    return group
end

function mt:is_pressed(key)
    return gameapi.player_key_is_pressed(self._base,key)
end

function mt:remove_team_unit(team_id,unit)
    gameapi.remove_unit_from_team(self._base,team_id,unit._base)
end

function mt:use_camera(data)
    local h = gameapi.get_point_ground_height(up.point(data.x,data.y)):float()
    local c = gameapi.add_camera_conf(Fix32Vec3(data.x/100, 0, data.y/100),data.dis/100,(data.height/100),data.yaw-90,360-data.pitch,data.fov)
    
    -- params=((EType.FVector3, '点'), (EType.Float, '焦距'), (EType.Float, '焦点高度'),
    -- (EType.Float, 'yaw'), (EType.Float, 'pitch'), (EType.Float, 'roll')),
    gameapi.apply_camera_conf(self._base,c,data.time)
end

function mt:set_camera(point)
    gameapi.camera_linear_move_duration(self._base, Fix32Vec3(point.x/100, 0, point.y/100), Fix32(0.1), Fix32(0))
    --gameapi.adjust_camera_target_pos(self._base,Fix32(x),Fix32(y),Fix32(0),Fix32(0.2))
    -- if data['position'] then
    -- end
end

function mt:set_camera_distance(dis)
    gameapi.camera_set_param_distance(self._base,dis/100)
end

function mt:set_camera_pitch(pitch,time)
    if time then
        gameapi.camera_rotate_pitch_angle_duration(self._base,pitch,time)
    else
        gameapi.camera_set_param_pitch(self._base,pitch)
    end
end

function mt:set_camera_yaw(yaw,time)
    if time then
        
        gameapi.camera_rotate_yaw_angle_duration(self._base,yaw,time)
    else
        gameapi.camera_set_param_yaw(self._base,yaw)
    end
    
end

function mt:remove_control_unit(unit)
    gameapi.remove_control_unit(self._base,unit._base)
end


function mt:camera_set_focus_y(y)
    gameapi.camera_set_focus_y(self._base,y)
end

--条件判断
function mt:is_ally(role)
    return self._base:players_is_alliance(role._base)
end

function mt:is_enemy(role)
    return self._base:players_is_enemy(role._base)
end


local up_event_dispatch = up.event_dispatch
local up_event_notify = up.event_notify
local up_game = up.game

--注册单位事件
function mt:event(name, f)
	return up.event_register(self, name, f)
end

--发起事件
function mt:event_dispatch(name, ...)
    local res, arg = up_event_dispatch(self, name, ...)
    if res ~= nil then
        return res, arg
    end
    local res, arg = up_event_dispatch(up_game, name, ...)
    if res ~= nil then
        return res, arg
    end
    return nil
end

function mt:event_notify(name, ...)
    up_event_notify(self, name, ...)
    up_event_notify(up_game, name, ...)
end


function up.player(i)
    if not Player[i] then
        local player = {}
        player._base = gameapi.get_role_by_int(i)
        setmetatable(player, mt)
        Player[i] = player
    end
    return Player[i]
end
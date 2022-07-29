if up.split then return end

local table_insert = table.insert
local math_cos = math.cos
local math_sin = math.sin
local math_rad = math.rad
local math_floor = math.floor

function up.traceback(message)
    print('--------------------------')
    print('LUA ERROR:'..tostring(message)..'|n')
    print(debug.traceback)
    print('--------------------------')
end


function up.split(str, p)
	local rt = {}
	str:gsub('[^'..p..']+', function (w)
		table_insert(rt, w)
	end)
	return rt
end

function up.get_item_kv(key,name)
    return gameapi.get_item_key_integer_kv(key,name)
end

function up.has_skill_kv(s_id,key,type)
    return gameapi['has_ability_key_'..KvType[type]..'_kv'](s_id,key)
end

--获取技能类型的KV属性
function up.get_skill_kv(s_id,key,vType)
    local value = gameapi['get_ability_key_'..KvType[vType]..'_kv'](s_id,key)
    if vType == 'real' then
        value = value:float()
    end
    if type(value) ~= 'number' and vType == 'int' then
        value = value:int()
    end
    return value
end


function up.table_copy(tbl)
    local a = {}
    for i = 1,#tbl do
        a[i]  = tbl[i]
    end
    return a
end

function up.get_item_name(key)
    return gameapi.get_item_name_by_type(key)
end

function up.get_item_desc(key)
    return gameapi.get_item_desc_by_type(key)
end

function up.get_item_icon(key)
    return gameapi.get_item_key_icon(key)
end

function up.get_item_buy_price(key,price_tpye)
    return gameapi.get_item_buy_price(key, RoleResKey[price_tpye]):float()
end

function up.get_unit_name(key)
    return gameapi.get_unit_name_by_type(key)
end

function up.get_unit_icon(key)
    return gameapi.get_icon_id_by_unit_type(key)
end

function up.get_unit_desc(key)
    return gameapi.get_unit_desc_by_type(key)
end

function up.set_pre_ui_show(show,player)
    gameapi.set_prefab_ui_visible(player._base,show)
end

function up.get_ability_icon(key)
    return gameapi.get_icon_id_by_ability_type(key)
end

function up.get_ability_name(key)
    return gameapi.get_ability_name_by_type(key)
end

function up.get_ability_desc(key)
    return gameapi.get_ability_desc_by_type(key)
end

function up.create_harm_text(point,type,text,playerGroup)
    if type=='获取金币' or type == '获取木材' then
        gameapi.create_harm_text(point._base,HarmTextType[type],"+"..math.floor(text),ALL_PLAYER)
    else
        gameapi.create_harm_text(point._base,HarmTextType[type],math.floor(text),ALL_PLAYER)
    end
    
end

function up.get_game_time()
    return gameapi.get_cur_day_and_night_time():float()
end


function up.get_unit_type_kv(name,type)
    return gameapi.get_unit_key_unit_name_kv(name,type)
end

EVENT_ID = 700000
function up.get_event_id()
    EVENT_ID = EVENT_ID + 1
    return EVENT_ID
end

function table.removeValue(t,value)
    for k,v in ipairs(t) do
        if v == value then
            table.remove(t,k)
            return k
        end
    end
    return nil
end

function up.print(...)
	local str = ''
    local t = {...}
    for i = 1, #t - 1 do
        str = str .. tostring(t[i]) .. '    '
    end
    str = str .. tostring(t[#t])
	gameapi.print_to_dialog(3,str)
end

function up.item_list(list)
	return setmetatable({}, {__newindex = function(_, k, v)
		for _, name in ipairs(list) do
			up.item[name][k] = v
		end
	end})
end

function up.skill_list(list)
	return setmetatable({}, {__newindex = function(_, k, v)
		for _, name in ipairs(list) do
			up.skill[name][k] = v
		end
	end})
end

--把小数点后的0去掉
function up.FormatNum (num)
    num = tonumber(num)
	if num <= 0 then
		return 0
	else
		local t1, t2 = math.modf(num)
		---小数如果为0，则去掉
		if t2 > 0 then
			return num
		else
			return t1
		end
	end
end

-- 十进制转二进制
function up.byte2bin(n)
    local t = {}
    for i=8,0,-1 do
        t[#t+1] = math.floor(n / 2^i)
        n = n % 2^i
    end
    return table.concat(t)
end

-- 判断有哪几个二进制数
    -- n    十进制数
    -- m    二进制最大位数
function up.byte2get(n,m)
    local t = {}
    local v
    for i=0,m do
        v = math.floor(n/2^i)
        if v == 1 then
            table.insert(t,2^i)
        end
    end
    return t
end

print = up.print
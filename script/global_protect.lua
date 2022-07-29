
local mt = {}
setmetatable(_G, mt)

function mt:__index(k)
	if k == 'undef' then
		return nil
	else
		print(('读取不存在的全局变量[%s]'):format(k))
		log.error(('读取不存在的全局变量[%s]'):format(k))
		return nil
	end
end

function mt:__newindex(k, v)
	if k == 'undef' then
		print('不能改变 undef 。')
		log.error('不能改变 undef 。')
	else
		print(('保存全局变量[%s][%s]'):format(k, v))
		log.error(('保存全局变量[%s][%s]'):format(k, v))
		rawset(self, k, v)
	end
end

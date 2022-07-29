--先统一处理动作，是否要在lua封装到控件层再看
up.ui = {}


up.ui.consle_tbl = {}

up.ui.event = {}

local n = 0

-- --
-- {{EVENT.TRIGGER_COMPONENT_EVENT,'None_2'},'UI-事件',{{'role_id','player'}}},

-- local trg = new_global_trigger(100000+n, event[2], event[1], true)
-- n = n+1
-- trg.on_event = function(trigger,event_name,actor,data)

-- up.wait(1,function()

--     local trg = new_global_trigger(500000, 'UI-事件', {EVENT.TRIGGER_COMPONENT_EVENT,"None_2"}, true)
--     --up.event_register(obj, name, f)
--     up.print('注册ui事件',event)
--     trg.on_event = function(trigger,event_name,actor,data)
--         up.print('触发ui拉')
--         --up.game:event_notify('UI-事件')
--     end
-- end)

-- function up.ui.register_ui_event(player,event)
--     local trg = new_global_trigger(500000+n, 'UI-事件', {EVENT.TRIGGER_COMPONENT_EVENT,event}, true)
--     --up.event_register(obj, name, f)
--     up.print('注册ui事件',event)
--     trg.on_event = function(trigger,event_name,actor,data)
--         up.print('触发ui拉')
--         --up.game:event_notify('UI-事件')
--     end
-- end

--{,,{{'role_id','player'},'comp_name','ui_event_name'}},


function up.ui:show(name,anim,player)
    if anim == 'ease' then
        local a = 0
        gameapi.show_ui_comp_animation(player._base,name,anim)
        up.ui:set_opacity(name,0,player)
        up.loop(0.033,function(t)
            if a <= 20 then
                a = a + 1
                up.ui:set_opacity(name,a*5*0.01,player)
            else
                t:remove()
            end
        end)
    else
        gameapi.show_ui_comp_animation(player._base,name,anim)
    end
end

function up.ui:hide(name,anim,player)
    gameapi.hide_ui_comp_animation(player._base,name,anim)
    up.game:event_dispatch('UI-隐藏',name,player)
    -- if anim == 'ease' then
    --     local a = 0
    --     up.loop(0.033,function(t)
    --         if a <= 33 then
    --             a = a + 1
    --             up.ui:set_opacity(name,1 - a*3*0.01,player)
    --         else
    --             gameapi.hide_ui_comp_animation(player._base,name,anim)
    --             t:remove()
    --         end
    --     end)
    -- else
    --     gameapi.hide_ui_comp_animation(player._base,name,anim)
    -- end
end

function up.ui:set_hotkey(name,key,player)
    gameapi.set_btn_short_cut(player._base,name,key)
end

--  设置预设主界面UI显隐
function up.ui:set_prefab_ui_visible(player,flag)
    gameapi.set_prefab_ui_visible(player._base,flag)
end

function up.ui:set_position(name,position,player)
    gameapi.set_ui_comp_pos(player._base,name,position[1],position[2])
end

function up.ui:set_size(name,size,player)
    gameapi.set_ui_comp_size(player._base,name,size[1],size[2])
end

function up.ui:set_scale(name,scale,player)
    gameapi.set_ui_comp_scale(player._base,name,scale[1],scale[2])
end

function up.ui:active_skill(name,bool,player)
    gameapi.set_skill_btn_action_effect(player._base, name,bool) 
end



function up.ui:set_z_order(name,z_order,player)
    gameapi.set_ui_comp_z_order(player._base,name,z_order)
end

function up.ui:set_image(name,image_id,player)
    gameapi.set_ui_comp_image(player._base,name,image_id)
end

function up.ui:set_progress(name,max,cur,player)
    gameapi.set_progress_bar_max_value(player._base,name,max)
    gameapi.set_progress_bar_current_value(player._base,name,cur)
    
end

function up.ui:set_max_value(name,max_value,player)
    gameapi.set_progress_bar_max_value(player._base,name,max_value)
end

function up.ui:set_cur_value(name,current_value,player)
    gameapi.set_progress_bar_current_value(player._base,name,current_value)
end


function up.ui:set_enable(name,enable,player)
    gameapi.set_ui_comp_enable(player._base,name,enable)
end

function up.ui:set_text(name,txt,player)
    gameapi.set_ui_comp_text(player._base,name,tostring(txt))
end

function up.ui:set_font_size(name,font_size,player)
    gameapi.set_ui_comp_font_size(player._base,name,font_size)
end

function up.ui:set_opacity(name,opacity,player)
    gameapi.set_ui_comp_opacity(player._base,name,opacity)
end

function up.ui:bind_skill(name,skill,player)
    gameapi.set_skill_on_ui_comp(player._base,skill._base,name)
end

function up.ui:unbind_skill(name,player)
    gameapi.cancel_bind_skill(player._base,name)
end

function up.ui:bind_buff(name,unit,player)
    gameapi.set_skill_on_ui_comp(player._base,unit._base,name)
end

function up.ui:bind_item(name,item,player)
    gameapi.set_skill_on_ui_comp(player._base,item._base,name)
end

function up.ui:bind_item_tbl(name,unit,slot_type,slot,player)
    gameapi.set_ui_comp_unit_slot(player._base,name,unit._base,SlotType[slot_type],slot)
end

function up.ui:set_ui_comp_slot(player,name,slot_type,slot)
    gameapi.set_ui_comp_slot(player._base,name,SlotType[slot_type],slot)
end

function up.ui:set_model(name,model,player)
    --print(name,model)
    gameapi.set_ui_model_id(player._base,name,model)
end
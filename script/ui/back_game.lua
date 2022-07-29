
up.game:event('UI-事件', function(self, player,event)
    if event == 'back_game' then
        player:game_bad()
        return
    end
end)

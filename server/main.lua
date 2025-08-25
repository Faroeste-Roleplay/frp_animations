RegisterCommand("am", function(source, args)
	TriggerClientEvent('animations:client:ToggleMenu', source)
end)

RegisterCommand("animacao", function(source, args)
	TriggerClientEvent('animations:client:ToggleMenu', source)
end)

RegisterCommand("a", function(source, args)
	TriggerClientEvent('animations:client:EmoteCommandStart', source, args)
end)

TriggerClientEvent('chat:addSuggestion', -1, '/am', 'Abre o menu de animações', {})
TriggerClientEvent('chat:addSuggestion', -1, '/animacao', 'Abre o menu de animações', {})
TriggerClientEvent('chat:addSuggestion', -1, '/a', 'Faça uma animação do menu /am', {{name = "name", help = "Nome da animação"}})
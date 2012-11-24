$('#getSuggestions').live 'pagebeforecreate', () ->	
	$('.collapser').live 'click', (e) ->
		if $(this).hasClass 'open'
			console.log 'close please'
			$(this).parent().next().removeClass('open').addClass 'closed'
			$(this).removeClass('open').addClass 'closed'
		else
			$(this).parent().next().removeClass('closed').addClass 'open'
			$(this).removeClass('closed').addClass 'open'

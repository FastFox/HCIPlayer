$(document).bind 'pageinit', () ->
	$('ul li').live 'click', (e) ->
		$(this).toggleClass('open closed').parent().children('.open').not(this).toggleClass 'open closed'

$('#getSuggestions').live 'pagebeforecreate', () ->	
	console.log 'hoi'

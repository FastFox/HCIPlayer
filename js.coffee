#$(document).bind 'pageinit', () ->
$(document).ready () ->
	console.log 'hoi'
	$('ul.list li').live 'click', (e) ->
		#console.log 'toggle'
		$(this).toggleClass('open closed').parent().children('.open').not(this).toggleClass 'open closed'

$('#playlist').live 'pagebeforecreate', () ->	
	$('#playlistItems .thumbup').live 'click', (e) ->
		if $(this).hasClass 'liked'
			console.log 'Like weghalen'
		else
			console.log 'Like toevoegen'
		false

	$('#playlistItems .thumbdown').live 'click', (e) ->
		if $(this).hasClass 'disliked'
			console.log 'Dislike weghalen'
		else
			console.log 'Dislike toevoegen'
		false

$('#getSuggestions').live 'pagebeforecreate', () ->	
	$('#suggestionItems .addTrack').live 'click', (e) ->
		#console.log $(this)
		$(this).toggleClass 'addTrack trackAdded'
		false
		


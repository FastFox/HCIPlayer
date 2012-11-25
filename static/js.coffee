playlistData = []

suggestionData = []

searchData = []

socket = io.connect 'http://localhost'

$(document).ready () ->
	$('ul.list li').live 'click', (e) ->
		$(this).toggleClass('open closed').parent().children('.open').not(this).toggleClass 'open closed'
	

$('#playlist').live 'pagebeforecreate', () ->	
	$('#playlistItems .thumbup').live 'click', (e) ->
		$(this).toggleClass 'liked'
		#if $(this).hasClass 'liked'
		#	console.log 'Like weghalen'
		#else
		#	console.log 'Like toevoegen'
		false

	$('#playlistItems .thumbdown').live 'click', (e) ->
		$(this).toggleClass 'disliked'
		#if $(this).hasClass 'disliked'
		#	console.log 'Dislike weghalen'
		#else
		#	console.log 'Dislike toevoegen'
		false

	$.templates { playlistItem: '#playlistItem' }
	$.link.playlistItem '#playlistItems', playlistData

addTrackToPlaylist = (e) ->
		$(e).toggleClass 'addTrack trackAdded'
		data = $.view($(e).parent().parent()).data
		$.observable(playlistData).insert playlistData.length, data
		newTrack = $('#playlistItems li:last').addClass 'new'
		setTimeout ( ->
			newTrack.removeClass 'new'
		), 3000
	
		console.log 'hoi'
		socket.emit 'addTrack', data	


$('#addTrack').live 'pagebeforecreate', () ->	
	$('#searchSubmit').bind 'click', (e) ->
		$('#searchResults').css 'display', 'block'
		
		$.ajax {
			type: 'POST',
			url: 'http://localhost:3000/search',
			data: { type: 'artist', query: $('#search-basic').val() }
			dataType: 'json', 
			success: (data) ->
				#console.log 'hoi'
				#console.log data
				#$.observable(searchData).data = data
				$.observable(searchData).refresh data
				#console.log $.observable(searchData)
		}	

	$('#searchItems .addTrack').live 'click', (e) ->
		addTrackToPlaylist(this)
		###
		$(this).toggleClass 'addTrack trackAdded'
		$.observable(playlistData).insert playlistData.length, $.view($(this).parent().parent()).data
		newTrack = $('#playlistItems li:last').addClass 'new'
		setTimeout ( ->
			newTrack.removeClass 'new'
		), 3000
		###
		false


	$.templates { searchItem: '#searchItem' }
	$.link.searchItem '#searchItems', searchData
	

$('#getSuggestions').live 'pagebeforecreate', () ->	
	$('#suggestionItems .addTrack').live 'click', (e) ->
		addTrackToPlaylist(this)
		###
		$(this).toggleClass 'addTrack trackAdded'
		$.observable(playlistData).insert playlistData.length, $.view($(this).parent().parent()).data
		newTrack = $('#playlistItems li:last').addClass 'new'
		setTimeout ( ->
			newTrack.removeClass 'new'
		), 3000
		###
		false
	
	$.templates { suggestionItem: '#suggestionItem' }
	$.link.suggestionItem '#suggestionItems', suggestionData


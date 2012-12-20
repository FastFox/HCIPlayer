playlistData = []

suggestionData = []

searchData = []

socket = io.connect settings.url

addTrackToPlaylist = (e) ->
		$(e).toggleClass 'addTrack trackAdded'
		data = $.view($(e).parent().parent()).data
		$.observable(playlistData).insert playlistData.length, data
		newTrack = $('#playlistItems li:last').addClass 'new'
		setTimeout ( ->
			newTrack.removeClass 'new'
		), 3000
	
		console.log 'hoi', socket
		socket.emit 'addTrack', data	

addTrackToPlaylistFromServer = (data) ->
		$.observable(playlistData).insert playlistData.length, data
		newTrack = $('#playlistItems li:last').addClass 'new'
		setTimeout ( ->
			newTrack.removeClass 'new'
		), 3000

socket.on 'setTitle', (title) ->
	$('.title').text title

$(document).ready () ->

	# Load playlist
	

	# set title
	if playlistData.length == 0
		$('.title').text 'HCIPlayer'
	else
		$('.title').text playlistData

	# events

	$('ul.list li').live 'click', (e) ->
		$(this).toggleClass('open closed').parent().children('.open').not(this).toggleClass 'open closed'

	socket.on 'newTrack', (data) ->
		addTrackToPlaylistFromServer data
		console.log data

	#socket.on 'getInfo', (data) ->
		#console.log data
		#
	
	socket.on 'sugTrack', (data) ->
		#console.log data
		#$.observable(suggestionData).refresh {}
		$.observable(suggestionData).insert suggestionData.length, data

	return true
	

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

$('#addTrack').live 'pagebeforecreate', () ->	
	$('#searchSubmit').bind 'click', (e) ->
		$.mobile.loading 'show'
		
		$.ajax {
			type: 'POST',
			url: settings.url + '/search',
			data: { type: 'artist', query: $('#search-basic').val() }
			dataType: 'json', 
			success: (data) ->
				#console.log 'hoi'
				#console.log data
				#$.observable(searchData).data = data
				$.observable(searchData).refresh data
				$('#searchResults').css 'display', 'block'
				$.mobile.loading 'hide'
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
	
$('#getSuggestions').live 'pageshow', () ->
	#$.mobile.loading 'show'

$('#getSuggestions').live 'pagebeforecreate', () ->
	#console.log 'hoi!'
	socket.emit 'reqSug'
	#$.mobile.loading 'hide'

	
	###
	$.ajax {
			type: 'POST',
			url: settings.url + '/suggestions',
			data: { }
			dataType: 'json', 
			success: (data) ->
				#console.log 'hoi'
				#console.log data
				#$.observable(searchData).data = data
				$.observable(suggestionData).refresh data
				#console.log $.observable(searchData)
	}	
	###

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


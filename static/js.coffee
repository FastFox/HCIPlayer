playlistData = []

suggestionData = []

searchData = []

socket = io.connect settings.url

addTrackToPlaylist = (e) ->
	#$(e).toggleClass 'addTrack trackAdded'
	data = $.view($(e).parent().parent()).data
	$.observable(playlistData).insert playlistData.length, data
	newTrack = $('#playlistItems li:last').addClass 'new'
	setTimeout ( ->
		newTrack.removeClass 'new'
	), 3000

	if playlistData.length == 1
		$('.title').text data.artist + ' — ' + data.title

	
	#console.log 'hoi', socket
	socket.emit 'addTrack', data	

addTrackToPlaylistFromServer = (data) ->
		$.observable(playlistData).insert playlistData.length, data
		newTrack = $('#playlistItems li:last').addClass 'new'
		setTimeout ( ->
			newTrack.removeClass 'new'
		), 3000
	
	if playlistData.length == 1
		$('.title').text data.artist + ' — ' + data.title

socket.on 'setTitle', (title) ->
	$('.title').text title

$(document).ready () ->

	# Load playlist
	

	# set title
	if playlistData.length == 0
		$('.title').text 'HCIPlayer'
	else
		$('.title').text playlistData
	
	
	# preload suggestions
	socket.emit 'reqSug', (data) ->
		$.observable(suggestionData).refresh data

	# events


	# Track openklappen voor meer informatie
	$('ul.list li').live 'click', (e) ->
		if $(this).hasClass 'open'
			$(this).toggleClass 'open closed'
		else
			$.mobile.loading 'show'
			# als meer info nodig
			#if 'album' in suggestionData[ $(this).index() ] == false
			#console.log suggestionData[ $(this).index() ].album
			console.log $.mobile.activePage.attr('id') 	

			that = this
			if $.mobile.activePage.attr('id') == 'getSuggestions' and suggestionData[ $(this).index() ].album == ''
				socket.emit 'trackInfo', $.observable(suggestionData).data()[ $(this).index() ].spotify, (data) ->
					$.observable(suggestionData[ $(that).index() ]).setProperty { album: data.album }
					$(that).toggleClass('open closed').parent().children('.open').not(that).toggleClass 'open closed'
					$.mobile.loading 'hide'
			else if $.mobile.activePage.attr('id') == 'addTrack' and searchData[ $(this).index() ].album == ''
				console.log $.observable(searchData).data()[ $(this).index() ]
				socket.emit 'trackInfo', $.observable(searchData).data()[ $(this).index() ].spotify, (data) ->
					console.log data
					$.observable(searchData[ $(that).index() ]).setProperty { album: data.album }
					$(that).toggleClass('open closed').parent().children('.open').not(that).toggleClass 'open closed'
					$.mobile.loading 'hide'
			else if $.mobile.activePage.attr('id') == 'playlist' and playlistData[ $(this).index() ].album == '' 
				socket.emit 'trackInfo', $.observable(playlistData).data()[ $(this).index() ].spotify, (data) ->
					$.observable(playlistData[ $(that).index() ]).setProperty { album: data.album }
					$(that).toggleClass('open closed').parent().children('.open').not(that).toggleClass 'open closed'
					$.mobile.loading 'hide'
			else
				$(that).toggleClass('open closed').parent().children('.open').not(that).toggleClass 'open closed'
				$.mobile.loading 'hide'



	# Door tabs swipen
	$('#playlist').bind 'swipeleft', (e) ->
		$.mobile.changePage $('#addTrack'), 'none'

	$('#addTrack').bind 'swipeleft', (e) ->
		$.mobile.changePage $('#getSuggestions'), 'none'

	$('#addTrack').bind 'swiperight', (e) ->
		$.mobile.changePage $('#playlist'), 'none'

	$('#getSuggestions').bind 'swiperight', (e) ->
		$.mobile.changePage $('#addTrack'), 'none'

	socket.on 'newTrack', (data) ->
		#addTrackToPlaylistFromServer data
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
		if $(this).hasClass 'addTrack'
			$(this).removeClass('addTrack').addClass 'trackAdded'
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


#$('#getSuggestions').live 'pagebeforecreate', () ->
	#$('#getSuggestions').live 'pagebeforeshow', () ->

$('#getSuggestions').live 'pageinit', () ->
	$('#suggestionItems .addTrack').live 'click', (e) ->
		#console.log 'doei', $(this)
		if $(this).hasClass 'addTrack'
			$(this).removeClass('addTrack').addClass 'trackAdded'

		addTrackToPlaylist(this)
		false
	
	$.templates { suggestionItem: '#suggestionItem' }
	$.link.suggestionItem '#suggestionItems', suggestionData
	#$('#suggestionItems').link true, suggestionData


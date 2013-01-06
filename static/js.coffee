playlistData = []

suggestionData = []

searchData = []

socket = io.connect settings.url

addTrackToPlaylist = (e) ->
	#$(e).toggleClass 'addTrack trackAdded'
	data = $.view($(e).parent().parent()).data
	data.up = 0;
	data.down = 0;
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

upVote = (index, amount) ->
	$.observable(playlistData[index]).setProperty { up: playlistData[index].up + amount }

downVote = (index, amount) ->
	$.observable(playlistData[index]).setProperty { down: playlistData[index].down + amount }

$(document).ready () ->

	# Load playlist
	socket.emit 'reqPlaylist', (data) ->	
		#console.log data
		$.observable(playlistData).refresh data

	# set title
	
	###
	if playlistData.length == 0
		$('.title').text 'HCIPlayer'
	else
		$('.title').text playlistData
	###
	
	
	# preload suggestions
	socket.emit 'reqSug', (data) ->
		$.observable(suggestionData).refresh data

	# preload images
	#console.log $('<img />')[0].src = '/images/icons-18-white.png';
	$('<img />')[0].src = '/images/thumbs_up.png';
	$('<img />')[0].src = '/images/thumbs_up_clicked.png';
	$('<img />')[0].src = '/images/thumbs_down.png';
	$('<img />')[0].src = '/images/thumbs_down_clicked.png';


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
			#console.log $.mobile.activePage.attr('id') 	

			that = this
			if $.mobile.activePage.attr('id') == 'getSuggestions' and suggestionData[ $(this).index() ].album == ''
				socket.emit 'trackInfo', $.observable(suggestionData).data()[ $(this).index() ].spotify, (data) ->
					$.observable(suggestionData[ $(that).index() ]).setProperty { album: data.album }
					$(that).toggleClass('open closed').parent().children('.open').not(that).toggleClass 'open closed'
					$.mobile.loading 'hide'
			else if $.mobile.activePage.attr('id') == 'addTrack' and searchData[ $(this).index() ].album == ''
				#console.log $.observable(searchData).data()[ $(this).index() ]
				socket.emit 'trackInfo', $.observable(searchData).data()[ $(this).index() ].spotify, (data) ->
					#console.log data
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


	# playlist sort popup
  
	$('#settings a').bind 'click', (e) ->
		$('#settings [data-theme="e"]').buttonMarkup { theme: 'c' }
		$(this).parent().parent().parent().buttonMarkup { theme: 'e' }
		$('#settings').popup 'close'
		false

	# Door tabs swipen
	#console.log $.mobile.activePage.attr('id') 	

	$('body').bind 'swipeleft', (e) ->
			if $.mobile.activePage.attr('id') == 'playlist'
				$.mobile.changePage $('#addTrack'), { transition: 'slide' }

			else if $.mobile.activePage.attr('id') == 'addTrack'
				$.mobile.changePage $('#getSuggestions'), { transition: 'slide' }
	
	$('body').bind 'swiperight', (e) ->
			if $.mobile.activePage.attr('id') == 'addTrack'
				$.mobile.changePage $('#playlist'), { transition: 'reverse slide' }
			else if $.mobile.activePage.attr('id') == 'getSuggestions'
				$.mobile.changePage $('#addTrack'), { transition: 'reverse slide' }
			 	
	socket.on 'setTitle', (title) ->
		$('.title').text title

	socket.on 'nextTrack', () ->
		$.observable(playlistData).remove 0, 1
		$('.title').text playlistData[0].artist + ' — ' + playlistData[0].title

	socket.on 'newTrack', (data) ->
		addTrackToPlaylistFromServer data
		if playlistData.length == 1
			$('.title').text data.artist + ' — ' + data.title

	
	socket.on 'sugTrack', (data) ->
		#console.log data
		#$.observable(suggestionData).refresh {}
		$.observable(suggestionData).insert suggestionData.length, data

	socket.on 'upVote', (data) ->
		upVote data.index, data.amount
	
	socket.on 'downVote', (data) ->
		downVote data.index, data.amount

	return true
		



$('#playlist').live 'pagebeforecreate', () ->	
	$('#playlistItems .thumbup').live 'click', (e) ->
		index = $(this).parent().parent().index()
		if $(this).hasClass 'liked' # Cancel vote
			$(this).removeClass 'liked'
			upVote index, -1
			socket.emit 'upVote', index, -1
		else
			if $(this).next().hasClass 'disliked' # Cancel downVote
				$(this).next().removeClass 'disliked'
				downVote index, -1
				socket.emit 'downVote', index, -1

			$(this).addClass 'liked'
			upVote index, 1
			socket.emit 'upVote', index, 1
		false

	$('#playlistItems .thumbdown').live 'click', (e) ->
		index = $(this).parent().parent().index()
		if $(this).hasClass 'disliked' # Cancel downVote
			$(this).removeClass 'disliked'
			downVote index, -1
			socket.emit 'downVote', index, -1
		else
			if $(this).prev().hasClass 'liked' # Cancel vote
				$(this).prev().removeClass 'liked'
				upVote index, -1
				socket.emit 'upVote', index, -1

			$(this).addClass 'disliked'
			downVote index, 1
			socket.emit 'downVote', index, 1

		false

	$.templates { playlistItem: '#playlistItem' }
	$.link.playlistItem '#playlistItems', playlistData

$('#addTrack').live 'pagebeforecreate', () ->	
	$('#searchSubmit').bind 'click', (e) ->
		$.mobile.loading 'show'
		
		socket.emit 'search', $('#search-basic').val(), (data) ->
			$.observable(searchData).refresh data
			$('#searchResults').css 'display', 'block'
			$.mobile.loading 'hide'

		###	
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
		###

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


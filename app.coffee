express = require 'express'
spotify = require 'spotify'
echonest = require 'echonest'

settings = require './settings'

http = require 'http'
app = express()
server = app.listen settings.port
io = require('socket.io').listen server

app.use express.static(__dirname+'/static')
app.use express.bodyParser()

nest = new echonest.Echonest { api_key: 'PCG7Z9OEOD91S20SU' }

implodeArtists = (artists) ->
	first = true
	for artist in artists
		if first
			string = artist.name
			first = false
		else
			string += ", " + artist.name
	string

io.on 'connection', (socket) ->
	#console.log socket
	

	#socket.emit 'setTitle', 'Now playing'

	socket.on 'nextTrack', () ->
		socket.broadcast.emit 'nextTrack'

	socket.on 'addTrack', (data) ->
		socket.broadcast.emit 'newTrack', data
	
	socket.on 'trackInfo', (id, fn) ->
		console.log id	
		spotify.lookup { type: 'track', id: id.replace('spotify-WW:track:', '') }, (err, res) ->
			fn( { album: res.track.album.name } )

	socket.on 'reqSug', (fn) ->
		#socket.emit 'sugTrack', { 'hoi' }

		console.log 'load from cache'
		fn require './suggestions.json'
		###
		nest.song.search { 
			results: '25',
			sort: 'song_hotttnesss-desc',
			bucket: ['id:spotify-WW', 'tracks']
		}, (error, response) ->
			suggestionData = []
					#spotify.lookup { type: 'track', id: response.songs[0].id }, (err, res) ->
						#console.log res
			`for( i = 0; i < response.songs.length; i++ ) {
				if( response.songs[i].tracks.length === 0 ) {
					//response.songs.splice(i, 1);
					//i--;
				} else {
					
					//console.log(response.songs[i]);
					//console.log(i, response.songs.length
					//socket.emit('sugTrack', { artist: response.songs[i].artist_name, title: response.songs[i].title, spotify: response.songs[i].tracks[0].foreign_id, last: i == response.songs.length - 1 });
					//console.log(response.songs[i]);
					suggestionData.push({ artist: response.songs[i].artist_name, title: response.songs[i].title, spotify: response.songs[i].tracks[0].foreign_id, album: '' });
						
					//console.log('hoi');
				}
			}`

			#console.log JSON.stringifi(suggestionData)
			fn suggestionData
			return true
	###
###
spotify.get  '/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ', (err, res) ->
	console.log res
###

#spotify.lookup { type: 'track', id: '3zBhJBEbDD4a4SO1EaEiBP' }, (err, res) ->
#spotify.lookup { type: 'track', id: '5iwuX6Bx05LHz7cEZex92' }, (err, res) ->

	#console.log res

#	bla = 'hoi'

#url = 'http://ws.spotify.com/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=album'

app.post '/search', (req, res) ->
	#console.log req.body
	tracks = []

	spotify.search { type: 'track', query: req.body.query }, (err, result) ->
		for track in result.tracks
			tracks.push {
				title: track.name,
				artist: implodeArtists(track.artists),
				album: track.album.name
			}

		console.log tracks
		res.json tracks

	###
	nest.song.search { 
		combined: req.body.query,
		results: '5',
		sort: 'song_hotttnesss-desc',
		bucket: ['id:spotify-WW', 'tracks']
	}, (error, response) ->
		console.log error
		#console.log response

		tracks = []
		
		`for( i = 0; i < response.songs.length; i++ ) {
			if( response.songs[i].tracks.length === 0 ) {
				//response.songs.splice(i, 1);
				//i--;
			} else {
				tracks.push( { 
					artist: response.songs[i].artist_name,
					title: response.songs[i].title,
					spotify: response.songs[i].tracks[0].foreign_id,
					album: ''
				} );
			}

		}`

		console.log tracks
		res.json tracks
	###

app.post '/suggestions', (req, res) ->
	#console.log req.body
	

	spotList = []


	nest.song.search { 
		results: '25',
		sort: 'song_hotttnesss-desc',
		bucket: ['id:spotify-WW', 'tracks']
	}, (error, response) ->
		#console.log response
		#console.log error
		#console.log response.songs, 'hoi'
	

		#spotify.lookup { type: 'track', id: response.songs[0].id }, (err, res) ->
			#console.log res
		
		## Verwijder alle tracks met 0 spotify tracks
		`for( i = 0; i < response.songs.length; i++ ) {
			if( response.songs[i].tracks.length === 0 ) {
				response.songs.splice(i, 1);
				i--;
			}
		}`

		res.json response.songs

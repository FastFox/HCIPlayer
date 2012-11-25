express = require 'express'
spotify = require 'spotify'
echonest = require 'echonest'
http = require 'http'
app = express()
server = app.listen 3000
io = require('socket.io').listen server

app.use express.static(__dirname+'/static')
app.use express.bodyParser()

nest = new echonest.Echonest { api_key: 'PCG7Z9OEOD91S20SU' }


io.on 'connection', (socket) ->
	#console.log socket
	socket.on 'addTrack', (data) ->
		console.log data

###
spotify.get  '/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ', (err, res) ->
	console.log res
###

#spotify.lookup { type: 'track', id: '3zBhJBEbDD4a4SO1EaEiBP' }, (err, res) ->
#	console.log res

#	bla = 'hoi'

#url = 'http://ws.spotify.com/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=album'

app.post '/search', (req, res) ->
	#console.log req.body
	nest.song.search { 
		combined: req.body.query,
		results: '15',
		sort: 'song_hotttnesss-desc',
		bucket: ['id:spotify-WW', 'tracks']
	}, (error, response) ->
		console.log error
		#console.log response
		#console.log response.songs, 'hoi'
		
		## Verwijder alle tracks met 0 spotify tracks
		`for( i = 0; i < response.songs.length; i++ ) {
			if( response.songs[i].tracks.length === 0 ) {
				response.songs.splice(i, 1);
				i--;
			}
		}`
		##		#for i = 0; i < response.songs.length; i++
	
			#console.log i

		console.log response.songs

		#for sIndex, sData of response.songs
		#	if sData.tracks.length is 0
		#		console.log sData.tracks.length, sIndex
		#		response.songs.splice sIndex, 1
		#	else
		#		console.log sData.tracks.length, 'length'
			#console.log sData
			#for tIndex, tData of sData.tracks
				#console.log tData
				#console.log tData.foreign_id.replace('spotify-WW:track:', '')
				#spotify.lookup { type: 'track', id: tData.foreign_id.replace('spotify-WW:track:', '') }, (err, res) ->
				#if track.
				#	console.log res
		#console.log response.songs

		res.json response.songs
	#res.json { bla: 'hoi' }



###
app.post '/search', (req, res) ->
	console.log req.body.query, req.body.type
	spotify.search { type: 'track',	query: req.body.query }, (err, data) ->
		if err
			console.log 'Error', err
		else
			#console.log err, data
			res.json data.tracks.slice(0, 10);

	#res.json hoi
###
#
#app.listen 3000


app.post '/suggestions', (req, res) ->
	#console.log req.body
	nest.song.search { 
		results: '25',
		sort: 'song_hotttnesss-desc',
		bucket: ['id:spotify-WW', 'tracks']
	}, (error, response) ->
		#console.log response
		#console.log response.songs, 'hoi'
		
		## Verwijder alle tracks met 0 spotify tracks
		`for( i = 0; i < response.songs.length; i++ ) {
			if( response.songs[i].tracks.length === 0 ) {
				response.songs.splice(i, 1);
				i--;
			}
		}`
		res.json response.songs

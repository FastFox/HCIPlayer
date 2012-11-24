express = require 'express'
spotify = require 'spotify'
echonest = require 'echonest'
http = require 'http'
app = express()
io = require 'socket.io'
server = http.createServer app
io = io.listen(server)
app.listen 3000

app.use express.static(__dirname+'/static')
app.use express.bodyParser()

nest = new echonest.Echonest { api_key: 'PCG7Z9OEOD91S20SU' }


io.sockets.on 'connection', (socket) ->
	console.log socket

###
spotify.get  '/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ', (err, res) ->
	console.log res
###

#spotify.lookup { type: 'track', id: '3zBhJBEbDD4a4SO1EaEiBP' }, (err, res) ->
#	console.log res

#	bla = 'hoi'

#url = 'http://ws.spotify.com/lookup/1/.json?uri=spotify:artist:4YrKBkKSVeqDamzBPWVnSJ&extras=album'

app.post '/search', (req, res) ->
	nest.song.search { 
		combined: 'Above & beyond Good for me',
		results: '3',
		bucket: ['id:spotify-WW', 'tracks']
	}, (error, response) ->
		#for sIndex, sData of response.songs
			#console.log sData
			#for tIndex, tData of sData.tracks
				#console.log tData
				#console.log tData.foreign_id.replace('spotify-WW:track:', '')
				#spotify.lookup { type: 'track', id: tData.foreign_id.replace('spotify-WW:track:', '') }, (err, res) ->
				#if track.
				#	console.log res

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

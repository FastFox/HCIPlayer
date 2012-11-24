express = require 'express'
app = express()

app.use express.static(__dirname+'/static')

app.post '/search', (req, res) ->
	#console.log req
	hoi = { bla: 'doei' }
	res.json hoi

app.listen 3000

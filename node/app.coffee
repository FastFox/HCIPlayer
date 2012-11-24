express = require 'express'
app = express()

app.configure ->
	app.use express.methodOverride()
	app.use express.bodyParser()
	app.use app.router



app.post '/search', (req, res) ->
	#console.log req
	hoi = { bla: 'doei' }
	res.json hoi

app.listen 3000

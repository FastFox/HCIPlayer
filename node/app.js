// Generated by CoffeeScript 1.3.3
var app, express;

express = require('express');

app = express();

app.configure(function() {
  app.use(express.methodOverride());
  app.use(express.bodyParser());
  return app.use(app.router);
});

app.post('/search', function(req, res) {
  var hoi;
  hoi = {
    bla: 'doei'
  };
  return res.json(hoi);
});

app.listen(3000);

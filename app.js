// Generated by CoffeeScript 1.3.3
var app, express;

express = require('express');

app = express();

app.use(express["static"](__dirname + '/static'));

app.post('/search', function(req, res) {
  var hoi;
  hoi = {
    bla: 'doei'
  };
  return res.json(hoi);
});

app.listen(3000);
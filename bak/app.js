(function() {
  var Product, ProductSchema, Schema, app, express, io, mongoose;
  express = require('express');
  app = express.createServer();
  io = require('socket.io').listen(app);
  mongoose = require('mongoose');
  Schema = mongoose.Schema;
  ProductSchema = new Schema({
    name: String,
    place: [],
    image: String
  });
  mongoose.model('Product', ProductSchema);
  mongoose.connect('mongodb://localhost/mecca');
  Product = mongoose.model('Product');
  app.register('.coffee', require('coffeekup'));
  app.set('views', __dirname + '/views');
  app.set('view engine', 'coffee');
  app.configure(function() {
    return app.use(express.static(__dirname + '/public'));
  });
  app.listen(8080);
  app.get('/', function(req, res) {
    return res.render('index.coffee');
  });
  app.get('/js/:name', function(req, res) {});
  app.get('/product/:id', function(req, res) {
    return res.render('product.coffee', {
      locals: {
        id: req.params.id
      }
    });
  });
  io.sockets.on('connection', function(socket) {
    socket.on('my other event', function(data) {});
    socket.on('search', function(query) {
      var q;
      q = new RegExp("^" + query);
      return Product.find({
        name: q
      }, function(err, docs) {
        var data, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = docs.length; _i < _len; _i++) {
          data = docs[_i];
          _results.push((function(data) {
            return socket.emit('searchresult', data);
          })(data));
        }
        return _results;
      });
    });
    socket.on('getproduct', function(id) {
      console.log(id);
      return Product.find({
        _id: id
      }, function(err, docs) {
        return socket.emit('product', docs[0]);
      });
    });
    socket.on('getgeo', function(adr) {
      return http.request();
    });
    return socket.on('disconnect', function() {
      return socket.emit('user disconnected');
    });
  });
}).call(this);

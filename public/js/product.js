(function() {
  window.addEvent('domready', function() {
    var id, socket;
    id = $('param').value;
    socket = io.connect(window.location.hostname);
    socket.on('connect', function() {});
    socket.on('product', function(data) {
      var adr, div, img, p, req;
      div = new Element('div');
      p = new Element('p').appendText(data.name + ':' + data.place[0]);
      img = new Element('img', {
        src: '/image/' + data.image,
        style: 'height:300px'
      });
      $('main').grab(div).grab(img);
      $('main').grab(div).grab(p);
      adr = '聖蹟桜ヶ丘';
      socket.emit('getgeo', adr);
      req = new Request({
        url: 'http://maps.google.com/maps/api/geocode/json?sensor=false&address=' + adr,
        onSuccess: function() {},
        onFailure: function(xhr) {
          return alert(xhr.responseText);
        }
      });
      return req.get();
    });
    return socket.emit('getproduct', id);
  });
}).call(this);

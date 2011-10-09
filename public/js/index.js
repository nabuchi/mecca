(function() {
  window.addEvent('domready', function() {
    var socket;
    socket = io.connect(window.location.hostname);
    socket.on('connect', function() {});
    socket.on('searchresult', function(data) {
      var a, div, img, p;
      div = new Element('div');
      p = new Element('p').appendText(data.name + ':' + data.place);
      a = new Element('a', {
        href: 'product/' + data._id
      }).appendText('id');
      img = new Element('img', {
        src: 'image/' + data.image,
        style: 'height:100px'
      });
      $('result').grab(div).grab(img);
      $('result').grab(div).grab(p);
      return $('result').grab(div).grab(a);
    });
    $('search').addEvent('click', function() {});
    return $('searchbox').addEvent('keyup', function() {
      var data;
      $('result').empty();
      data = $('searchbox').value;
      if (data !== '') {
        return socket.emit('search', $('searchbox').value);
      }
    });
  });
}).call(this);

(function() {
  window.addEvent('domready', function() {
    var makeitem, socket;
    makeitem = function(data) {
      var img, item, p1, p2, table, td1, td2, td3, tr1, tr2;
      item = new Element('div', {
        "class": 'item'
      });
      table = new Element('table');
      img = new Element('img', {
        src: 'image/' + data.image,
        style: 'height:100px'
      });
      td1 = new Element('td', {
        rowspan: 2
      }).grab(img);
      p1 = new Element('p', {
        "class": 'title'
      }).appendText(data.name);
      p2 = new Element('p', {
        "class": 'place'
      }).appendText(data.place);
      td2 = new Element('td').grab(p1);
      td3 = new Element('td').grab(p2);
      tr1 = new Element('tr');
      tr2 = new Element('tr');
      tr1.grab(td1);
      tr1.grab(td2);
      tr2.grab(td3);
      item.grab(table);
      table.grab(tr1);
      table.grab(tr2);
      return item;
    };
    socket = io.connect(window.location.hostname);
    socket.on('connect', function() {});
    socket.on('searchresult', function(data) {
      var a, div, img, p;
      div = new Element('div', {
        html: '<table><tr><td>img</td></tr><td>タイトル</tr></table>'
      });
      p = new Element('p').appendText(data.name + ':' + data.place);
      a = new Element('a', {
        href: 'product/' + data._id
      }).appendText('id');
      img = new Element('img', {
        src: 'image/' + data.image,
        style: 'height:100px'
      });
      return $('result').grab(makeitem(data));
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

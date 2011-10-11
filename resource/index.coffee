window.addEvent('domready', ->
    socket = io.connect(window.location.hostname)
    socket.on('connect', ->
    )
    socket.on('searchresult', (data)->
        div = new Element('div', {html:
            '<table><tr><td>img</td></tr><td>タイトル</tr></table>'
        })
        p = new Element('p').appendText(data.name+':'+data.place)
        a = new Element('a', {href: 'product/'+data._id}).appendText('id')
        img = new Element('img', {src: 'image/'+data.image, style: 'height:100px'})
        $('result').grab(div).grab(img)
        $('result').grab(div).grab(p)
        $('result').grab(div).grab(a)
    )
    $('search').addEvent('click', ->
    )
    $('searchbox').addEvent('keyup', ->
        $('result').empty()
        data = $('searchbox').value
        socket.emit('search', $('searchbox').value) if data!=''
    )
)

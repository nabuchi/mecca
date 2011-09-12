coffeescript ->
    window.addEvent('domready', ->
            socket = io.connect('http://localhost:8080')
            socket.on('connect', ->
            )
            socket.on('searchresult', (data)->
                div = new Element('div')
                p = new Element('p').appendText(data.name+':'+data.place)
                a = new Element('a', {href: 'product/'+data._id}).appendText('id')
                img = new Element('img', {src: 'image/'+data.image, style: 'height:100px'})
                $('result').grab(div).grab(img)
                $('result').grab(div).grab(p)
                $('result').grab(div).grab(a)
            )
            $('search').addEvent('click', ->
                alert($('searchbox').value)
            )
            $('searchbox').addEvent('keyup', ->
                data = $('searchbox').value
                socket.emit('search', $('searchbox').value) if data!=''
            )
        )

body ->
    h1 'Mecca 〜舞台探訪支援サイト〜'
    div id: 'main', ->
        input type: 'text', id: 'searchbox'
        button id: 'search', -> '検索'
        div id: 'result'

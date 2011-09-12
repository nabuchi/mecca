coffeescript ->
    window.addEvent('domready', ->
            id = $('param').value
            socket = io.connect('http://localhost:8080')
            socket.on('connect', ->
            )
            socket.on('product', (data)->
                div = new Element('div')
                p = new Element('p').appendText(data.name+':'+data.place[0])
                img = new Element('img', {src: '/image/'+data.image, style: 'height:300px'})
                $('main').grab(div).grab(img)
                $('main').grab(div).grab(p)
                adr = '聖蹟桜ヶ丘'
                socket.emit('getgeo', adr)
                req = new Request({
                    url : 'http://maps.google.com/maps/api/geocode/json?sensor=false&address='+adr,
                    #url : '/'
                    onSuccess: ->
                        alert(444)
                    onFailure: (xhr)->
                        alert(xhr.responseText)
                })
                req.get()
                    #url: '/'
                    #method: 'get'
                    #onRequest: ->
                    #    alert(111)
                    #onLoadstart: ->
                    #    alert(999)
                    #onSuccess: (res)->
                        #alert(res.results.address_components.long_name)
                    #    alert(333)
                    #onFailure: ->
                    #    alert(444)
            )
            socket.emit('getproduct', id)
        )
body ->
    h1 'Mecca 〜舞台探訪支援サイト〜'
    hr ->
    div id: 'main', ->
        input type: 'hidden', id: 'param', value: id

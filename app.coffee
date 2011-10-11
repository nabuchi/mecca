express = require('express')
app = express.createServer()
io = require('socket.io').listen(app)

## mongoose
mongoose = require('mongoose')

Schema = mongoose.Schema
ProductSchema = new Schema({
    name: String,
    place: []
    image: String,
})

mongoose.model('Product', ProductSchema)
mongoose.connect('mongodb://localhost/mecca')
Product = mongoose.model('Product')

## setting
app.configure(->
    this.set 'views', __dirname + '/views'
    this.set 'view engine', 'coffee'
    this.register '.coffee', require 'coffeekup'

    this.use(express.static(__dirname + '/public'))
    this.use(require("stylus").middleware({
        src: __dirname + "/public/css",
        compress: true
    }))
)
app.listen(8080)

## sinatra
app.get('/', (req, res)->
    res.render 'index.coffee', {
        js: ['/js/index.js']
    }
)
app.get('/js/:name', (req, res)->
)
app.get('/product/:id', (req, res)->
    res.render 'product.coffee', {
         id: req.params.id,
         js: ['/js/product.js']
    }
)

## socket.io
io.sockets.on('connection', (socket)->
    socket.on('my other event', (data)->
    )
    socket.on('search', (query)->
        q = new RegExp("^"+query)
        Product.find({name:q}, (err, docs)->
            for data in docs
                do (data)->
                    socket.emit('searchresult', data)
        )
    )
    socket.on('getproduct', (id)->
        Product.find({_id:id}, (err, docs)->
            socket.emit('product', docs[0])
        )
    )
    socket.on('getgeo', (adr)->
        http.request()
    )
    socket.on('disconnect', ->
        socket.emit('user disconnected')
    )
)


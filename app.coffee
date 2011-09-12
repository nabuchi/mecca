express = require('express')
app = express.createServer()
io = require('socket.io').listen(app)
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
#product = new Product()
#product.name = '耳をすませば'
#product.place = ['聖蹟桜ヶ丘駅', '東京都']
#product.save()
#Product.find({name:/^耳を/}, (err, docs)->
#    for data in docs
#        do (data)->
#            console.log(data)
#)

app.register '.coffee', require 'coffeekup'
app.set 'views', __dirname + '/views'
app.set 'view engine', 'coffee'

app.configure(->
    app.use(express.static(__dirname + '/public'))
)
app.listen(8080)

app.get('/', (req, res)->
    res.render 'index.coffee'
)
app.get('/js/:name', (req, res)->
)
app.get('/product/:id', (req, res)->
    res.render('product.coffee', locals: {id: req.params.id})
)

io.sockets.on('connection', (socket)->
    socket.on('my other event', (data)->
        #console.log(data)
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
        console.log(id)
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


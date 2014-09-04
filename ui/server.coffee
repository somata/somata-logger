config = require './config'
app = require('somata-socketio').setup_app config.app

app.get '/', (req, res) ->
    res.render 'base'

app.start()


express = require('express')
http = require('http')
mongoose = require('mongoose')
# custom imports
config = require('./config')
routes = require('./routes')

app = express()

# middleware configs. Took the environment into consideration
config.setup(app, express)

# start the routing
routes(app)

app.listen(app.get('port'), ->
	console.log 'Express server running'
)

mongoose.connect(config.db.url, (err)->
	throw err if err
	console.log 'mongo running'
)
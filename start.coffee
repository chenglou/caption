express = require('express')
routes = require('./routes')
http = require('http')
# path used for path.join() below
path = require('path')
# custom imports
config = require('./config')
app = express()

# middleware configs. Took the environment into consideration
config.setup(app, express, path)

# start the routing
routes(app)

app.listen(app.get('port'), ->
	console.log 'Express server running'
)
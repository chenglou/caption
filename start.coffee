express = require('express')
http = require('http')
# path no longer used for path.join() in config.setup()
# path = require('path')
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
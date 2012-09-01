dev =
	db:
		url: 'mongodb://localhost:27017/'
	port: 80
	setup: devSetup

prod =
	db:
		url: 'mongodb://amazon' # TODO replace with actual prod url
	port: 80
	setup: prodSetup

# initialize the middlewares and settings for app
commonSetup = (app, express, path)->
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.use express.favicon()
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.errorHandler()
	app.use app.router
	app.use express.static(path.join(__dirname, 'client'))

devSetup = (app, express, path)->
	commonSetup(app, express, path)
	app.set 'env', 'development'
	app.set 'port', dev.port
	app.use express.logger 'dev'
	app.use express.errorHandler()

prodSetup = (app, express, path)->
	commonSetup(app, express, path)
	app.set 'env', 'production'
	app.set 'port', prod.port
	app.use express.logger()

module.exports = dev


		


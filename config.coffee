# initialize the middlewares and settings for app
commonSetup = (app, express)->
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.use express.favicon()
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.errorHandler()
	app.use app.router
	app.use express.static('#{__dirname}/client')

devSetup = (app, express)->
	app.set 'env', 'development'
	app.set 'port', dev.port
	# logger should come before response manipulation
	app.use express.logger 'dev'
	app.use express.errorHandler()
	commonSetup(app, express)

prodSetup = (app, express)->
	app.set 'env', 'production'
	app.set 'port', prod.port
	app.use express.logger()
	commonSetup(app, express)

dev =
	db:
		url: 'mongodb://localhost:27017/'
	image:
		url: '/images'
	port: 80
	setup: devSetup

prod =
	db:
		url: 'mongodb://amazon' # TODO replace with actual prod url
	image:
		url: '/images' # TODO replace with actual prod url
	port: 80
	setup: prodSetup

module.exports = dev


		


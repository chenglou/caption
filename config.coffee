stylus = require 'stylus'

staticPath = __dirname + '/client'

# initialize the middlewares and settings for app
commonSetup = (app, express)->
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.use express.compress()
	app.use(express.static(staticPath))
	app.use express.favicon()
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.errorHandler()
	# app.use express.session()
	# app.use express.cookieParser()
	# app.use express.csrf()	
	app.use app.router
	# error page. Comes last
	# the form (err, req, res, next) is only picked up by next(something). General 404 not picked
	app.use (req, res, next)->
		if req.accepts 'html'
			res.status 404
			res.render '404'
			return
		if req.accepts 'json'
    		res.send { error: '400' }
    		return

devSetup = (app, express)->
	app.set 'env', 'development'
	app.set 'port', dev.port
	# logger should come before response manipulation
	app.use express.logger 'dev'
	app.use express.errorHandler()
	# compile styl into css
	app.use(stylus.middleware(
		src: __dirname + '/client_src'
		dest: staticPath
		compile: (str, path)-> stylus(str).set('filename', path)
	))
	commonSetup(app, express)

prodSetup = (app, express)->
	app.set 'env', 'production'
	app.set 'port', prod.port
	app.use express.logger()
	# compile styl into css. Compress
	app.use(stylus.middleware(
		src: __dirname + '/client_src'
		dest: staticPath
		compile: (str, path)-> stylus(str).set('filename', path).set('compress', true)
	))
	commonSetup(app, express)

dev =
	db:
		url: 'mongodb://localhost:27017/mongodb'
	imageRepo:
		# absolute path. Don't use this for client-side-related paths
		url: __dirname + '/client/images'
		# somewhere private
		tempUrl: __dirname + '/_uploaded_images'
	port: 80
	setup: devSetup

prod =
	db:
		url: 'mongodb://amazon' # TODO: replace with actual prod url
	imageRepo:
		url: 'client/images' # TODO: replace with actual prod url
		tempUrl: __dirname + '/_uploaded_images'
	port: 80
	setup: prodSetup

module.exports = dev
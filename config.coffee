# compile stylus on the fly
stylus = require 'stylus'

# TODO: might put these functions into modules in the future
errorHandler404 = ()->
	# catch 404, which doesn't throw argument in next() for some reason
		return (req, res, next)->
			if req.accepts 'html'
				res.status 404
				res.render '404'
				return
			if req.accepts 'json'
				res.send { error: '400' }
				return

errorHandler = ()->
		return (err, req, res, next)->
			if req.accepts 'html'
				res.status 404
				res.render '404'
				res.end
				return
			if req.accepts 'json'
				res.send { error: '400' }
				res.end
				return

validateUploadTypes = ()->
	return (req, res, next)->


devSetup = (app, express)->
	app.set 'env', 'development'
	app.set 'port', dev.port
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	# logger should come before response manipulation
	app.use express.logger 'dev'
	# compile styl into css
	app.use(stylus.middleware(
		src: __dirname + '/client_src'
		dest: dev.staticPath
		compile: (str, path)-> stylus(str).set('filename', path)
	))
	app.use(express.static(dev.staticPath))
	app.use express.limit '1mb'
	app.use express.bodyParser
		uploadDir: dev.imageRepo.tempUrl
		keepExtensions: true
	app.use express.compress()
	app.use express.favicon()
	app.use express.methodOverride()
	# app.use express.session()
	# app.use express.cookieParser()
	# app.use express.csrf()	
	app.use app.router
	
	app.use errorHandler404()

	app.use (err, req, res, next)->
		# upload file size too large
		if err.status is 413
			res.send {error: '413', message: 'file too large'}
			res.end
			return
		else
			next(err)

	app.use errorHandler()
	# technically, the previous two cases handled the errors. This shouldn't trigger
	app.use express.errorHandler()

prodSetup = (app, express)->
	app.set 'env', 'production'
	app.set 'port', prod.port
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.use express.logger()
	# compile styl into css. Compress
	app.use(stylus.middleware(
		src: __dirname + '/client_src'
		dest: prod.staticPath
		compile: (str, path)-> stylus(str).set('filename', path).set('compress', true)
	))
	app.use(express.static(prod.staticPath))
	app.use express.bodyParser
		uploadDir: prod.imageRepo.tempUrl
		keepExtensions: true
	app.use express.compress()
	app.use express.favicon()
	app.use express.methodOverride()
	# app.use express.session()
	# app.use express.cookieParser()
	# app.use express.csrf()	
	app.use app.router
	
	app.use errorHandler404()

	app.use (err, req, res, next)->
		# upload file size too large
		if err.status is 413
			res.send {error: '413', message: 'file too large'}
			res.end
			return
		else
			next(err)

	app.use errorHandler()

dev =
	staticPath: __dirname + '/client'
	db:
		url: 'mongodb://localhost:27017/mongodb'
	imageRepo:
		# absolute path. Don't use this for client-side-related paths
		url: __dirname + '/client/images'
		# somewhere private
		tempUrl: __dirname + '/uploaded_images'
	port: 80
	setup: devSetup

prod =
	staticPath: __dirname + '/client'
	db:
		url: 'mongodb://amazon' # TODO: replace with actual prod url
	imageRepo:
		url: 'client/images' # TODO: replace with actual prod url
		tempUrl: __dirname + '/uploaded_images'
	port: 80
	setup: prodSetup

module.exports = dev
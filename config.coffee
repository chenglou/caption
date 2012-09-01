
# initialize the middlewares for app
setup = (app, express, path)->
	# middlewares for all environment
	app.set 'port', 80
	app.set 'views', "#{__dirname}/views"
	app.set 'view engine', 'jade'
	app.use express.favicon()
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.errorHandler()
	app.use app.router
	app.use express.static(path.join(__dirname, 'client'))

	# middleware for dev
	if app.get('env') is 'development'
		app.use express.logger 'dev'
		app.use express.errorHandler()

	# middleware for prod
	if app.get('env') is 'production'
		app.use express.logger()

# glorified conditional for setting env vars
env = (dev, prod)->
	if process.env.NODE_ENV is 'development' then dev else prod

# TODO might change the format to give each env its own obj, then export the corresponding one
# Optimal if obj keys are different across envs
modules.exports =
	setup: setup
	db:
		url: env 'mongodb://localhost:27017/', 'mongodb://amazon' # TODO replace with actual prod url


		


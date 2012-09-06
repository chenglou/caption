###
read: stuff like express.limit() need to be specific for each route.
A second use doesn't override the first one, so defining it before the
route callback doesn't work. If limit() needs to vary then it needs to
be added manually to each route call, which is tedious. Additionally,
everything that necessarily come after limit(), such as bodyParser,
would need to be inserted manually each time.
This function patch this problem by organizing the calls
###

# every variable middleware
uploadValidator = require './uploadValidator'
express = require 'express'
config = require '../config'
###
variable middlewares:
potentially express.static
express.limit
express.bodyParser
uploadValidator
###

# ordinary case
normalConfig = [
	{
		name: 'limit'
		func: express.limit
		caller: express
		args: ['500kb']
	}
	{
		name: 'bodyParser'
		func: express.bodyParser
		caller: express
		args: [{
			uploadDir: config.imageRepo.tempUrl
			keepExtensions: true
		}]
	}
	{
		name: 'uploadValidator'
		func: uploadValidator
		caller: null
		args: []
	}
]

# usage: dynamicMiddleware [{name: 'limit', args: ['1mb']}, {etc.}]
# which means that the middleware must have a unique name
module.exports = (customParamsArray)->
	bakedMiddlewares = []
	for oneConfig in normalConfig
		if customParamsArray isnt undefined
			for customParam in customParamsArray
				if customParam.name == oneConfig.name
					oneConfig.args = customParam.args
		# replacing done, if any
		bakedMiddlewares.push(oneConfig.func.apply oneConfig.caller, oneConfig.args)
	return bakedMiddlewares

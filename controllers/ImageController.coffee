Image = require('../models').Image
config = require('../config')
fs = require('fs')

# handles the index route even though image.index doesn't exist in shared/routes
exports.index = (req, res)->
	res.render 'layout'

# map to the image and send it. Reason: need to make prior adjustments, e.g. add a site footer
exports.view = (req, res)->
	# params[0] should be the id
	#res.send 404, 'test'
	console.log req.params[0]
	# in the future, get the actual image name
	res.sendfile config.imageRepo.url + '/1.jpg', (err)->
		throw err if err

exports.apiIndex = (req, res, next)->
	# FIXME: check if request must be in json
	#if !req.is 'json' then next() #res.send 400, 'The request must be in json'
	# else

	# find newest
	Image
	.find()
	.sort({createdAt: 'descending'})
	.limit(10)
	.exec((err, results)->
		# TODO: better error handling
		if err then next()
		else res.json results
	)

exports.apiCreate = (req, res, next)->
	test = new Image(
		name: 'haha.jpg'
	)
	test.save((err)->
		if err then next()
		else res.json {} # TODO: check what to send to trigger succeess
	)

exports.apiDelete = (req, res, next)->
	Image.find({})
	# delete image too
	test.save((err)->
		if err then next()
		else res.json {}
	)

module.exports = exports
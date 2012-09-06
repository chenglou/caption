Image = require('../models/Image')
config = require('../config')
fs = require('fs')
validations = require '../client/js/shared/validations'

# handles the index route even though image.index doesn't exist in shared/routes
exports.index = (req, res, next)->
	res.render 'layout'

# map to the image and send it. Reason: need to make prior adjustments, e.g. add a site footer
exports.view = (req, res, next)->
	# params[0] should be the id
	# res.send 404, 'test'
	console.log req.params[0]
	# in the future, get the actual image name
	res.sendfile config.imageRepo.url + '/1.jpg', (err)->
		if err then next(err)

exports.apiIndex = (req, res, next)->
	# FIXME: check if request must be in json
	#if !req.is 'json' then next() #res.send 400, 'The request must be in json'
	# else

	# find newest
	Image
	.find()
	.sort({createdAt: 'descending'})
	# TODO: pagination. Check the correct way of getting ajax json data
	.skip(req.param('startAt'))
	.limit(10)
	.exec((err, results)->
		# TODO: better error handling
		if err then next(err)
		else res.json results
	)

exports.apiCreate = (req, res, next)->
	if req.files
		#if req.files.size is 0
		console.log req.files
		console.log typeof req.files.image_upload.name, req.files.image_upload.size
		console.log req.files.image_upload.length, typeof req.files.image_upload.filename, req.files.image_upload.mime

exports.apiSaveUpload = (req, res, next)->
	test = new Image(
		name: 'haha.jpg'
	)
	test.save((err)->
		if err then next(err)
		else res.json {} # TODO: check what to send to trigger succeess
	)

exports.apiDelete = (req, res, next)->
	Image.remove {_id: req.body._id}, (err)->
		if err then next(err)
		else 
			# delete image too


module.exports = exports
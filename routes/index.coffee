CaptionController = require '../controllers/CaptionController'
UserController = require '../controllers/UserController'
ImageController = require '../controllers/ImageController'

config = require('../config')
# import express for middleware for upload
express = require('express')
validations = require '../client/js/shared/validations'
d = require '../libs/dynamicMiddleware'
# routes are shared between server and client. Would directly be here otherwise
r = require('../client/js/shared/routes')
# handy shortcuts
caption = r.caption
user = r.user
image = r.image
api = r.api

# 404 handling is in config
module.exports = (app)->
	app.get image.index, d(), ImageController.index
	app.get image.view, d(), ImageController.view
	app.get image.create, d(), ImageController.index # switch to index
	app.get api.image.index, d(), ImageController.apiIndex
	app.get api.image.view, d(), ImageController.apiView
	# middleware for setting the upload limit to 1mb
	app.post api.image.create, d([
			{name: 'limit', args: ['1mb']}
			{name: 'uploadValidator', args: [validations.imageUpload.mimeTypes]}			
		]), ImageController.apiCreate
	app.post api.image.saveUpload, d(), ImageController.apiSaveUpload
	app.delete api.image.delete, d(), ImageController.apiDelete
	# app.get user.index, UserController.index

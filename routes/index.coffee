# routes are shared between server and client. Would directly be here otherwise
r = require('../client/js/shared').routes
c = require('../controllers')
config = require('../config')
# import express for middleware for upload
express = require('express')
# handy shortcuts
caption = r.caption
user = r.user
image = r.image
api = r.api

CaptionController = c.CaptionController
UserController = c.UserController
ImageController = c.ImageController
# 404 handling is in config
module.exports = (app)->
	app.get image.index, ImageController.index
	app.get image.view, ImageController.view
	app.get image.create, ImageController.index # switch to index
	app.get api.image.index, ImageController.apiIndex
	app.get api.image.view, ImageController.apiView
	# middleware for setting the upload limit to 1mb
	app.post api.image.create, ImageController.apiCreate
	app.post api.image.saveUpload, ImageController.apiSaveUpload
	app.delete api.image.delete, ImageController.apiDelete
	# app.get user.index, UserController.index

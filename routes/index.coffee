# routes are shared between server and client. Would directly be here otherwise
r = require('../shared').routes
c = require('../controllers')

# handy shortcuts
caption = r.caption
user = r.user
image = r.image

CaptionController = c.CaptionController
UserController = c.UserController
ImageController = c.ImageController

module.exports = (app)->
	app.get image.index, ImageController.index
	app.get caption.view, CaptionController.view

# routes are shared between server and client. Would directly be here otherwise
r = require('../shared').routes
c = require('../controllers')

module.exports = (app)->
	app.get r.caption.index, c.CaptionController.index

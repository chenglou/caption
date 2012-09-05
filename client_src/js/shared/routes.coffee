# TODO: might separate the objs into their own files in the future

# the only url get is the view (and user.me). Create is there for client-side only. There's no app.get(caption.create)
exports.image =
	index: '/'
	view: /^\/(\d+)\/?$/ # /4 static image for third-party
	create: '/new' # switch to index, let client-side handle the routing

exports.caption = 
	view: /^\/(\d+)\/(\d+)\/?$/ # /4/10 static image for third-party
	create: /^\/(\d+)\/new\/?$/ # /4/new

exports.user =
	me: '/me'
	view: /^\/user\/(\d+)\/?$/ # /user/5
	create: '/user/new'

exports.api =
	image:
		index: '/api/image/index' # returns list of images, etc.
		view:  /^\/api\/image\/(\d+)\/?$/ # /api/image/4
		create: '/api/image/create' # temp upload
		saveUpload: '/api/image/saveUpload' # temp upload
		delete: /^\/api\/image\/(\d+)\/delete\/?$/ # /api/image/4/delete

	caption:
		view: '/api/caption/'
		update: /^\/api\/(\d+)\/edit\/?$/ # /api/4/edit
		delete: /^\/api\/(\d+)\/edit\/?$/ # /api/4/delete
		star: /^\/api\/(\d+)\/(\d+)\/star\/?$/ # /api/4/10/star

	user:
		create: '/api/user/new'
		update: '/api/user/edit'

module.exports = exports
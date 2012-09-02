# TODO: might separate the objs into their own files in the future

exports.image =
	view: /^\/(\d+)\/?$/ # /4
	create: '/new'
	delete: /^\/(\d+)\/delete\/?$/ # /4/delete

exports.caption = 
	index: '/'
	view: /^\/(\d+)\/(\d+)\/?$/ # /4/10
	create: /^\/(\d+)\/new\/?$/ # /4/new
	update: /^\/(\d+)\/edit\/?$/ # /4/edit
	delete: /^\/(\d+)\/edit\/?$/ # /4/delete
	star: /^\/(\d+)\/(\d+)\/star\/?$/ # /4/10/star

exports.user =
	me: '/me'
	view: /^\/user\/(\d+)\/?$/ # /user/5
	create: '/user/new'
	update: '/user/edit'

module.exports = exports
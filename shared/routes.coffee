image =
	create: 'image/new'
	# TODO rethink delete. Img might use a temp id.
	delete: /^\/image\/(\d+)\/?$/ #/image/5

caption = 
	# TODO where to add default /. Image or somewhere else?
	view: /^\/(\d+)\/(\d+)\/?$/ #/4/10
	create: /^\/(\d+)\/new\/?$/ #/4/new
	update: /^\/(\d+)\/edit\/?$/ #/4/edit
	star: /^\/(\d+)\/(\d+)\/star\/?$/ #/4/10/star

user =
	view: /^\/user\/(\d+)\/?$/ #/user/5
	create: '/user/new'
	update: '/user/edit'

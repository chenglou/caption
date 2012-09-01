module.exports = (app)->
	
	app.get(/^\/\d+\/?$/, (req, res)->
		res.render('index', { title: 'Express' });
	)
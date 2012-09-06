Caption = require('../models/Caption')

exports.view = (req, res)->
	test = new Caption(
		extension: '.jpg'
	)
	test.save((err)->
		throw err if err
		console.log 'saved!'
	)
	res.render('caption/index', { title: 'Express' });


module.exports = exports
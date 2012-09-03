Image = require('../models').Image

# displays a list of the Images
exports.index = (req, res)->
	# find newest
	Image
	.find()
	.sort({createdAt: 'descending'})
	.limit(10)
	.exec((err, results)->
		# TODO: better error handling
		throw err if err
		res.json results
		res.render('image/index', { title: 'Express' });
	)

exports.view = (req, res)->
	test = new Image(
		extension: '.jpg'
	)
	test.save((err)->
		throw err if err
		console.log 'saved!'
	)
	res.render('image/index', { title: 'Express' });


module.exports = exports
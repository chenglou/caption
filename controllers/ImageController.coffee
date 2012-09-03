Image = require('../models').Image

# displays a list of the Images
exports.index = (req, res)->
	# find newest 	
	Image
	.find()
	.sort({createdAt: 'descending'})
	.limit(10)
	.exec((err, results)->
		throw err if err
		console.log results
		res.render('caption/index', { title: 'Express' });
	)

exports.view = (req, res)->
	test = new Image(
		extension: '.jpg'
	)
	test.save((err)->
		throw err if err
		console.log 'saved!'
	)
	res.render('caption/index', { title: 'Express' });


module.exports = exports
# NOTE: doesn't require index
Caption = require('../models/Image')

# displays a list of the captions
exports.index = (req, res)->
	test = new Caption(
		extension: '.jpg'
	)
	test.save((err)->
		throw err if err
		console.log 'saved!'
	)
	res.render('caption/index', { title: 'Express' });

exports.view = (req, res)->
	Caption.find({}, (err, results) ->
		console.log err, results
		res.render('caption/index', { title: 'Express' });
	)


module.exports = exports
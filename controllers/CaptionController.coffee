exports.index = (req, res)->
	res.render('caption/index', { title: 'Express' });

module.exports = exports
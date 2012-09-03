mongoose = require('mongoose')
Schema = mongoose.Schema

captionSchema = new Schema(
	createdAt: 
		type: Date
		default: Date.now
	# TODO: optionally link it to the user
)
Caption = mongoose.model('Caption', captionSchema)

module.exports = Caption
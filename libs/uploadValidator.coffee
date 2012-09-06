###
used in conjunction with dynamicMiddleware for variable middleware config
checks if the mime type belongs to that of an image. Can only check
after the file has started uploaded. To keep things simple, check the
type after file finishes uploading, then discard if necessary. Client-
side will also check for mime type.
###

fs = require 'fs'
config = require '../config'

# not passing arg: accepts everything
module.exports = (acceptedTypes)->
	return (req, res, next)->
		# fancy error checking
		if acceptedTypes is undefined then return next()
		if !Array.isArray(acceptedTypes) then throw new Error 'argument must be an array'
		if !req.files then return next()
		if acceptedTypes.indexOf(req.files.image_upload.mime) is -1
			# TODO: ignore file removal error for now. Might need to bring this back one day
			fs.unlink req.files.image_upload.path
			return next('file type not accepted')
		# nothing wrong after this point
		next()



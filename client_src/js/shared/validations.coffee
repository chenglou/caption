# this validation script acts as a config, with no logic of its own for maximum compatibility

###
to be filled later

username / pass:
/[a-zA-Z0-9_.\s!$%^&*\-+=]/

don't allow:
/[`<>(){}[]]"':/
###
exports.imageUpload =
	mimeTypes: ['image/jpeg'
			'image/png'
			'image/bmp'
			'image/tiff'
			]
	# upload size is temporarily set in config
	size: '1mb'
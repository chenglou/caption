###
to be filled later

username / pass:
/[a-zA-Z0-9_.\s!$%^&*\-+=]/

don't allow:
/[`<>(){}[]]"':/
###

exports.imageUpload =
	types: ['image/jpeg'
			'image/png'
			'image/bmp'
			'image/tiff'
			]
	# upload size is already set in config
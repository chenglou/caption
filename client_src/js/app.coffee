# this file is called by requirejs in layout
requirejs.config
	# load libs by default
	baseUrl: 'js/libs'
	# custom paths
	paths:
		collections: '../collections'
		models: '../models'
		views: '../views'
	# oldies who don't support requirejs yet
	shim:
		'backbone':
			deps: ['underscore', 'jquery', 'handlebars']
			exports: 'Backbone'
		'handlebars':
			exports: 'Handlebars'
		'underscore':
			exports: '_'

# every initial page load is directed here

window.location.path
requirejs ['backbone'
'views/caption/CaptionView',
'jquery'
],
(Backbone, Handlebars, CaptionView)->
	console.log arguments

###
AppView = Backbone.View.extend
	initialize: ->
		#
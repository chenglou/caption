# watch changes in a CoffeeScript file and output the js into the equivalent directory
{exec} = require 'child_process'
task 'sbuild', 'Build project from src/*.coffee to lib/*.js', ->
  exec 'coffee --compile --output lib/ src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
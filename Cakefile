# compile assets into the correct folder
{exec} = require 'child_process'
task 'sbuild', 'Build project from client-src/*.coffee to client/*.js', ->
  exec 'coffee --compile --output client/ client-src/', (err, stdout, stderr) ->
    throw err if err
    console.log stdout + stderr
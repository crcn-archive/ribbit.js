type = require "type-component"

###
 runs a command
###

class Evaluator extends require("./base")

  ###
  ###

  run: (node, context, next) ->
    command = node.name or node.value
    @_commands.execute command, node, context, (err) ->
      next err, false


  ###
  ###

  test: (node) -> 
    return !!node.name or type(node.value) is "string"



module.exports = Evaluator
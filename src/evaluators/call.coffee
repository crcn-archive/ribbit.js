type = require "type-component"

###
 runs a command
###

class Evaluator extends require("./base")

  ###
  ###

  run: (node, context, next) ->
    command = node.name or node.value

    setup = context.getLocal("setup")

    if setup
      setup context

    @_commands.execute command, node, context, (err) ->
      next err, false


  ###
  ###

  test: (node) -> 
    return (!!node.name or type(node.value) is "string") and node.name isnt "run"



module.exports = Evaluator
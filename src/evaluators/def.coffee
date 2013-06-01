
###
 defines a new command
###

class Evaluator extends require("./base")

  ###
  ###

  run: (node, context, next) ->

    name = node.name.substr(4)
    run  = node.find("run")

    @_commands.register name, (node, context, next) =>  
      @all.run run, context.child(node.value), next

    next null, false

  ###
  ###

  test: (node) ->
    return node.name.substr(0, 4) is "def "


module.exports = Evaluator
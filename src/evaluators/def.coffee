
###
 defines a new command
###

class Evaluator extends require("./base")

  ###
  ###

  run: (node, context, next) ->

    name = node.name.substr(4)
    run  = node.find("run")

    ops = 
      name        : name
      description : node.value.description or ""
      params      : node.value.params or {}
      public      : node.value.public or false


    @_commands.register ops, (node, context, next) =>    
      childContext = context.child({ caller: node }).child(node.value)

      setup = childContext.getLocal("setup")

      if setup
        setup context

      @all.run run, childContext, next

    next null, false

  ###
  ###

  test: (node) ->
    return node.name.substr(0, 4) is "def "


module.exports = Evaluator
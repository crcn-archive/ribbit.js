class Base

  ###
   pass all the evaluators
  ###

  constructor: (@all) ->
    @_commands = all.commands

  ###
   tests whether a node is runnable
  ###

  test : (node) -> false

  ###
   runs the node & the context
  ###

  run  : (node, context, next) -> next()

module.exports = Base
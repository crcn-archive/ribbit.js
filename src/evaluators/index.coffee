evaluators = 
  def  : require("./def")  # defines a command
  call : require("./call") # calls a command (string)
  fn   : require("./fn")   # runs a function

###
 runs through all the nodes, and evaluates them
###

class Evaluators

  ###
  ###

  constructor: (@commands) ->
    @_evaluators = []
    @init()

  ###
  ###

  init: () -> 
    @_evaluators.push new evaluators.fn @
    @_evaluators.push new evaluators.def @
    @_evaluators.push new evaluators.call @
  
  ###
  ###

  run: (node, context, next) ->
    node.traverse ((child, next) =>
      @_run child, context, next
    ), next

  ###
  ###

  _run: (node, context, next) -> 
    for evaluator in @_evaluators

      # can the evaluator run the node? then pass it
      if evaluator.test node
        return evaluator.run node, context, next

    # otherwise just skip it
    next()


module.exports = Evaluators


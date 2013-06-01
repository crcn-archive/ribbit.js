evaluators = 
  def  : require("./def")
  task : require("./task") # calls a de
  fn   : require("./fn")

###
 runs through all the nodes, and evaluates them
###

class Evaluator

  ###
  ###

  constructor: () ->
    @_evaluators = []
    @init()

  ###
  ###

  init: () ->
    @_evaluators.push new evaluators.def(@)
    @_evaluators.push new evaluators.task(@)
    @_evaluators.push new evaluators.fn(@)
  
  ###
  ###

  run: (node, context, next) ->
    node.traverse ((child, next) => @_run child, context, next), next

  ###
  ###

  _run: (node, context, next) ->
    for evaluator in @_evaluators

      # can the evaluator run the node? then pass it
      if evaluator.test node
        return evaluator.run node, context, next

      # otherwise just skip it
      next()





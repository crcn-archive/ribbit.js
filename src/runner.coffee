###
 runs through all the nodes, and evaluates them
###

class Runner

  ###
  ###

  constructor: () ->
    @_evaluators = []
    @_load()

  ###
  ###
  
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


  ###
  ###

  _load: () ->


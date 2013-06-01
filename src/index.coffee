type       = require "type-component"
Context    = require "./context"    # target passed to second param
Node       = require "./node"       # makes ribbit source traversable
Evaluators = require "./evaluators" # evaluates each node
Commands   = require "./commands"   # defined
flatstack  = require "flatstack"

class Ribbit 

  ###
  ###

  constructor: () ->
    @commands    = new Commands()
    @_evaluators = new Evaluators @commands
    @_callstack  = flatstack @
  
  ###
  ###

  run: (source, context = {}, callback = () ->) ->

    if type(context) is "function"
      callback = context
      context  = {}

    # throw in a queue incase .run() isn't finished
    @_callstack.push (next) =>

      node = Node.cast source
      ctx  = Context.cast context

      @_evaluators.run node, ctx, () =>
        callback.apply @, arguments
        next()

    @


exports.run = (source, context, callback) -> new Ribbit().run(source, context, callback)

exports.Context = Context
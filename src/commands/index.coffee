comerr = require "comerr"

###
###

class Commands

  ###
  ###

  constructor: () ->
    @_commands = {}

  ###
  ###

  describe: () -> 
    desc = []
    for key of @_commands
      desc.push @_commands[key].options
    desc

  ###
  ###

  register: (options, listener) ->
    @_commands[options.name] = { listener: listener, options: options }

  ###
  ###

  execute: (name, node, context, callback) ->

    unless ops = @_commands[name]  
      return callback new comerr.NotFound "command \"#{name}\" not found"

    ops.listener.call @, node, context, callback


    


module.exports = Commands
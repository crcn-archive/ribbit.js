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

  register: (name, listener) ->
    @_commands[name] = listener

  ###
  ###

  execute: (name, node, context, callback) ->

    unless listener = @_commands[name]  
      return callback new comerr.NotFound "command \"#{name}\" not found"

    listener.call @, node, context, callback


    


module.exports = Commands
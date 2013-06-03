comerr     = require "comerr"
toarray    = require "toarray"
deepExtend = require "deep-extend"

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
      desc.push @_inherit @_commands[key].options
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



  ###
  ###

  _inherit: (options) ->
  
    from = toarray options.inherit
    newOps = deepExtend {}, options

    for cmd in from
      newOps = deepExtend @_inherit(@_commands[cmd]?.options or {}), newOps

    newOps



    


module.exports = Commands
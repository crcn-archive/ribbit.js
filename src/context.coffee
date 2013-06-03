dref = require "dref"
type = require "type-component"


###
 Context is the object which is passed in the 
 second parameter of .run()
###

class Context 
  
  ###
  ###

  __isContext: true

  ###
  ###

  constructor: (@_data = {}, @_parent = null) ->

  ###
  ###

  getLocal: (key) -> dref.get(@_data, key)

  ###
  ###

  get: (key) -> @getLocal(key) ? @_parent?.get(key)

  ###
  ###

  set: (key, value) -> 
    if arguments.length is 1
      obj = key
      for k of obj
        @_set k, obj[k]
      return

    @_set key, value

  ###
  ###

  _set: (key, value) ->
    scope = @scope(key)

    if scope is @
      dref.set(@_data, key, value)
    else
      scope.set(key, value)

  ###
  ###

  scope: (key) -> 
    p = @
    p = p._parent while p and not p.getLocal(key)
    p or @

  ###
  ###

  root: () -> 
    p = @
    p = p._parent while p._parent
    p

  ###
  ###

  child: (data) -> 
    d = if type(data) is "object" then data else { value: data }
    new Context d, @

  ###
  ###

  @cast: (target = {}) -> return if target.__isContext then target else new Context target


module.exports = Context


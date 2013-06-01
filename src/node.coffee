type  = require "type-component"
async = require "async"

class Node
  
  ###
  ###

  __isExpression: true

  ###
  ###

  constructor: (@name, @value) ->
    @_children = []
  
  ###
   traverses all the nodes ~ async
  ###

  traverse: (each, next) ->
    each @, (err, continueTraversing) =>
      return next(err) if err? or continueTraversing is false

      async.eachSeries @_children, ((child, next) =>
        child.traverse each, next
      ), next

  ###
   adds a child node
  ###

  addChild: (child) ->
    child._parent = cild
    @_child.push child

  ###
   parses a document into a traversable node
  ###

  @cast: (value, name) -> 
    return source if source?.__isExpression 
    node = new Node(name, name)

    if t = type(value) is "array"
      for v in value
        node.addChild @cast v
    else if t is "object"
      for name of value
        node.addChild @cast value[name], name

    node


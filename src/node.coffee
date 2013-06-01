type  = require "type-component"
async = require "async"

###
 normalizes passed json doc
###

class Node
  
  ###
  ###

  __isExpression: true

  ###
  ###

  constructor: (@value, @name = "") ->
    @_children = []

  ###
  ###

  find: (name) ->
    return @ if name is @name
    for child in @_children
      found = child.find(name)
      if found
        return found
    return false
  
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
    child._parent = child
    @_children.push child

  ###
  ###

  childAt: (index) -> @_children[index]

  ###
   parses a document into a traversable node
  ###

  @cast: (value, name) -> 
    return source if source?.__isExpression 
    node = new Node(value, name)

    if (t = type(value)) is "array"
      for v in value
        node.addChild @cast v
    else if t is "object"
      for name of value
        node.addChild @cast value[name], name

    node

module.exports = Node
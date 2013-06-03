type = require "type-component"

###
 runs a function
###

class Evaluator extends require("./base")

  ###
  ###

  run: (node, context, next) -> 
  
    try 
      if node.value.length < 2
        node.value.call @all, context
        next()
      else
        node.value.call @all, context, next
    catch e 
      next e

  ###
  ###

  test: (node) -> type(node.value) is "function"


module.exports = Evaluator
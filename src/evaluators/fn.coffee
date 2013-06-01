type = require "type-component"

###
 runs a function
###

class Evaluator extends require("./base")

  ###
  ###

  run: (node, context, next) -> 

    try 
      if node.value.length is 1
        node.value.call context, context
        next()
      else
        node.value.call context, context, next
    catch e 
      next e

  ###
  ###

  test: (node) -> type(node.value) is "function"


module.exports = Evaluator
class Base
  constructor: (@all) ->
  test : (node) -> false
  run  : (node, context, next) -> next()

module.exports = Base
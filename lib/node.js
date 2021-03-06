// Generated by CoffeeScript 1.6.2
(function() {
  var Node, async, type;

  type = require("type-component");

  async = require("async");

  /*
   normalizes passed json doc
  */


  Node = (function() {
    /*
    */
    Node.prototype.__isNode = true;

    /*
    */


    function Node(value, name) {
      this.value = value;
      this.name = name != null ? name : "";
      this.children = [];
    }

    /*
    */


    Node.prototype.find = function(name) {
      var child, found, _i, _len, _ref;

      if (name === this.name) {
        return this;
      }
      _ref = this.children;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        child = _ref[_i];
        found = child.find(name);
        if (found) {
          return found;
        }
      }
      return false;
    };

    /*
     traverses all the nodes ~ async
    */


    Node.prototype.traverse = function(each, next) {
      var _this = this;

      return each(this, function(err, continueTraversing) {
        if ((err != null) || continueTraversing === false) {
          return next(err);
        }
        return async.eachSeries(_this.children, (function(child, next) {
          return child.traverse(each, next);
        }), next);
      });
    };

    /*
     adds a child node
    */


    Node.prototype.addChild = function(child) {
      child._parent = child;
      return this.children.push(child);
    };

    /*
    */


    Node.prototype.childAt = function(index) {
      return this.children[index];
    };

    /*
     parses a document into a traversable node
    */


    Node.cast = function(value, name) {
      var node, t, v, _i, _len;

      if (value != null ? value.__isNode : void 0) {
        return value;
      }
      node = new Node(value, name);
      if ((t = type(value)) === "array") {
        for (_i = 0, _len = value.length; _i < _len; _i++) {
          v = value[_i];
          node.addChild(this.cast(v));
        }
      } else if (t === "object") {
        for (name in value) {
          node.addChild(this.cast(value[name], name));
        }
      }
      return node;
    };

    return Node;

  })();

  module.exports = Node;

}).call(this);

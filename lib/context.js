// Generated by CoffeeScript 1.6.2
(function() {
  var Context, dref, type;

  dref = require("dref");

  type = require("type-component");

  /*
   Context is the object which is passed in the 
   second parameter of .run()
  */


  Context = (function() {
    /*
    */
    Context.prototype.__isContext = true;

    /*
    */


    function Context(_data, _parent) {
      this._data = _data != null ? _data : {};
      this._parent = _parent != null ? _parent : null;
    }

    /*
    */


    Context.prototype.getLocal = function(key) {
      return dref.get(this._data, key);
    };

    /*
    */


    Context.prototype.get = function(key) {
      var _ref, _ref1;

      return (_ref = this.getLocal(key)) != null ? _ref : (_ref1 = this._parent) != null ? _ref1.get(key) : void 0;
    };

    /*
    */


    Context.prototype.set = function(key, value) {
      var k, obj;

      if (arguments.length === 1) {
        obj = key;
        for (k in obj) {
          this._set(k, obj[k]);
        }
        return;
      }
      return this._set(key, value);
    };

    /*
    */


    Context.prototype._set = function(key, value) {
      var scope;

      scope = this.scope(key);
      if (scope === this) {
        return dref.set(this._data, key, value);
      } else {
        return scope.set(key, value);
      }
    };

    /*
    */


    Context.prototype.scope = function(key) {
      var p;

      p = this;
      while (p && !p.getLocal(key)) {
        p = p._parent;
      }
      return p || this;
    };

    /*
    */


    Context.prototype.root = function() {
      var p;

      p = this;
      while (p._parent) {
        p = p._parent;
      }
      return p;
    };

    /*
    */


    Context.prototype.child = function(data) {
      var d;

      d = type(data) === "object" ? data : {
        value: data
      };
      return new Context(d, this);
    };

    /*
    */


    Context.cast = function(target) {
      if (target == null) {
        target = {};
      }
      if (target.__isContext) {
        return target;
      } else {
        return new Context(target);
      }
    };

    return Context;

  })();

  module.exports = Context;

}).call(this);

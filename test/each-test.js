var ribbit = require(".."),
async      = require("async"),
expect     = require("expect.js");

describe("each", function() {

  var runner;

  it("can define the each-command", function(next) {
    runner = ribbit.run({
      "def each": {
        "run": function(context, next) {
          var self = this;
          async.eachSeries(context.get("source"), function(item, next) {
            var as = context.get("as") || "value",
            child = {};
            child[as] = item;
            self.run(context.get("currentNode").find("run"), context.child(child), next);
          }, next);
        }
      }
    }, next);
  });


  it("can run a for-each loop", function(next) {
    var i = 0;
    runner.run([{
      "each": {
        "source": [0, 1, 2, 3, 4, 5],
        "as": "number",
        "run": function(context) {
          i++;
        }
      }
    }, function() {
      expect(i).to.be(6);
    }], next);
  });
});
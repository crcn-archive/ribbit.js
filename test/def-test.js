var cap = require(".."),
expect = require("expect.js");

describe("definition test", function() {

  it("can define, and run a simple definition", function(next) {
    cap.run({
      "def sayHello": {
        "run": function(context) {
          expect(context.get("message")).to.be("hello");
          expect(context.get("value")).to.be("sayHello");
        }
      }
    }).run("sayHello", { message: "hello" }, next);
  });


  it("can define, and run a simple definition without a context", function(next) {
    cap.run({
      "def sayHello": {
        "run": function(context) {
          expect(context.get("message")).to.be("hello");
          expect(context.get("currentNode.name")).to.be("sayHello");
        }
      }
    }).run({
      "sayHello": {
        message: "hello"
      }
    }, next);
  })

  it("can catch a thrown error", function(next) {
    cap.run({
      "def hello": {
        "run": function(context) {
          throw new Error("blah!");
        }
      }
    }).run("hello", {}, function(err) {
      expect(err).not.to.be(undefined);
      expect(err.message).to.be("blah!");
      next();
    })
  });

  it("can modify the context", function(next) {
    cap.run({
      "def concat": {
        "run": function(context) {
          context.root().set("buffer", context.get("strings").join(context.get("delim")));
        }
      },
      "def validate": {
        "run": function(context) {
          expect(context.get("buffer")).to.be("a+b+c");
        }
      } 
    }).run([{
      "concat": {
        delim: "+",
        strings: ["a", "b", "c"]
      }
    }, "validate"], next);
  });

  it("can run an multiple embedded commands", function(next) {
    var i = 0;
    
    cap.run({
      "def sub": {
        "run": [
          "sub2",
          function() {
            expect(i).to.be(1);
          }
        ]
      },
      "def sub2": {
        "run": function() { 
          expect(i).to.be(0);
          i++;
        }
      }
    }, next);

  });

});
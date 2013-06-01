var ribbit = require("..");

//register the helpers first
ribbit.run({
  "def each": {
    "run": function(context, next) {
      
    }
  },
  "def watch": {
    "run": function(context, next) {
      var self = this;
      watchr(context.get("input"), function(watcher) {
        watcher.on("change", function() {
          self.run(context.get(""))
        }).
        on("file", function() {

        });
      });
    }
  }
}).

//
run({
  "def copy-files": {
    "run": {
      "each": {
        "cwd": __dirname,
        "files": ["./src"],
        "run": 
      }
    }
  }
})
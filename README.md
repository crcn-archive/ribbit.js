Javascript Tasks

### Example task:

```javascript
var ribbit = require("ribbit");

capirona.run({
	"def hello": {
		"run": function(context, next) {
			console.log("hello %s!", context.get("message"));
			next();	
		}
	}
}).run({
  "hello": {
    "message": "Craig"
  }
}, function() {
	console.log("done");
});
```


### API

creates a new runnable script

#### .run(source, target, callback)






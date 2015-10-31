
Log-a-log
===========

A log decorator for the console.log() method.

```coffeescript
logalog = require 'log-a-log'

logalog({utc: false})

name = "world"

console.log "Hello, #{name}!"
```
      
Output:
```
[2015-10-30T21:52:05.520-06:00] Hello, world!
```


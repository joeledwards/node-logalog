# Log-a-log

A log decorator for console.log() and company.

## Installation
```
npm install log-a-log
```

## Modes
There are a number of operational modes, configured via the `mode` parameter:
* `utc` - the default mode, which renders a ISO-8601 UTC timestamp in a single color
* `local` - renders a local, ISO-8610 timestamp
* `unix` - renders a millisecond-granularity unix timestamp
* `coded` - renders a color-coded, local, ISO-8601 timestamp 
* `pony` - renders a very colorful, local, ISO-8601 timestamp

## Example
```coffeescript
logalog = require 'log-a-log'

logalog.init({mode: 'local', alias: 'my-script'})

name = "world"

console.log "Hello, #{name}!"
```

Output:
```
[2015-10-30T21:52:05.520-06:00]my-script|INFO> Hello, world!
```


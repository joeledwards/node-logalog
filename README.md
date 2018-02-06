# Log-a-log

[![Build Status][travis-image]][travis-url]
[![NPM version][npm-image]][npm-url]

A simple logger and optional decorator for console.log() and company.

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
```javascript
const logalog = require('log-a-log')

logalog({mode: 'local', alias: 'my-script'})

const name = "world"

console.log(`Hello, ${name}!`)
console.error(`Oh noes, ${name}!`)
```

Sample Output:
```
[2015-10-30T21:52:05.520-06:00]my-script|INFO> Hello, world!
[2015-10-30T21:52:05.520-06:00]my-script|ERROR> Oh noes, world!
```

[travis-url]: https://travis-ci.org/joeledwards/node-logalog
[travis-image]: https://img.shields.io/travis/joeledwards/node-logalog/master.svg
[npm-url]: https://www.npmjs.com/package/log-a-log
[npm-image]: https://img.shields.io/npm/v/log-a-log.svg

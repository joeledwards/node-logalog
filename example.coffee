#!/usr/bin/env coffee

logalog = require './src/index'

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the UTC timezone."

logalog({utc: false})

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the Local timezone."


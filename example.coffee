#!/usr/bin/env coffee

moment = require 'moment'
logalog = require './src/index'

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the UTC timezone."

logalog({utc: false})

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the Local timezone."

logalog({utc: true})

console.error "This error line should be prefixed with an ISO-8601 formatted timestamp in UTC timezone."


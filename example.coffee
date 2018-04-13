#!/usr/bin/env coffee

moment = require 'moment'
logalog = require './src/index'
logalog()

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the UTC timezone."

logalog({mode: 'local'})

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the local timezone."

logalog({mode: 'unix', info: true, alias: 'example'})

console.log "This log should be prefixed with a millisecond unix timestamp."

logalog({mode: 'utc', info: true, alias: 'example'})

console.error "error"
console.warn "warning"
console.info "informational"
console.debug "debugging"

logalog({mode: 'coded', alias: 'colorful', info: true})

console.log "This log should be prefixed with a color coded, ISO-8601 formatted timestamp in the local timezone."

logalog({mode: 'pony', alias: 'rainbows', info: true})

console.log "This log should be prefixed with a beautifully colorized, ISO-8601 formatted timestamp in the local timezone."


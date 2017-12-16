#!/usr/bin/env coffee

moment = require 'moment'
logalog = require './src/index'

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the UTC timezone."

logalog.init({mode: 'local'})

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the local timezone."

logalog.init({mode: 'unix', info: true, alias: 'example'})

console.log "This log should be prefixed with a millisecond unix timestamp."

logalog.init({mode: 'utc', info: true, alias: 'example'})

console.error "error"
console.warn "warning"
console.info "informational"
console.debug "debugging"

logalog.init({mode: 'coded', alias: 'colorful', info: true})

console.log "This log should be prefixed with a color coded, ISO-8601 formatted timestamp in the local timezone."

logalog.init({mode: 'pony', alias: 'rainbows', info: true})

console.log "This log should be prefixed with a beautifully colorized, ISO-8601 formatted timestamp in the local timezone."


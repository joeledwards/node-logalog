#!/usr/bin/env coffee

moment = require 'moment'
logalog = require './src/index'
logalog()

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the UTC timezone."

logalog({mode: 'local'})

console.log "This log should be prefixed with an ISO-8601 formatted timestamp in the local timezone."

logalog({mode: 'unix', alias: 'example'})

console.log "This log should be prefixed with a millisecond unix timestamp."

logalog({mode: 'utc', alias: 'example'})

console.error "error"
console.warn "warning"
console.info "informational"
console.verbose "verbose disabled (YOU SHOULD NOT SEE THIS)"

logalog({verbose: true, error: false, warn: false, info: false})

console.error "error disabled (YOU SHOULD NOT SEE THIS)"
console.warn "warn disabled (YOU SHOULD NOT SEE THIS)"
console.info "info disabled (YOU SHOULD NOT SEE THIS)"
console.verbose "verbose"

logalog({mode: 'utc', info: 'INFORMATIONAL', verbose: 'VERB'})

console.info "The level idenfitier should be customized."
console.verbose "The verbose idenfitier should be customized."

logalog({mode: 'coded', alias: 'colorful'})

console.log "This log should be prefixed with a color coded, ISO-8601 formatted timestamp in the local timezone."

logalog({mode: 'pony', alias: 'rainbows'})

console.log "This log should be prefixed with a beautifully colorized, ISO-8601 formatted timestamp in the local timezone."


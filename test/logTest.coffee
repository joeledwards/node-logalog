assert = require 'assert'
timeunit = require 'timeunit'
logalog = require '../src/index.coffee'
logalog({
  alias: 'cake'
})

describe "log-a-log", ->
  it "should expose init and reset functions", (done) ->
    logalog({
      error: 'ERROR'
    })

    console.log "some info"
    console.error "an error"

    logalog({
      alias: 'alias'
    })
    console.log "some info"
    console.error "an error"

    logalog({
      info: 'INFO-CUSTOM'
    })
    console.log "some info"
    console.error "an error"

    logalog({
      error: 'ERROR-CUSTOM'
    })
    console.log "some info"
    console.error "an error"

    logalog({
      console: false
    })

    console.log "some info"
    console.error "an error"

    logalog({
      alias: 'cake'
      warn: 'WARNING'
      info: 'INFORMATIONAL'
    })

    console.error "error()"
    console.warn "warn()"
    console.info "info()"
    console.verbose "verbose()"

    logalog({
      console: false
    })

    done()


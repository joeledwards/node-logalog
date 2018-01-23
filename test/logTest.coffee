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
      info: true
    })
    console.log "some info"
    console.error "an error"

    logalog({
      error: true
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
      info: false
    })

    console.error "error()"
    console.warn "warn()"
    console.info "info()"
    console.debug "debug()"

    logalog({
      console: false
    })

    done()


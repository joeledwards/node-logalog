assert = require 'assert'
timeunit = require 'timeunit'
logalog = require '../src/index.coffee'
logalog.init({
  alias: 'cake'
})

describe "log-a-log", ->
  it "should expose init and reset functions", (done) ->
    logalog.init({
      error: 'ERROR'
    })

    console.log "some info"
    console.error "an error"

    logalog.init({
      alias: 'alias'
    })
    console.log "some info"
    console.error "an error"

    logalog.init({
      info: true
    })
    console.log "some info"
    console.error "an error"

    logalog.init({
      error: true
    })
    console.log "some info"
    console.error "an error"

    logalog.reset()

    console.log "some info"
    console.error "an error"

    logalog.init({
      alias: 'cake'
      info: false
    })

    console.error "error()"
    console.warn "warn()"
    console.info "info()"
    console.debug "debug()"

    logalog.reset()

    done()


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
      info: 'INFO'
    })
    console.log "some info"
    console.error "an error"

    logalog.init({
      error: 'error'
    })
    console.log "some info"
    console.error "an error"

    logalog.init({
      alias: 'alias'
      error: 'error'
      info: 'info'
    })
    console.log "some info"
    console.error "an error"

    logalog.reset()

    console.log "some info"
    console.error "an error"

    logalog.init({
      alias: 'cake'
    })

    done()


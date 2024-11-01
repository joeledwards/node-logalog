const tap = require('tap')

const logalog = require('../lib/index')

tap.test("should expose init and reset functions", async assert => {
    logalog({ alias: 'tap' })

    logalog({ error: 'ERROR' })
    console.log("some info")
    console.error("an error")

    logalog({ alias: 'alias' })
    console.log("some info")
    console.error("an error")

    logalog({ info: 'INFO-CUSTOM' })
    console.log("some info")
    console.error("an error")

    logalog({ error: 'ERROR-CUSTOM' })
    console.log("some info")
    console.error("an error")

    logalog({ console: false })

    console.log("some info")
    console.error("an error")

    logalog({
      alias: 'tap',
      warn: 'WARNING',
      info: 'INFORMATIONAL',
    })
    console.error("error()")
    console.warn("warn()")
    console.info("info()")
    console.verbose("verbose()")

    logalog({ console: false })
})


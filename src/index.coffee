moment = require 'moment'

console_log = console.log

now = (utc=true) ->
  if utc
    console_log "UTC offset is #{moment.utc().utcOffset()}"
    moment.utc().toISOString()
  else
    console_log "UTC offset is #{moment().utcOffset()}"
    moment().format("YYYY-MM-DD'T'HH:mm:ssZZ")
  time = if utc then moment.utc() else moment()
  time.toISOString()

timeLog = (config) ->
  console_log "config: #{JSON.stringify(config, null, 2)}"
  cfg =
    utc: config.utc ? true

  console.log = (args...) ->
    console_log "[#{now(cfg.utc)}]", args...

timeLog({utc: true})

module.exports = timeLog


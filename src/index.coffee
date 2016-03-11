moment = require 'moment'

console_log = console.log
console_error = console.error

now = (utc=true) ->
  if utc
    moment.utc().toISOString()
  else
    moment().format("YYYY-MM-DDTHH:mm:ss.SSSZ")

timeLog = (config) ->
  cfg =
    utc: config.utc ? true

  console.log = (args...) ->
    console_log "[#{now(cfg.utc)}]", args...
  console.error = (args...) ->
    console_error "[#{now(cfg.utc)}]", args...

timeLog({utc: true})

module.exports = timeLog


moment = require 'moment'

console_log = console.log
console_error = console.error

# Format the current time according to ISO-8601
now = (utc=true) ->
  if utc
    moment.utc().toISOString()
  else
    moment().format("YYYY-MM-DDTHH:mm:ss.SSSZ")

# Add a timestamp to the console.log and console.error functions
timeLog = (config) ->
  cfg =
    utc: config.utc ? true
    error: if config.error? then " " + config.error + ">" else ""
    info: if config.info? then " " + config.info+ ">" else ""

  console.log = (args...) ->
    console_log "[#{now(cfg.utc)}]#{cfg.info}", args...
  console.error = (args...) ->
    console_error "[#{now(cfg.utc)}]#{cfg.error}", args...

# Default configuration
defaultConfig =
  utc: true
  error: "ERROR"
  info: undefined

# Set with the defaults
timeLog(defaultConfig)

# Make available to the user so they can configure explicitly
module.exports = timeLog


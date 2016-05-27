moment = require 'moment'

console_log = console.log
console_error = console.error

# Format the current time according to ISO-8601
now = (utc=true) ->
  if utc
    moment.utc().toISOString()
  else
    moment().format("YYYY-MM-DDTHH:mm:ss.SSSZ")

# Reset the configuration to the defaults
resetConfig = ->
  console.log = console_log
  console.error = console_error

# Add a timestamp to the console.log and console.error functions
timeLog = (config) ->
  cfg =
    utc: config.utc ? true
    alias: if config.alias? then "#{config.alias}|" else "|"
    error: if config.error? then "#{config.error}>" else ">"
    info: if config.info? then "#{config.info}>" else ">"

  # Overwrite the console.log() function
  console.log = (args...) ->
    [first, rest...] = args
    message = "[#{now(cfg.utc)}]#{cfg.alias}#{cfg.info} #{first ? ''}"
    console_log message, rest...

  # Overwrite the console.error() function
  console.error = (args...) ->
    [first, rest...] = args
    message = "[#{now(cfg.utc)}]#{cfg.alias}#{cfg.error} #{first ? ''}"
    console_error message, rest...

# Default configuration
defaultConfig =
  utc: true
  alias: undefined
  error: "ERROR"
  info: undefined

# Set with the defaults
timeLog(defaultConfig)

# Make available to the user so they can configure explicitly
module.exports =
  init: timeLog
  reset: resetConfig

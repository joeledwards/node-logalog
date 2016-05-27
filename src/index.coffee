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

# Default configuration
savedConfig =
  utc: true
  alias: undefined
  error: true
  info: false

# Add a timestamp to the console.log and console.error functions
timeLog = (config) ->
  savedConfig.error = config.error ? savedConfig.error
  savedConfig.info = config.info ? savedConfig.info
  savedConfig.utc = config.utc ? savedConfig.utc
  savedConfig.alias = config.alias

  utc = savedConfig.utc
  alias = if savedConfig.alias? then "#{savedConfig.alias}|" else "|"
  error = if savedConfig.error == true then "ERROR>" else ">"
  info = if savedConfig.info == true then "INFO>" else ">"

  # Overwrite the console.log() function
  console.log = (args...) ->
    [first, rest...] = args
    message = "[#{now(utc)}]#{alias}#{info} #{first ? ''}"
    console_log message, rest...

  # Overwrite the console.error() function
  console.error = (args...) ->
    [first, rest...] = args
    message = "[#{now(utc)}]#{alias}#{error} #{first ? ''}"
    console_error message, rest...

# Set with the defaults
timeLog(savedConfig)

# Make available to the user so they can configure explicitly
module.exports =
  init: timeLog
  reset: resetConfig

moment = require 'moment'
color = require '@buzuli/color'

{red, orange, yellow, green, blue, purple, gray} = color

console_error = console.error
console_warn = console.warn
console_log = console.log
console_info = console.info
console_debug = console.debug

# Format the current time according to ISO-8601
now = (mode) ->
  if mode == 'local'
    blue(moment().format("YYYY-MM-DDTHH:mm:ss.SSSZ"))
  else if mode == 'unix'
    blue("#{Date.now()}")
  else if mode == 'pony'
    d = gray('-')
    T = gray('T')
    c = gray(':')
    p = gray('.')
    Y = purple(moment().format('YYYY'))
    M = blue(moment().format('MM'))
    D = green(moment().format('DD'))
    H = yellow(moment().format('HH'))
    m = orange(moment().format('mm'))
    s = red(moment().format('ss'))
    S = purple(moment().format('SSS'))
    Z = blue(moment().format('Z'))
    "#{Y}#{d}#{M}#{d}#{D}#{T}#{H}#{c}#{m}#{c}#{s}#{p}#{S}#{Z}"
  else if mode == 'coded'
    d = gray('-')
    T = gray('T')
    c = gray(':')
    p = gray('.')
    Y = blue(moment().format('YYYY'))
    M = blue(moment().format('MM'))
    D = blue(moment().format('DD'))
    H = yellow(moment().format('HH'))
    m = yellow(moment().format('mm'))
    s = yellow(moment().format('ss'))
    S = yellow(moment().format('SSS'))
    Z = gray(moment().format('Z'))
    "#{Y}#{d}#{M}#{d}#{D}#{T}#{H}#{c}#{m}#{c}#{s}#{p}#{S}#{Z}"
  else
    blue(moment.utc().toISOString())

# Reset the configuration to the defaults
resetConfig = ->
  console.error = console_error
  console.warn = console_warn
  console.log = console_log
  console.info = console_info
  console.debug = console_debug

# Default configuration
savedConfig =
  mode: 'utc'
  alias: undefined
  error: true
  warn: true
  info: true
  debug: true

# Add a timestamp to the console.log and console.error functions
timeLog = (config = {}) ->
  savedConfig.mode = config.mode ? savedConfig.mode
  savedConfig.error = config.error ? savedConfig.error
  savedConfig.warn = config.warn ? savedConfig.warn
  savedConfig.info = config.info ? savedConfig.info
  savedConfig.debug = config.debug ? savedConfig.debug
  savedConfig.alias = config.alias

  mode = savedConfig.mode
  alias = if savedConfig.alias? then "#{orange(savedConfig.alias)}|" else "|"
  error = if savedConfig.error == true then "#{red('ERROR')}>" else ">"
  debug = if savedConfig.debug == true then "#{purple('DEBUG')}>" else ">"
  warn = if savedConfig.warn == true then "#{yellow('WARN')}>" else ">"
  info = if savedConfig.info == true then "#{green('INFO')}>" else ">"

  sub = (logger, category) ->
    (args...) ->
      [first, rest...] = args
      message = "[#{now(mode)}]#{alias}#{category} #{first ? ''}"
      logger message, rest...

  console.error = sub(console_error, error)
  console.warn = sub(console_warn, warn)
  console.log = sub(console_log, info)
  console.info = sub(console_info, info)
  console.debug = sub(console_debug, debug)

# Set with the defaults
timeLog(savedConfig)

# Make available to the user so they can configure explicitly
module.exports =
  init: timeLog
  reset: resetConfig
  color: color

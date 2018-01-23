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

# Default configuration
defaultConfig =
  mode: 'utc'
  console: true
  alias: undefined
  error: true
  warn: true
  info: true
  debug: true

# Add a timestamp to the console.log and console.error functions
initialize = (config = {}) ->
  cfg = {
    mode: config.mode ? defaultConfig.mode
    console: config.console ? defaultConfig.console
    alias: config.alias ? defaultConfig.alias
    error: config.error ? defaultConfig.error
    warn: config.warn ? defaultConfig.warn
    info: config.info ? defaultConfig.info
    debug: config.debug ? defaultConfig.debug
  }

  alias = if cfg.alias? then "#{orange(cfg.alias)}|" else "|"
  error = if cfg.error == true then "#{red('ERROR')}>" else ">"
  debug = if cfg.debug == true then "#{purple('DEBUG')}>" else ">"
  warn = if cfg.warn == true then "#{yellow('WARN')}>" else ">"
  info = if cfg.info == true then "#{green('INFO')}>" else ">"

  sub = (logger, category) ->
    (args...) ->
      [first, rest...] = args
      message = "[#{now(cfg.mode)}]#{alias}#{category} #{first ? ''}"
      logger message, rest...

  logger =
    error: sub(console_error, error)
    warn: sub(console_warn, warn)
    info: sub(console_info, info)
    debug: sub(console_debug, debug)
    color: color

  console.error = if cfg.console then logger.error else console_error
  console.warn = if cfg.console then logger.warn else console_warn
  console.log = if cfg.console then logger.info else console_log
  console.info = if cfg.console then logger.info else console_info
  console.debug = if cfg.console then logger.debug else console_debug

  logger

# Make available to the user so they can configure explicitly
module.exports = initialize

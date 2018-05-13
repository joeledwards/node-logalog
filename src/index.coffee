moment = require 'moment'
color = require '@buzuli/color'

{red, orange, yellow, green, blue, purple, gray} = color

console_error = console.error
console_warn = console.warn
console_log = console.log
console_info = console.info
console_noop = () => {}

# Format the current time according to ISO-8601
now = (mode) ->
  if mode == 'local'
    blue(moment().format("YYYY-MM-DDTHH:mm:ss.SSSZ"))
  else if mode == 'unix'
    blue("#{Date.now()}")
  else if mode == 'pony'
    ts = moment.utc()
    d = gray('-')
    T = gray('T')
    c = gray(':')
    p = gray('.')
    Y = purple(ts.format('YYYY'))
    M = blue(ts.format('MM'))
    D = green(ts.format('DD'))
    H = yellow(ts.format('HH'))
    m = orange(ts.format('mm'))
    s = red(ts.format('ss'))
    S = purple(ts.format('SSS'))
    Z = blue('Z')
    "#{Y}#{d}#{M}#{d}#{D}#{T}#{H}#{c}#{m}#{c}#{s}#{p}#{S}#{Z}"
  else if mode == 'coded'
    ts = moment.utc()
    d = gray('-')
    T = gray('T')
    c = gray(':')
    p = gray('.')
    Y = blue(ts.format('YYYY'))
    M = blue(ts.format('MM'))
    D = blue(ts.format('DD'))
    H = yellow(ts.format('HH'))
    m = yellow(ts.format('mm'))
    s = yellow(ts.format('ss'))
    S = yellow(ts.format('SSS'))
    Z = gray('Z')
    "#{Y}#{d}#{M}#{d}#{D}#{T}#{H}#{c}#{m}#{c}#{s}#{p}#{S}#{Z}"
  else
    blue(moment.utc().toISOString())

# Default configuration
defaultConfig =
  mode: 'utc'
  console: true
  alias: undefined

# Level validator
validateLevel = (defaultLabel, defaultEnabled = true) ->
  (cfgValue) ->
    if cfgValue?
      if cfgValue == true then defaultLabel else cfgValue
    else
      if defaultEnabled then defaultLabel else false

# Add a timestamp to the console.log and console.error functions
initialize = (config = {}) ->
  cfg = {
    mode: config.mode ? defaultConfig.mode
    console: config.console ? defaultConfig.console
    alias: config.alias ? defaultConfig.alias
    error: validateLevel('ERROR')(config.error)
    warn: validateLevel('WARN')(config.warn)
    info: validateLevel('INFO')(config.info)
    verbose: validateLevel('VERBOSE', false)(config.verbose)
  }

  alias = if cfg.alias? then "#{orange(cfg.alias)}|" else ""
  error = if cfg.error then "#{red(cfg.error)}>" else false
  warn = if cfg.warn then "#{yellow(cfg.warn)}>" else false
  info = if cfg.info then "#{green(cfg.info)}>" else false
  verbose = if cfg.verbose then  "#{purple(cfg.verbose)}>" else false

  sub = (logger, categoryLabel) ->
    if categoryLabel
      (args...) ->
        [first, rest...] = args
        message = "[#{now(cfg.mode)}]#{alias}#{categoryLabel} #{first ? ''}"
        logger message, rest...
    else ->

  logger =
    error: sub(console_error, error)
    warn: sub(console_warn, warn)
    info: sub(console_info, info)
    verbose: sub(console_info, verbose)
    color: color

  console.error = if cfg.console then logger.error else console_error
  console.warn = if cfg.console then logger.warn else console_warn
  console.log = if cfg.console then logger.info else console_log
  console.info = if cfg.console then logger.info else console_info
  console.verbose = if cfg.console then logger.verbose else console_noop

  logger

# Make available to the user so they can configure explicitly
module.exports = initialize

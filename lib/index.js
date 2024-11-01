const moment = require('moment')
const color = require('@buzuli/color')

const { red, orange, yellow, green, blue, purple, gray } = color

const console_error = console.error
const console_warn = console.warn
const console_log = console.log
const console_info = console.info
const console_noop = () => {}

// Format the current time according to ISO-8601
function now (mode) {
  if (mode === 'local') {
    return blue(moment().format("YYYY-MM-DDTHH:mm:ss.SSSZ"))
  } else if (mode === 'unix') {
    return blue(`${Date.now()}`)
  } else if (mode === 'pony') {
    const ts = moment.utc()

    const d = gray('-')
    const T = gray('T')
    const c = gray(':')
    const p = gray('.')
    const Y = purple(ts.format('YYYY'))
    const M = blue(ts.format('MM'))
    const D = green(ts.format('DD'))
    const H = yellow(ts.format('HH'))
    const m = orange(ts.format('mm'))
    const s = red(ts.format('ss'))
    const S = purple(ts.format('SSS'))
    const Z = blue('Z')

    return `${Y}${d}${M}${d}${D}${T}${H}${c}${m}${c}${s}${p}${S}${Z}`
  } else if (mode === 'coded') {
    const ts = moment.utc()

    const d = gray('-')
    const T = gray('T')
    const c = gray(':')
    const p = gray('.')
    const Y = blue(ts.format('YYYY'))
    const M = blue(ts.format('MM'))
    const D = blue(ts.format('DD'))
    const H = yellow(ts.format('HH'))
    const m = yellow(ts.format('mm'))
    const s = yellow(ts.format('ss'))
    const S = yellow(ts.format('SSS'))
    const Z = gray('Z')

    return `${Y}${d}${M}${d}${D}${T}${H}${c}${m}${c}${s}${p}${S}${Z}`
  } else {
    return blue(moment.utc().toISOString())
  }
}

// Default configuration
const defaultConfig = {
  mode: 'utc',
  console: true,
  alias: undefined,
}

// Level validator
function validateLevel (defaultLabel, defaultEnabled = true) {
  function doValidate (cfgValue) {
    if (cfgValue == null) {
      if (defaultEnabled) {
        return defaultLabel
      } else {
        return false
      }
    } else {
      if (cfgValue === true) {
        return defaultLabel
      } else {
        return cfgValue
      }
    }
  }
  
  return doValidate
}

// Add a timestamp to the console.log and console.error functions
function initialize (config = {}) {
  const cfg = {
    mode: config.mode ? defaultConfig.mode,
    console: config.console ? defaultConfig.console,
    alias: config.alias ? defaultConfig.alias,
    error: validateLevel('ERROR')(config.error),
    warn: validateLevel('WARN')(config.warn),
    info: validateLevel('INFO')(config.info),
    verbose: validateLevel('VERBOSE', false)(config.verbose),
  }

  const alias = (cfg.alias != null) ? `${orange(cfg.alias)}|` : ""
  const error = cfg.error ? `${red(cfg.error)}>` : false
  const warn = cfg.warn ? `${yellow(cfg.warn)}>` : false
  const info = cfg.info ? `${green(cfg.info)}>` : false
  const verbose = cfg.verbose ?  `${purple(cfg.verbose)}>` : false

  function sub (logger, categoryLabel) {
    if (categoryLabel) {
      return (args...) => {
        const [first, rest...] = args
        const message = (first != null) ? first : ''
        message = `[${now(cfg.mode)}]${alias}${categoryLabel} ${message}`
        logger(message, rest...)
      }
    } else {
      return () => {}
    }
  }

  const logger = {
    error: sub(console_error, error),
    warn: sub(console_warn, warn),
    info: sub(console_info, info),
    verbose: sub(console_info, verbose),
    color: color,
  }

  console.error = cfg.console ? logger.error : console_error
  console.warn = cfg.console ? logger.warn : console_warn
  console.log = cfg.console ? logger.info : console_log
  console.info = cfg.console ? logger.info : console_info
  console.verbose = cfg.console ? logger.verbose : console_noop

  return logger
}

// Make available to the user so they can configure explicitly
module.exports = initialize

chalk = require 'chalk'

key = (name) -> chalk.keyword name
hex = (code) -> chalk.hex code

module.exports =
  red: chalk.red
  orange: key 'orange'
  yellow: chalk.yellow
  green: chalk.green
  blue: key 'lightblue'
  purple: key 'purple'
  gray: key 'gray'
  key: key
  hex: hex


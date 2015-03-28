postkode
==========

A gem to validate UK postcodes


### INSTALL:

From RubyGems: [![Gem Version](https://badge.fury.io/rb/postkode.svg)](http://badge.fury.io/rb/postkode)

### EXAMPLE USAGE:

require 'postkode'

Postkode.validate('WC2E 7PX')
=> true

Postkode.validate('NOT A POSTCODE')
=> false

Postkode.random
=> "M5 6RL"

### ACKNOWLEDGEMENTS

Postkode.random uses strrand random string generator by tama <repeatedly@gmail.com>
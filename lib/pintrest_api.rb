# Gem requires
#==============
require 'bundler/setup'

# Bundler Init
#==============
Bundler.require(:default)

# Pintrest Api requires
#=======================
require_relative './pintrest_api/version.rb'
require_relative './pintrest_api/core.rb'
require_relative './pintrest_api/authentication.rb'
require_relative './pintrest_api/board.rb'
require_relative './pintrest_api/pin.rb'

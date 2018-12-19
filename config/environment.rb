require "bundler/setup"
require_relative "./environments.rb"
Bundler.require(:default)

require_all "lib"
require_all "db"

Quorra.setup_error_notifier(self)

puts '
  ██████╗ ██████╗ ███████╗███████╗███████╗███████╗
  ██╔════╝██╔═══██╗██╔════╝██╔════╝██╔════╝██╔════╝
  ██║     ██║   ██║█████╗  █████╗  █████╗  █████╗
  ██║     ██║   ██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══╝
  ╚██████╗╚██████╔╝██║     ██║     ███████╗███████╗
  ╚═════╝ ╚═════╝ ╚═╝     ╚═╝     ╚══════╝╚══════╝

  ██████╗ ██╗   ██╗███████╗████████╗██╗ ██████╗
  ██╔══██╗██║   ██║██╔════╝╚══██╔══╝██║██╔═══██╗
  ██║  ██║██║   ██║███████╗   ██║   ██║██║   ██║
  ██║  ██║██║   ██║╚════██║   ██║   ██║██║   ██║
  ██████╔╝╚██████╔╝███████║   ██║██╗██║╚██████╔╝
  ╚═════╝  ╚═════╝ ╚══════╝   ╚═╝╚═╝╚═╝ ╚═════╝

'

#Chose which environment you want to load.
ENVIRONMENTS.select_environment(self)


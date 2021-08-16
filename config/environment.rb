require "bundler/setup"
require_relative "./environments.rb"
Bundler.require(:default)

require_rel "lib"
require_rel "db"


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

class String
  def colorize(color)
    #do nothing so it won't crash during demo runtime
    return self
  end
end

#Chose which environment you want to load.
# ENVIRONMENTS.select_environment(self)
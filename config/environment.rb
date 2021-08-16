require "bundler/setup"
require_relative "./environments.rb"
Bundler.require(:default)

require_all "lib"
require_all "db"


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
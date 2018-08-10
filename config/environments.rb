module ENVIRONMENTS
  module DEV

    def start_pry
      binding.pry
      puts "Welcome back! Now input a command fewl!"
      Quorra.say("Welcome back, now input a command fool")
    end

    def reload!
      load_all "./config" if Dir.exists?("./config")
      load_all "./app" if Dir.exists?("./app")
      load_all "./lib" if Dir.exists?("./lib")
      load_all "./*.rb" if Dir.entries(".").include?(/\.rb/)
    end

    def self.included(base)
      ENV["APP_ENV"] = "DEV"
      Bundler.require(:dev)
      puts '
         +--------------+
         |.------------.|
         ||>_          ||
         ||            ||
         ||            ||
         ||            ||
         |+------------+|
         +-..--------..-+
         .--------------.
         / /============\ \\
        / /==============\ \\
       /____________________\\
       \____________________/ '
      puts '
  ╔╦╗┌─┐┬  ┬┌─┐┬  ┌─┐┌─┐┌┬┐┌─┐┌┐┌┌┬┐
   ║║├┤ └┐┌┘├┤ │  │ │├─┘│││├┤ │││ │
  ═╩╝└─┘ └┘ └─┘┴─┘└─┘┴  ┴ ┴└─┘┘└┘ ┴
  ╔═╗┌┐┌┬  ┬┬┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌┬┐
  ║╣ │││└┐┌┘│├┬┘│ │││││││├┤ │││ │
  ╚═╝┘└┘ └┘ ┴┴└─└─┘┘└┘┴ ┴└─┘┘└┘ ┴
      '
    end

  end#endof dev

  module DEFAULT

    def self.included(base)
      ENV["APP_ENV"] = "DEFAULT"
    end

  end#endof default


end#endof module

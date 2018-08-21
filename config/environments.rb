module ENVIRONMENTS
  module DEV

    def start_dev_CLI
      puts "Welcome to the Development Environment.\nPlease input a command!\nUse 'list' to view commands."
      input = gets.strip
      while input != "exit"
        case input
          when "pry"
            start_pry
          when "reload"
            reload!
          when "rspec"
            puts "Type the number of the file you want to test as listed."
            list_rspec_dir
            rspec(gets.strip.to_i)
          when "test"
            puts "Type the number of the file you want to test as listed."
            list_rspec_dir
            rspec(gets.strip.to_i)
          when "list"
            list
          when "clear"
            clear_terminal
          else
            puts "Invalid command, use 'list'."
          end
        input = gets.strip
      end
    end

    def start_pry
      binding.pry
      puts "Welcome back! Now input a command fewl!"
      Quorra.say("Welcome back, now input a command fool")
    end

    def reload!
      puts "
  ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐┬┌┐┌┌─┐   
  ├┬┘├┤ │  │ │├─┤ │││││││ ┬   
  ┴└─└─┘┴─┘└─┘┴ ┴─┴┘┴┘└┘└─┘ooo                                                                                          
      "
      # load_all "./config" if Dir.exists?("./config")
      load_all "./lib/concerns" if Dir.exists?("./lib/concerns")
      load_all "./app" if Dir.exists?("./app")
      load_all "./lib" if Dir.exists?("./lib")
      load_all "./*.rb" if Dir.entries(".").include?(/\.rb/)
      load_all "./spec" if Dir.exists?("./spec")
    end

    def list_rspec_dir
      load_file = []
      files = Dir["./spec/*"]
      files.each do |file|
        load_file << File.basename(file)
      end
      load_file.each.with_index { |file, i| puts "#{i + 1}. #{file}"}
    end

    def rspec(file_number)
      load_file = []
      files = Dir["./spec/*"]
      files.each do |file|
        load_file << File.basename(file)
      end
      RSpec.reset
      RSpec::Core::Runner.run(["spec/#{load_file[file_number - 1]}"], $stderr, $stdout)
      RSpec.reset
    end

    def list
      list = ["pry", "reload", "rspec", "test"]
      list.each.with_index do |item, index|
        puts "#{index + 1}. #{item}"
      end
    end

    def clear_terminal
      100.times do
        puts "\n"
      end
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
  ┌┬┐┌─┐┬  ┬┌─┐┬  ┌─┐┌─┐┌┬┐┌─┐┌┐┌┌┬┐
   ││├┤ └┐┌┘├┤ │  │ │├─┘│││├┤ │││ │ 
  ─┴┘└─┘ └┘ └─┘┴─┘└─┘┴  ┴ ┴└─┘┘└┘ ┴ 
  ┌─┐┌┐┌┬  ┬┬┬─┐┌─┐┌┐┌┌┬┐┌─┐┌┐┌┌┬┐  
  ├┤ │││└┐┌┘│├┬┘│ │││││││├┤ │││ │   
  └─┘┘└┘ └┘ ┴┴└─└─┘┘└┘┴ ┴└─┘┘└┘ ┴   
      '
    end

  end#endof dev

  module DEFAULT

    def self.included(base)
      ENV["APP_ENV"] = "DEFAULT"
    end

  end#endof default


end#endof module

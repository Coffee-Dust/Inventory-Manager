class ENVIRONMENTS
  @@all = ["DEFAULT", "DEVELOPMENT", "SIMULATION"]

  def self.select_environment(base)

    puts "Please select the environment you wish to load into. \nNOTE: If you want to run the program normally, please select: DEFAULT\n"

    @@all.each.with_index do |name, i|
      puts "#{i + 1}. #{name}"
    end
    puts "Please enter the number of the selection you want."
    input = gets.strip
    case input
      when "1"
        ENV["APP_ENV"] = "DEFAULT"
      when "2"
        ENV["APP_ENV"] = "DEV"
      when "3"
        ENV["APP_ENV"] = "SIMULATION"
    end
    self.load_environment(base)
  end

  def self.load_environment(base)
  case ENV["APP_ENV"]
    when "DEV"
      base.send("include", ENVIRONMENTS::DEV)
      start_dev_CLI
    when "DEFAULT"
      base.send("include", ENVIRONMENTS::DEFAULT)
      # self.save_selection
    when "SIMULATION"
      base.send("include", ENVIRONMENTS::SIMULATION)
    end
  end

    # def self.save_selection
    #   puts "Would you like to save this environment selection and load into it automatically? y/n \nNOTE: You can change which environment you want with command \"change environment\" when on DEFAULT\n"
    #   if input = gets.strip == "y"
    #     hash = {environment: ENV["APP_ENV"]}

    #     File.truncate("db/saves/settings.json", 0)

    #     File.write("db/saves/settings.json",hash.to_json)
    #   else
    #     puts "Ok I won't save."
    #   end
    # end

  module DEV

    def start_dev_CLI
      startup_sound
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

    def start_program_cli
      im = Inventory_Manager.new
      ic = Interface_Controller.new(im)
      ic.start_program_loop
    end

    def reload!
      puts "
  ┬─┐┌─┐┬  ┌─┐┌─┐┌┬┐┬┌┐┌┌─┐   
  ├┬┘├┤ │  │ │├─┤ │││││││ ┬   
  ┴└─└─┘┴─┘└─┘┴ ┴─┴┘┴┘└┘└─┘ooo                                                                                          
      "
      startup_sound
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

    def startup_sound
      Thread.new do
        `afplay ~/Music/randomSounds/coffee_machine.mp3`
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

  module SIMULATION

  end

end#endof module

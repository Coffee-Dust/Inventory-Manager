class Interface_Controller
    include Interface_Controller::COMMANDS
    def initialize(manager)
        @manager = manager
        @command_history = []
        @available_commands = []
        #start command loop.
    end


    def start_program_loop
        call_method_from_input("home")

        while true do
            get_available_commands

            input = gets.strip

            call_method_from_input(input)

            break if input == "exit program"
        end
    end

    def get_available_commands
        @available_commands = []

        case @command_history.last
            when "focus_department"
                @available_commands = ["back, rename"]
            else
                @available_commands = ["view low inventory", "log order", "received order", "find items", "all departments", "add to database"]
        end
    end

    def call_method_from_input(input)
        begin
            number = Integer(input)
            sending = @available_commands[number - 1].split(" ").join("_")
            self.send(sending)
            @command_history << sending

        rescue => exception

            name = input.split(" ").join("_")
            begin
                self.send(name)
                @command_history << sending
            rescue => exception
                 puts "Could not find command. Please use 'list' or make sure you spelled the command EXACTLY as is."
            end
        end
    end

    def back
        #figure out when thinking better...
        @command_history.each.with_index do |c,i|
            
            self.send(c) if i < @command_history.length - 1
        end
    end


    def color_quantity(number)
        if number > 130
            return number.to_s.colorize(:green)
        else
            case number
                when 80...129
                    return number.to_s.colorize(:light_yellow)
                when 30...79
                    return number.to_s.colorize(:yellow)
                when 10...30
                    return number.to_s.colorize(:light_red)
                when 0...10
                    return number.to_s.colorize(:red)
            end
        end
    end

    def cut_off_after_comma(string)
        return string.split(",")[0]
    end

    def pry
        binding.pry
    end
end
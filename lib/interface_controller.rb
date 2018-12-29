class Interface_Controller
    include Interface_Controller::COMMANDS
    def initialize(manager)
        @manager = manager
        @command_history = []
        @available_commands = []
        @keep_commands = false
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
        if @keep_commands == false
            @available_commands.clear

            case @command_history.last
            when "focus_object"
                @available_commands = ["back, rename"]
                
            else
                @available_commands = ["view low inventory", "log order", "received order", "find items", "view all departments", "add to database"]

                if @command_history.last.is_a? Hash

                    case @command_history.last.keys[0]

                    when "focus_department"
                        @available_commands = ["view categories", "rename", "back", "delete"]
                    when "focus_category"
                        @available_commands = ["rename", "back", "delete"]
                        #This finds out whether the category has items or not and adds the right method to commands
                        if cat = @manager.find_object(@command_history.last["focus_category"]).items == nil
                            @available_commands << "view subcategories"

                        elsif cat.items != nil
                            @available_commands << "view items"
                        end
                    when "focus_subcategory"
                        @available_commands = ["view items", "rename", "back", "delete"]
                    else
                        @available_commands = ["back"]
                    end
                end
            end#endof first case
        end
        @keep_commands = false
    end

    def call_method_from_input(input)
        begin
            number = Integer(input)
            sending = @available_commands[number - 1].split(" ").join("_")
            if sending.include? "("
                #REGEX seperates the input method into sendable data.
                self.send(sending.scan(/^[a-z _]*/)[0], sending.scan(/\d[^ ()]*/)[0])
                @command_history << {sending.scan(/^[a-z _]*/)[0]=>sending.scan(/\d[^ ()]*/)[0]}
            else
                self.send(sending)
                @command_history << sending
            end

        rescue => exception

            name = input.split(" ").join("_")
            begin
                self.send(name)
                @command_history << name if name != "list" && name != "back"
            rescue => exception
                # binding.pry
                 puts "Could not find command. Please use 'list' or make sure you spelled the command EXACTLY as is."
            end
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



    def large_text(object)
        case object
        when "dept"
            puts '
██████╗ ███████╗██████╗  █████╗ ██████╗ ████████╗███╗   ███╗███████╗███╗   ██╗████████╗   
██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝████╗ ████║██╔════╝████╗  ██║╚══██╔══╝██╗
██║  ██║█████╗  ██████╔╝███████║██████╔╝   ██║   ██╔████╔██║█████╗  ██╔██╗ ██║   ██║   ╚═╝
██║  ██║██╔══╝  ██╔═══╝ ██╔══██║██╔══██╗   ██║   ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║   ██╗
██████╔╝███████╗██║     ██║  ██║██║  ██║   ██║   ██║ ╚═╝ ██║███████╗██║ ╚████║   ██║   ╚═╝
╚═════╝ ╚══════╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝      '
        when "categ"
            puts '
  █████╗ █████╗ ████████╗███████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗   
██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝ ██╔═══██╗██╔══██╗╚██╗ ██╔╝██╗
██║     ███████║   ██║   █████╗  ██║  ███╗██║   ██║██████╔╝ ╚████╔╝ ╚═╝
██║     ██╔══██║   ██║   ██╔══╝  ██║   ██║██║   ██║██╔══██╗  ╚██╔╝  ██╗
╚██████╗██║  ██║   ██║   ███████╗╚██████╔╝╚██████╔╝██║  ██║   ██║   ╚═╝
 ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝      
                                                                       
            '
        when "sub_categ"
            puts '
███████╗██╗   ██╗██████╗  ██████╗ █████╗ ████████╗███████╗ ██████╗  ██████╗ ██████╗ ██╗   ██╗   
██╔════╝██║   ██║██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔════╝██╔════╝ ██╔═══██╗██╔══██╗╚██╗ ██╔╝██╗
███████╗██║   ██║██████╔╝██║     ███████║   ██║   █████╗  ██║  ███╗██║   ██║██████╔╝ ╚████╔╝ ╚═╝
╚════██║██║   ██║██╔══██╗██║     ██╔══██║   ██║   ██╔══╝  ██║   ██║██║   ██║██╔══██╗  ╚██╔╝  ██╗
███████║╚██████╔╝██████╔╝╚██████╗██║  ██║   ██║   ███████╗╚██████╔╝╚██████╔╝██║  ██║   ██║   ╚═╝
╚══════╝ ╚═════╝ ╚═════╝  ╚═════╝╚═╝  ╚═╝   ╚═╝   ╚══════╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═╝   ╚═╝      
                                                                                                
            '

        when "item"
            puts '
██╗████████╗███████╗███╗   ███╗   
██║╚══██╔══╝██╔════╝████╗ ████║██╗
██║   ██║   █████╗  ██╔████╔██║╚═╝
██║   ██║   ██╔══╝  ██║╚██╔╝██║██╗
██║   ██║   ███████╗██║ ╚═╝ ██║╚═╝
╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝   
                                  
            '
        end
    end

    def pry
        binding.pry
    end
end
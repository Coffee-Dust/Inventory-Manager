class Interface_Controller
    include Interface_Controller::COMMANDS
    def initialize(manager)
        @manager = manager
        @command_history = []
        @available_commands = []
        @keep_commands = false
        #USE: To force an input, put the input value you want as the key. 
        #Then the number of gets loops you want to skip as the value.
        # Recommended to use 1 as value.
        @force_input = {"inputgoeshere"=>0}
        #This keeps track of the index of @command_history, 
        #      since view methods relys on it for object lookup.
        # makes the back method work for those methods.
        @command_index = 0
    end


    def start_program_loop
        call_method_from_input("home")
        while true do
            get_available_commands

            input = gets.strip if @force_input.values[0] == 0

            call_method_from_input(input)

            break if input == "exit program"
        end
    end

    def get_available_commands
        @command_index = @command_history.length - 1
        if @keep_commands == false
            @available_commands.clear

            case @command_history.last
            #Add a method name here if method does not have params(not a hash in @command_history)
            when "view_current_order"
                @available_commands = ["placed order", "delete order"]
                
            else
                #The default section, also checks for methods with params otherwise known as hashes
                #                                                               in command history.
                @available_commands = ["view low inventory", "view current order", "received shipment", "find items", "view all departments", "add to database"]

                if @command_history.last.is_a? Hash

                    case @command_history.last.keys[0]

                    when "focus_department"
                        @available_commands = ["view categories", "rename", "back", "delete"]

                    when "focus_category"
                        @available_commands = ["rename", "back", "delete"]
                        #This finds out whether the category has items or not and adds the right method to commands
                        categ = @manager.find_object(@command_history.last["focus_category"])
                        if categ.items == nil
                            @available_commands << "view subcategories"

                        elsif categ.items != nil
                            @available_commands << "view items"
                        end

                    when "focus_subcategory"
                        @available_commands = ["view items", "rename", "back", "delete"]

                    when "focus_item"
                        @available_commands = ["received this item", "add to current order", "rename", "change location", "change info", "delete"]

                    else
                        @available_commands = ["back"]
                    end
                end
            end#endof first case
        end
        @keep_commands = false
    end

    def call_method_from_input(input)
        #If there is a @forceinput, this assigns it to input to be used.
        #also subtracts the number of loops it will skip.
        if @force_input.values[0] != 0
            input = @force_input.keys[0]
            @force_input[@force_input.keys[0]] -= 1
        end

        @command_history.clear if input == "home"

        begin
            #This checks input is a number, if it is, it selects the number in @available_commands.
            number = Integer(input)
            sending = @available_commands[number - 1].split(" ").join("_")
            #This checks if the method has params, if so it will send with those params
            if sending.include? "("
                #REGEX seperates the input method into sendable data.
                self.send(sending.scan(/^[a-z _]*/)[0], sending.scan(/\d[^ ()]*/)[0])
                @command_history << {sending.scan(/^[a-z _]*/)[0]=>sending.scan(/\d[^ ()]*/)[0]}
            else
                self.send(sending)
                @command_history << sending
            end
        rescue => exception
            #input is number failed, so input is not a number.
            #Now it sends the method using its name...

            name = input.split(" ").join("_")
            begin
                self.send(name)
                @command_history << name if name != "list" && name != "back"
            rescue => exception
                #All inputs failed, command is not available

                #view methods need to keep there commands when called again, such as with back.
                @keep_commands = true if @command_history.last.include?("view")

                puts "Could not find command. Please use 'list' or make sure you spelled the command EXACTLY as is. \nOr make sure you selected a number within the range of options."
            end
        end
    end


    def color_quantity(number)
        if number >= 130
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

    def viewable_date(date)
        return "#{date.month}-#{date.day}-#{date.year}"
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

        when "low_inv"
            puts '
██╗      ██████╗ ██╗    ██╗    ██╗███╗   ██╗██╗   ██╗███████╗███╗   ██╗████████╗ ██████╗ ██████╗ ██╗   ██╗
██║     ██╔═══██╗██║    ██║    ██║████╗  ██║██║   ██║██╔════╝████╗  ██║╚══██╔══╝██╔═══██╗██╔══██╗╚██╗ ██╔╝
██║     ██║   ██║██║ █╗ ██║    ██║██╔██╗ ██║██║   ██║█████╗  ██╔██╗ ██║   ██║   ██║   ██║██████╔╝ ╚████╔╝ 
██║     ██║   ██║██║███╗██║    ██║██║╚██╗██║╚██╗ ██╔╝██╔══╝  ██║╚██╗██║   ██║   ██║   ██║██╔══██╗  ╚██╔╝  
███████╗╚██████╔╝╚███╔███╔╝    ██║██║ ╚████║ ╚████╔╝ ███████╗██║ ╚████║   ██║   ╚██████╔╝██║  ██║   ██║   
╚══════╝ ╚═════╝  ╚══╝╚══╝     ╚═╝╚═╝  ╚═══╝  ╚═══╝  ╚══════╝╚═╝  ╚═══╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝   ╚═╝   
                                                                                                          
            '

        when "current_order"
            puts '
 ██████╗██╗   ██╗██████╗ ██████╗ ███████╗███╗   ██╗████████╗     ██████╗ ██████╗ ██████╗ ███████╗██████╗ 
██╔════╝██║   ██║██╔══██╗██╔══██╗██╔════╝████╗  ██║╚══██╔══╝    ██╔═══██╗██╔══██╗██╔══██╗██╔════╝██╔══██╗
██║     ██║   ██║██████╔╝██████╔╝█████╗  ██╔██╗ ██║   ██║       ██║   ██║██████╔╝██║  ██║█████╗  ██████╔╝
██║     ██║   ██║██╔══██╗██╔══██╗██╔══╝  ██║╚██╗██║   ██║       ██║   ██║██╔══██╗██║  ██║██╔══╝  ██╔══██╗
╚██████╗╚██████╔╝██║  ██║██║  ██║███████╗██║ ╚████║   ██║       ╚██████╔╝██║  ██║██████╔╝███████╗██║  ██║
 ╚═════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝        ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚═╝  ╚═╝
                                                                                                         
            '

        when "received_shipment"
            puts '
███████╗██╗  ██╗██╗██████╗ ███╗   ███╗███████╗███╗   ██╗████████╗    ██████╗ ███████╗ ██████╗███████╗██╗██╗   ██╗███████╗██████╗ 
██╔════╝██║  ██║██║██╔══██╗████╗ ████║██╔════╝████╗  ██║╚══██╔══╝    ██╔══██╗██╔════╝██╔════╝██╔════╝██║██║   ██║██╔════╝██╔══██╗
███████╗███████║██║██████╔╝██╔████╔██║█████╗  ██╔██╗ ██║   ██║       ██████╔╝█████╗  ██║     █████╗  ██║██║   ██║█████╗  ██║  ██║
╚════██║██╔══██║██║██╔═══╝ ██║╚██╔╝██║██╔══╝  ██║╚██╗██║   ██║       ██╔══██╗██╔══╝  ██║     ██╔══╝  ██║╚██╗ ██╔╝██╔══╝  ██║  ██║
███████║██║  ██║██║██║     ██║ ╚═╝ ██║███████╗██║ ╚████║   ██║       ██║  ██║███████╗╚██████╗███████╗██║ ╚████╔╝ ███████╗██████╔╝
╚══════╝╚═╝  ╚═╝╚═╝╚═╝     ╚═╝     ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝       ╚═╝  ╚═╝╚══════╝ ╚═════╝╚══════╝╚═╝  ╚═══╝  ╚══════╝╚═════╝ 
                                                                                                                                 
            '

        when "add_data"
            puts '
 █████╗ ██████╗ ██████╗     ████████╗ ██████╗     ██████╗  █████╗ ████████╗ █████╗ ██████╗  █████╗ ███████╗███████╗
██╔══██╗██╔══██╗██╔══██╗    ╚══██╔══╝██╔═══██╗    ██╔══██╗██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝
███████║██║  ██║██║  ██║       ██║   ██║   ██║    ██║  ██║███████║   ██║   ███████║██████╔╝███████║███████╗█████╗  
██╔══██║██║  ██║██║  ██║       ██║   ██║   ██║    ██║  ██║██╔══██║   ██║   ██╔══██║██╔══██╗██╔══██║╚════██║██╔══╝  
██║  ██║██████╔╝██████╔╝       ██║   ╚██████╔╝    ██████╔╝██║  ██║   ██║   ██║  ██║██████╔╝██║  ██║███████║███████╗
╚═╝  ╚═╝╚═════╝ ╚═════╝        ╚═╝    ╚═════╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚══════╝╚══════╝
                                                                                                                   
            '
        end
    end

    def pry
        binding.pry
    end
end
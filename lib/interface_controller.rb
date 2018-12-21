class Interface_Controller
    include Interface_Controller::COMMANDS
    def initialize(manager)
        @manager = manager
        #start command loop.
    end

    def view_home
        puts '
██╗  ██╗ ██████╗ ███╗   ███╗███████╗
██║  ██║██╔═══██╗████╗ ████║██╔════╝
███████║██║   ██║██╔████╔██║█████╗  
██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  
██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝'

        puts "To return to home at anytime, type \'home\'"

        low_items = @manager.get_lowest_quantity
        
        puts "\nLow Inventory: Order soon!"

        puts "#{low_items[0].department.name}: #{low_items[0].name}: #{color_quantity(low_items[0].quantity)} | #{low_items[1].department.name}: #{low_items[1].name}: #{color_quantity(low_items[1].quantity)}"
        puts "\n#{low_items[2].department.name}: #{low_items[2].name}: #{color_quantity(low_items[2].quantity)} | #{low_items[3].department.name}: #{low_items[3].name}: #{color_quantity(low_items[3].quantity)}"
        puts "\n#{low_items[4].department.name}: #{low_items[4].name}: #{color_quantity(low_items[4].quantity)} | #{low_items[5].department.name}: #{low_items[5].name}: #{color_quantity(low_items[5].quantity)}"
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

    def pry
        binding.pry
    end
end
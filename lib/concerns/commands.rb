class Interface_Controller

    module COMMANDS
        def home
            puts "\n\n\n\n\n\n\n\n\n"
            puts '
██╗  ██╗ ██████╗ ███╗   ███╗███████╗
██║  ██║██╔═══██╗████╗ ████║██╔════╝
███████║██║   ██║██╔████╔██║█████╗  
██╔══██║██║   ██║██║╚██╔╝██║██╔══╝  
██║  ██║╚██████╔╝██║ ╚═╝ ██║███████╗
╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝'

            puts "To return to home at anytime, type \'home\'"

            low_items = @manager.get_lowest_quantity

            puts "\n\nLow Inventory: Order soon!".colorize(:light_red)

            puts "#{low_items[0].department.name}: #{cut_off_after_comma(low_items[0].name)}: #{color_quantity(low_items[0].quantity)} | #{low_items[1].department.name}: #{cut_off_after_comma(low_items[1].name)}: #{color_quantity(low_items[1].quantity)} | #{low_items[2].department.name}: #{cut_off_after_comma(low_items[2].name)}: #{color_quantity(low_items[2].quantity)}"
            puts "#{low_items[3].department.name}: #{cut_off_after_comma(low_items[3].name)}: #{color_quantity(low_items[3].quantity)} | #{low_items[4].department.name}: #{cut_off_after_comma(low_items[4].name)}: #{color_quantity(low_items[4].quantity)} | #{low_items[5].department.name}: #{cut_off_after_comma(low_items[5].name)}: #{color_quantity(low_items[5].quantity)}"
            puts "#{low_items[6].department.name}: #{cut_off_after_comma(low_items[6].name)}: #{color_quantity(low_items[6].quantity)} | #{low_items[7].department.name}: #{cut_off_after_comma(low_items[7].name)}: #{color_quantity(low_items[7].quantity)} | #{low_items[8].department.name}: #{cut_off_after_comma(low_items[8].name)}: #{color_quantity(low_items[8].quantity)}"
            
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            puts "Commands:"
            puts "1. View low inventory, 2. Log order, 3. Received Order, 4. Find items, 5. View all departments, 6. Add to database"
            puts "or use 'list' to view all available commands."
        end

        def back
            @command_history.pop
            @command_history.each.with_index do |c,i|
                if c.is_a? Hash
                    c.each do |key, value|
                        self.send(key, value)
                    end
                end
                self.send(c)
            end
        end

        def list
            puts "\n"
            @available_commands.each.with_index do |c, i|
                puts "#{i + 1}. #{c.capitalize}"
            end
            puts "Enter number of command or name(in all lowercase)."
        end

        def view_all_departments
            puts "\n"
            @manager.sort_by_name(Department.all).each.with_index {|d, i| puts "#{i+1}. #{d.name}"}
            puts "Please enter number of selection."
            @available_commands.clear
            @manager.sort_by_name(Department.all).each do |dept| 
                @available_commands << "focus object(#{dept.object_id})"
            end
            @keep_commands = true
        end

        def focus_object(object_id)

            object = @manager.find_object(object_id) 
            puts "\n"
            large_text("dept")
            puts "\n#{object.name}"

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

        end

        def rename
            puts "Ill rename it when i get to it"
        end

    end#endof module
    
end
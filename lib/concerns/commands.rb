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

            puts "\n\n\n\nLow Inventory: Order soon!".colorize(:light_red)
            begin
                puts "#{low_items[0].department.name}: #{cut_off_after_comma(low_items[0].name)}: #{color_quantity(low_items[0].quantity)} | #{low_items[1].department.name}: #{cut_off_after_comma(low_items[1].name)}: #{color_quantity(low_items[1].quantity)} | #{low_items[2].department.name}: #{cut_off_after_comma(low_items[2].name)}: #{color_quantity(low_items[2].quantity)}"
            rescue => exception
                puts "                  |                        |                     "
            end
            begin
                puts "#{low_items[3].department.name}: #{cut_off_after_comma(low_items[3].name)}: #{color_quantity(low_items[3].quantity)} | #{low_items[4].department.name}: #{cut_off_after_comma(low_items[4].name)}: #{color_quantity(low_items[4].quantity)} | #{low_items[5].department.name}: #{cut_off_after_comma(low_items[5].name)}: #{color_quantity(low_items[5].quantity)}"
            rescue => exception
                puts "                  |                        |                     "
            end
            begin
                puts "#{low_items[6].department.name}: #{cut_off_after_comma(low_items[6].name)}: #{color_quantity(low_items[6].quantity)} | #{low_items[7].department.name}: #{cut_off_after_comma(low_items[7].name)}: #{color_quantity(low_items[7].quantity)} | #{low_items[8].department.name}: #{cut_off_after_comma(low_items[8].name)}: #{color_quantity(low_items[8].quantity)}"
            rescue => exception
                puts "                  |                        |                     "
            end

            soon_items = @manager.get_soon_to_be_received

            puts "\n\n\n\n\n\n\n\nItems soon to be received:".colorize(:green)
            puts "Format; Department: Item: Date ordered"
            puts ""

            begin
                print "#{soon_items[0].department.name}: #{cut_off_after_comma(soon_items[0].name)}: #{viewable_date(soon_items[0].last_ordered)} | "
                print "#{soon_items[1].department.name}: #{cut_off_after_comma(soon_items[1].name)}: #{viewable_date(soon_items[1].last_ordered)} | "
                print "#{soon_items[2].department.name}: #{cut_off_after_comma(soon_items[2].name)}: #{viewable_date(soon_items[2].last_ordered)}"
            rescue => exception
                puts "                  |                        |                     "
            end

            begin
                print "#{soon_items[3].department.name}: #{cut_off_after_comma(soon_items[3].name)}: #{viewable_date(soon_items[3].last_ordered)} | "
                print "#{soon_items[4].department.name}: #{cut_off_after_comma(soon_items[4].name)}: #{viewable_date(soon_items[4].last_ordered)} | "
                print "#{soon_items[5].department.name}: #{cut_off_after_comma(soon_items[5].name)}: #{viewable_date(soon_items[5].last_ordered)}"
            rescue => exception
                # puts "                  |                        |                     "
            end
            

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            puts "Commands:"
            puts "1. View low inventory, 2. View current order, 3. Received Order, 4. Find items, 5. View all departments, 6. Add to database"
            puts "or use 'list' to view all available commands."
        end

        def back
            @command_history.pop
            @command_history.each.with_index do |c,i|
                @command_index = i - 1
                if c.is_a? Hash
                    c.each do |key, value|
                        self.send(key, value)
                    end
                else
                    self.send(c)
                end
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
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\nPlease Choose a Department:\n"
            @manager.sort_by_name(Department.all).each.with_index {|d, i| puts "#{i+1}. #{d.name}"}
            puts "Please enter number of selection."
            @available_commands.clear
            @manager.sort_by_name(Department.all).each do |dept| 
                @available_commands << "focus department(#{dept.object_id})"
            end
            @keep_commands = true
        end

        def focus_department(object_id)

            dept = @manager.find_object(object_id) 
            puts "\n"
            large_text("dept")
            puts "\nName: #{dept.name}"
            puts "\n\n\nCategories: "
            dept.categories.each do |cat|
                puts "   #{cat.name}"
            end

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            puts "Available commands:\n1. View categories, 2. rename, 3. back, 4. delete"
        end

        def view_categories
            dept = @manager.find_object(@command_history[@command_index].values[0])
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\nPlease Choose a Category:\n"
            @manager.sort_by_name(dept.categories).each.with_index {|c, i| puts "#{i+1}. #{c.name}"}
            puts "Please enter number of selection."
            @available_commands.clear
            @manager.sort_by_name(dept.categories).each do |categ|
                @available_commands << "focus category(#{categ.object_id})"
            end
            @keep_commands = true
        end

        def focus_category(object_id)
            categ = @manager.find_object(object_id) 
            puts "\n"
            large_text("categ")
            puts "\nName: #{categ.name}"
            if categ.items == nil
                #Has no items so its a sub_category
                puts "\n\n\nSub-Categories: "
                categ.sub_categories.each do |subcat|
                    puts "   #{subcat.name}"
                end
                puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                puts "Available commands:\n1. rename, 2. back, 3. delete, 4. view subcategories"
            else

                puts "\n\n\nItems: "
                categ.items.each.with_index do |item, i|
                    break if i >= 15
                    puts "   #{item.name}"
                end
                puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                puts "Available commands:\n1. rename, 2. back, 3. delete, 4. view items"
            end

        end

        def view_subcategories
            categ = @manager.find_object(@command_history[@command_index]["focus_category"])
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\nPlease Choose a Sub-Category:\n"
            @manager.sort_by_name(categ.sub_categories).each.with_index {|s, i| puts "#{i+1}. #{s.name}"}
            puts "Please enter number of selection."
            @available_commands.clear
            @manager.sort_by_name(categ.sub_categories).each do |subcat|
                @available_commands << "focus subcategory(#{subcat.object_id})"
            end
            @keep_commands = true
        end

        def focus_subcategory(object_id)
            subcat = @manager.find_object(object_id) 
            puts "\n"
            large_text("sub_categ")
            puts "\nName: #{subcat.name}"
            puts "\n\n\nItems: "
            subcat.items.each.with_index do |item,i|
                break if i >= 15
                puts "   #{item.name}"
            end

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            puts "Available commands:\n1. view items, 2. rename, 3. back, 4. delete"
        end

        def view_items
            parent = @manager.find_object(@command_history[@command_index].values[0])
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\nPlease Choose an Item:\n"
            @manager.sort_by_name(parent.items).each.with_index {|item, i| puts "#{i+1}. #{item.name}"}
            puts "Please enter number of selection."
            @available_commands.clear
            @manager.sort_by_name(parent.items).each do |item|
                @available_commands << "focus item(#{item.object_id})"
            end
            @keep_commands = true
        end

        def focus_item(object_id)
            item = @manager.find_object(object_id) 
            puts "\n"
            large_text("item")
            puts "\nName: #{item.name}"
            puts "\n\n\nItem info: "
            puts "  SKU: #{item.sku}"
            puts "  Quantity: #{color_quantity(item.quantity)}"
            puts "  Weight: #{item.weight}"
            puts "  Last Ordered: #{item.last_ordered}"
            puts "  Last Received: #{item.last_received}"

            puts "\n\n  Department: #{item.department.name}\n  Category: #{item.category.name}\n"

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            puts "Available commands:\n1. received shipment, 2. add to current order 3. rename, 4. change location, 5. change info"
        end

        def view_low_inventory
            large_text("low_inv")
        end

        def find_items
            find_options = ["SKU"]
            puts "Would you like to find your item using: \n1. SKU, 2. Name, 3. Weight"
            input = gets.strip
            case input
            when "1"
                puts "Please input SKU exactly."
                sku = gets.strip
                item = Item.find_by_SKU(sku)

                @available_commands = ["focus item(#{item.object_id})"]
                @keep_commands = true
                # puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                # puts "Please select: \n1. View item\n\nChoose selection by number."
                @force_input = {"1"=> 1}

            when "2"
                puts "Please input name exactly."
                name = gets.strip
                item = Item.find_by_name(name)

                @available_commands = ["focus item(#{item.object_id})"]
                @keep_commands = true
                @force_input = {"1"=> 1}

            when "3"
                puts "Please input weight exactly(including any describing words)."
                weight = gets.strip
                item = Item.find_by_weight(weight)

                @available_commands = ["focus item(#{item.object_id})"]
                @keep_commands = true
                @force_input = {"1"=> 1}
            when "back"
                @command_history.pop
                self.back

            when "home"
                self.home

            else
                puts "Please input a correct selection."
            end
        end

        def view_current_order

        end

        def received_shipment

        end

        def rename
            object = @manager.find_object(@command_history[@command_index].values[0])
            puts "Enter new name:"
            name = gets.strip
            object.name = name
            puts "Name changed to #{object.name}"

        end

        def change_location
            object = @manager.find_object(@command_history[@command_index].values[0])
            puts "ill change location when i change location, GOsh!"

        end

        def change_info
            object = @manager.find_object(@command_history[@command_index].values[0])

        end

    end#endof module
    
end
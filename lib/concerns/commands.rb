class Interface_Controller

    module COMMANDS
        def home
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
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

            puts "\n\n\n\nItems soon to be received:".colorize(:green)
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
            

            puts "\n\n\n\n"
            puts "Commands:"
            puts "1. View low inventory, 2. View current order, 3. Received Order, 4. Find items, 5. View all departments, 6. Add to database"
            puts "or use 'list' to view all available commands."
        end

        def back
            @command_history.pop
            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
            c = @command_history.last
            @command_index -= 2
            if c.is_a? Hash
                c.each do |key, value|
                    self.send(key, value)
                end
            else
                self.send(c)
            end
            #REMOVED: Back used to call all the methods in the history, 
            # this proved to be too unstable and was removed.
            # @command_history.each.with_index do |c,i|
            #     puts "\n\n\n\n\n\n\n\n\n"
            #     @command_index = i - 1
            #     if c.is_a? Hash
            #         c.each do |key, value|
            #             self.send(key, value)
            #         end
            #     else
            #         self.send(c)
            #     end
            # end
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

            puts "\n\n\n\n\n\n\n\n"
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
            #This error catch is when the category has neither items nor sub_categs
            begin
                if categ.items == nil
                    #Has no items so its a sub_category
                    puts "\n\n\nSub-Categories: "
                    categ.sub_categories.each do |subcat|
                        puts "   #{subcat.name}"
                    end
                    puts "\n\n\n\n\n\n\n\n\n\n\n\n\n"
                    puts "Available commands:\n1. rename, 2. back, 3. delete, 4. view subcategories"
                else

                    puts "\n\n\nItems: "
                    categ.items.each.with_index do |item, i|
                        break if i >= 15
                        puts "   #{item.name}"
                    end
                    puts "\n\n\n\n\n\n\n\n\n\n\n\n"
                    puts "Available commands:\n1. rename, 2. back, 3. delete, 4. view items"
                end
            rescue => exception
                puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
                puts "Available commands:\n1. rename, 2. back, 3. delete"
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

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
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

            puts "\n\n\n\n\n\n\n\n"
            puts "Available commands:\n1. received this item, 2. add to current order 3. rename, 4. change location, 5. change info, 6. delete"
        end

        def view_low_inventory
            puts "\n\n\n\n\n\n\n\n\n"
            large_text("low_inv")
            @available_commands.clear
            puts "Type the number of the selection you want to view. Then when viewing it, add to current order.\n"
            low_inv = @manager.get_lowest_quantity

            puts "Lowest Inventory: Order now!".colorize(:light_red)
            puts "\n"
            low_inv.each.with_index do |item,i|
                break if i >= 25
                puts "  #{i + 1}. #{item.name}: #{color_quantity(item.quantity)}"
                @available_commands << "focus item(#{item.object_id})"
            end
            @keep_commands = true
            puts "\n\n\n\n\n\n\n\n"
            puts "Available commands:\nType selection of item you want to view and order."
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
            large_text("current_order")
            puts "NOTE: This does not order the item from the manufacturer. It is just for record keeping."
            puts "\n\n"
            @manager.current_order.each do |hash|
                hash.each do |id, quantity|
                    item = @manager.find_object(id)
                    puts "#{item.department.name}: #{item.name}\n      order amount: #{quantity}"
                end
            end

            puts "\n\n\n\n\n\n\n\n"
            puts "Available commands:\n1. placed order, 2. delete order"
        end

        def placed_order
            puts "Logging the items you've ordered..."
            @manager.place_current_order
            puts "Done, please return home."
        end

        def delete_order
            puts "Removing items from current order..."
            @manager.current_order.clear
            puts "Done, order cleared. Please return home."
        end

        def received_this_item
            begin
                item = @manager.find_object(@command_history[@command_index].values[0])
                puts "Please enter quantity:"
                quantity = gets.strip
                @manager.received_item(item, Integer(quantity))
                puts "Quantity is now: #{item.quantity}. Please use home."
            rescue => exception
                puts "Sorry, please enter a number only."
            end
        end

        def received_shipment
            large_text("received_shipment")
            puts "NOTE: You will enter the item by SKU and then the quantity. When you are finished, type 'done'"

            puts "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"

            while true do
                puts "Enter the SKU and then the quantity in this format: SKU:QUANTITY\nType done when finished."
                input = gets.strip
                break if input == "done"

                begin
                    split = input.split(":")
                    @manager.received_item(Item.find_by_SKU(split[0]), Integer(split[1]))
                rescue => exception
                    binding.pry
                    puts "Error: Remember no spaces, input exactly as SKU:QUANTITY"
                end
            end
        end

        def add_to_current_order
            item = @manager.find_object(@command_history[@command_index].values[0])
            puts "Please type in the amount you want to order: "
            begin
                input = Integer(gets.strip)
            rescue => exception
                puts "I'm sorry you did not enter a number."
                self.back
            end

            puts "\nOrdering #{input} units of #{item.name}"

            @manager.add_to_current_order(item, input)

            @force_input = {"view current order"=>1}

        end

        def add_to_database
            puts "\n\n\n\n\n\n\n\n\n"
            large_text("add_data")
            puts "NOTE: You can add-on to existing Departments and Categories, or you can create new ones."

            puts "\n\n\n\n\n\n\n\n"
            
            puts "Type done when finished."
            puts "Available commands:\n1. create new item, 2. create new sub-category 3. create new category, 4. create new department"
            attributes = {}
            dept, categ, sub_categ = nil, nil, nil

            while true do
                input = gets.strip
                case input
                when "1"
                    item_method_names = {"name"=>"name", "brand name"=>"brand_name", "description"=>"desc", "weight"=>"weight", "quantity you aleady have,"=>"quantity", "SKU"=>"sku", "date you last ordered"=>"last_ordered", "date you last received"=>"last_received"}

                    #Getting the parents...
                    while dept == nil do
                        puts "Please input the name of the department EXACTLY."
                        input = gets.strip
                        dept = Department.find_by_name(input)
                        if dept == nil
                            puts "Could not find that department, please check spelling."
                        else
                            break
                        end
                    end
                    while categ == nil
                        puts "Please input the name of the category EXACTLY."
                        input = gets.strip
                        categ = dept.find_category(Category.find_by_name(input))
                        if categ == nil
                            puts "Could not find that category, please check spelling."
                        else
                            attributes["category"] = categ
                            break
                        end
                    end
                    if categ.sub_categories != nil
                        while sub_categ == nil do
                            puts "Please input the name of the sub-category in that category."
                            input = gets.strip

                            sub_categ = Sub_Category.find_by_name(input)

                            if sub_categ != nil && sub_categ.category == categ
                                attributes["sub_category"] = sub_categ
                                break
                            else #when the subcategory does not belong to the category
                                sub_categ = nil
                                puts "Could not find that sub-category. Make sure its a sub-category of the category you already chose."
                            end
                        end
                    end

                    #Assigning the items information.
                    item_method_names.each do |name, method|
                        puts "Please input the #{name} of the item. If you want to skip this input, just leave it blank and hit enter."
                        input = gets.strip
                        input = Integer(input) if method == "quantity"
                        attributes[method] = input
                    end

                    created_item = @manager.create_item(attributes)

                    #This will force view the new item.
                    @available_commands = ["focus item(#{created_item.object_id})"]
                    @keep_commands = true
                    @force_input = {"1"=>1}

                    break

                when "2"

                    while dept == nil do
                        puts "Please input the name of the department EXACTLY."
                        input = gets.strip
                        dept = Department.find_by_name(input)
                        if dept == nil
                            puts "Could not find that department, please check spelling."
                        else
                            break
                        end
                    end
                    while categ == nil
                        puts "Please input the name of the category EXACTLY."
                        input = gets.strip
                        categ = dept.find_category(Category.find_by_name(input))
                        if categ == nil
                            puts "Could not find that department, please check spelling."
                        elsif categ.sub_categories == nil
                            puts "Sorry, you must choose a category with existing sub-categories."
                        else
                            attributes["category"] = categ
                            break
                        end
                    end

                    puts "Please input the name of the sub-category you wish to make."
                    input = gets.strip
                    attributes["name"] = input

                    created_sub_categ = @manager.create_sub_category(attributes) 
                    
                    puts "Created new Sub-Category named: #{created_sub_categ.name}."
                    break

                when "3"
                    while dept == nil do
                        puts "Please input the name of the department EXACTLY."
                        input = gets.strip
                        dept = Department.find_by_name(input)
                        if dept == nil
                            puts "Could not find that department, please check spelling."
                        else
                            attributes["department"] = dept
                            break
                        end
                    end

                    puts "Please input the name of the category you wish to make."
                    input = gets.strip
                    attributes["name"] = input

                    created_categ = @manager.create_category(attributes) 

                    puts "Created new Category named: #{created_categ.name}."
                    break

                when "4"
                    puts "Please input the name of the department you wish to make."
                    input = gets.strip
                    attributes["name"] = input

                    created_dept = @manager.create_department(attributes) 

                    puts "Created new Department named: #{created_dept.name}."
                    break

                end#end of case
                if input == "done"
                    puts "Exiting 'add to database'\nPlease use home."
                    break
                end
            end
        end

        def rename
            object = @manager.find_object(@command_history[@command_index].values[0])
            puts "Enter new name:"
            name = gets.strip
            object.name = name
            puts "Name changed to #{object.name}"

        end

        def change_location
            item = @manager.find_object(@command_history[@command_index].values[0])
            dept, categ, sub_categ = nil, nil, nil

            while dept == nil do
                puts "Please input the name of the department EXACTLY."
                input = gets.strip
                dept = Department.find_by_name(input)
                if dept == nil
                    puts "Could not find that department, please check spelling."
                else
                    break
                end
            end

            while categ == nil do
                puts "Please input the name of the category in that department EXACTLY."
                input = gets.strip
                categ = dept.find_category(Category.find_by_name(input))
                if categ == nil
                    puts "Could not find that category in that department, please make sure its spelled correctly and is part of that department."
                else
                    break
                end
            end

            if categ.sub_categories != nil
                while sub_categ == nil do
                    puts "Please input the name of the sub-category in that category."
                    input = gets.strip

                    sub_categ = Sub_Category.find_by_name(input)
                    if sub_categ != nil && sub_categ.category == categ
                        item.sub_category = sub_categ
                        # item.category = categ #BUGFIX?: CODE C001
                        puts "Changed location to: #{dept.name}: #{categ.name}: #{sub_categ.name}. \nPlease use home to return to the home page."
                        break
                    else #when the subcategory does not belong to the category
                        sub_categ = nil
                        puts "Could not find that sub-category. Make sure its a sub-category of the category you already chose."
                    end
                end

            else #when there is no sub_category:
                item.category = categ
                puts "Changed location to: #{dept.name}: #{categ.name}. \nPlease use home to return to the home page."
            end
        end

        def change_info
            item = @manager.find_object(@command_history[@command_index].values[0])
            puts "Here you can change items information. Please select info you want to change. \nWhen done, type 'done'"
            while true do
                puts "1. Change SKU, 2. Change Quantity, 3. Change Weight, 4. Change last ordered date, 5. Change last received date."
                input = gets.strip
                case input
                when "1"
                    puts "Please enter new SKU."
                    input = gets.strip
                    item.sku = input
                    puts "Changed SKU to: #{input}"
                when "2"
                    puts "Please enter new quantity."
                    input = gets.strip
                    item.quantity = Integer(input)
                    puts "Changed quantity to: #{input}"
                when "3"
                    puts "Please enter new weight."
                    input = gets.strip
                    item.weight = input
                    puts "Changed weight to: #{input}"
                when "4"
                    puts "Please input time as: year-month-day in numbers with dashes(no spaces)"
                    input = gets.strip
                    dates = input.split("-")
                    item.last_ordered = Time.new(dates[0].to_i, dates[1].to_i, dates[2].to_i)
                    puts "Changed last ordered date to: #{item.last_ordered}"
                when "5"
                    puts "Please input time as: year-month-day in numbers with dashes(no spaces)"
                    input = gets.strip
                    dates = input.split("-")
                    item.last_received = Time.new(dates[0].to_i, dates[1].to_i, dates[2].to_i)
                    puts "Changed last received date to: #{item.last_received}"
                else
                    puts "Please input the number of selection. To quit, type 'done'"
                end
                break if input == "done"
            end
        end

        def delete
            object = @manager.find_object(@command_history[@command_index].values[0])
            puts "Once deleted, #{object.name} cannot be recovered. If you are deleting a department or category, all items in them will be deleted too."
            puts "Are you sure you want to delete #{object.name}? type yes or no"

            input = gets.strip

            if input == "yes"
                @manager.delete_object(object)
                puts "Deleted #{object.name}. Please type home."
            elsif input == "no"
                puts "Canceling delete, Please type home or back."
            else
                puts "Please enter yes or no."
            end
        end


    end#endof module
    
end
class Inventory_Manager
    attr_reader :current_order

    def initialize
        puts "Starting Inventory Manager..."
        @dbc = Database_Controller.new(self)
        @current_order = []
    end

    def save_data_on_exit
      if Thread.current.thread_variable_get("JSON_SAVED_ON_EXIT") == nil
        puts "Saving all data to database save file."
        @dbc.save_data_to_json
        Thread.current.thread_variable_set("JSON_SAVED_ON_EXIT", true)
        puts "Saved data and exiting. Goodbye \\o/"
      else
        puts "Data already saved, no need to save it twice."
      end
    end

    def get_lowest_quantity
        Item.all.sort do |a,b|
            a.quantity <=> b.quantity
        end
    end

    def find_object(object_id)
        ObjectSpace._id2ref(Integer(object_id))
    end

    def sort_by_name(array)
        array.sort do |a,b|
            a.name <=> b.name
        end
    end

    #--------Ordering methods------------#

    def place_current_order
        current_order.each do |hash|
            hash.each do |id,amount|
                item = find_object(id)
                order_item(item)
            end
        end
    end

    def get_soon_to_be_received

        ordered = Item.all.select do |item|
            begin                                            #number in days
                (Time.now.to_date - item.last_ordered.to_date).to_i > 7
            rescue => exception
                #So it doesn't crash when it finds an item without a last_ordered value
            end
        end

        rtn = ordered.collect do |item|
            if item.last_received == nil
                item                                               #number in days
            elsif (Time.now.to_date - item.last_received.to_date).to_i > 49
                item
            end
        end
        rtn.reject {|i| i == nil}
    end

    def add_to_current_order(item, quantity)
        @current_order << {"#{item.object_id}"=> quantity}
    end

    def order_item(item)
        item.last_ordered = Time.now
    end

    def received_item(item, quantity)
        item.last_received = Time.now
        item.quantity += quantity
    end
    
    #--------Creating methods------------#
    def create_item(attr)
        item = Item.create_from_hash(attr)
    end

    def create_sub_category(attr)
        sub_categ = Sub_Category.create_from_hash(attr)
    end

    def create_category(attr)
        categ = Category.create_from_hash(attr)
    end

    def create_department(attr)
        dept = Department.create_from_hash(attr)
    end
    #--------Deleting methods------------#

    def delete_object(object)
        case object
        when Department
            delete_items_from_parent(object)
            delete_sub_categories_from_parent(object)
            delete_categories_from_parent(object)
            Department.all.each.with_index do |dept,i|
                if dept == object
                    Department.all.delete_at(i)
                end
            end
        when Category
            delete_items_from_parent(object)
            delete_sub_categories_from_parent(object)
            delete_categories_from_parent(object)

        when Sub_Category
            delete_items_from_parent(object)
            delete_sub_categories_from_parent(object)
        when Item
            delete_items_from_parent(object)
        end

    end

    def delete_items_from_parent(object)

        case object
        when Department
            while Item.all.detect {|i| i.department == object} != nil
                Item.all.each.with_index do |item,i|
                    if item.department == object
                        remove_object_ref(item)
                        Item.all[i] = nil
                        Item.all.delete_at(i)
                    end
                end
            end

        when Category
            while Item.all.detect {|i| i.category == object} != nil
                Item.all.each.with_index do |item,i|
                    if item.category == object
                        item.category.items
                        remove_object_ref(item)
                        Item.all[i] = nil
                        Item.all.delete_at(i)
                    end
                end
            end

        when Sub_Category
            while Item.all.detect {|i| i.sub_category == object} != nil
                Item.all.each.with_index do |item,i|
                    if item.sub_category == object
                        remove_object_ref(item)
                        Item.all[i] = nil
                        Item.all.delete_at(i)
                    end
                end
            end

        when Item
            while Item.all.detect {|i| i == object} != nil
                Item.all.each.with_index do |item,i|
                    if item == object
                        remove_object_ref(item)
                        Item.all[i] = nil
                        Item.all.delete_at(i)
                    end
                end
            end
        end
    end#endof method

    def delete_sub_categories_from_parent(object)
        case object
        when Sub_Category
            while Sub_Category.all.detect {|i| i == object} != nil
                Sub_Category.all.each.with_index do |sub_categ,i|
                    if sub_categ == object
                        remove_object_ref(sub_categ)
                        Sub_Category.all[i] = nil
                        Sub_Category.all.delete_at(i)
                    end
                end
            end
        when Category
            while Sub_Category.all.detect {|i| i.category == object} != nil
                Sub_Category.all.each.with_index do |sub_categ,i|
                    if sub_categ.category == object
                        remove_object_ref(sub_categ)
                        Sub_Category.all[i] = nil
                        Sub_Category.all.delete_at(i)
                    end
                end
            end

        when Department
            while Sub_Category.all.detect {|i| i.category.department == object} != nil
                Sub_Category.all.each.with_index do |sub_categ,i|
                    if sub_categ.category.department == object
                        remove_object_ref(sub_categ)
                        Sub_Category.all[i] = nil
                        Sub_Category.all.delete_at(i)
                    end
                end
            end

        end
    end

    def delete_categories_from_parent(object)
        case object
        when Category
            while Category.all.detect {|i| i == object} != nil
                Category.all.each.with_index do |categ,i|
                    if categ == object
                        remove_object_ref(categ)
                        Category.all[i] = nil
                        Category.all.delete_at(i)
                    end
                end
            end
        when Department
            while Category.all.detect {|i| i.department == object} != nil
                Category.all.each.with_index do |categ,i|
                    if categ.department == object
                        remove_object_ref(categ)
                        Category.all[i] = nil
                        Category.all.delete_at(i)
                    end
                end
            end

        end
    end

    def remove_object_ref(object)
        #Won't fully delete if object has references to other instances.
        case object
        when Category
            object.department.categories.each.with_index do |item, i|
                if item == object
                    object.department.categories.delete_at(i)
                end
            end
        when Sub_Category
            object.category.sub_categories.each.with_index do |sub_categ, i|
                if sub_categ == object
                    object.category.sub_categories.delete_at(i)
                end
            end
            
        when Item
            if object.sub_category != nil
                object.sub_category.items.each.with_index do |item, i|
                    if item == object
                        object.sub_category.items.delete_at(i)
                    end
                end
            else
                object.category.items.each.with_index do |item, i|
                    if item == object
                        object.category.items.delete_at(i)
                    end
                end
            end
        end

    end

    def pry
        binding.pry
    end
    
end
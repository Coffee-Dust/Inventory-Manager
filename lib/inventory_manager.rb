class Inventory_Manager

    def initialize
        puts "Starting Inventory Manager..."
        @dbc = Database_Controller.new(self)
        @current_order = []
    end

    #I.D. items that are soon to be received(date farthest away thats has a received date that is before the order date)

    def place_current_order
        current_order.each do |id, amount|
            item = find_object(id)
            order_item(item)
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

    def pry
        binding.pry
    end
    
end
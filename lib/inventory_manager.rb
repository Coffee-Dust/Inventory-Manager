class Inventory_Manager

    def initialize
        puts "Starting Inventory Manager..."
        @dbc = Database_Controller.new(self)
    end

    #I.D. items that are soon to be received(date farthest away thats has a received date that is before the order date)

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
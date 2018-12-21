class Inventory_Manager

    def initialize
        puts "Starting Inventory Manager..."
        @dbc = Database_Controller.new(self)
    end

    def get_lowest_quantity
        Item.all.sort do |a,b|
            a.quantity <=> b.quantity
        end
    end

    def pry
        binding.pry
    end
    
end
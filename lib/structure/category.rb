class Category

    extend Storable::Class
    include Storable::Instance

    attr_accessor :name, :department
    
    def initialize
        @sub_categories = []
        @items = []
    end

    def self.create_from_hash(hash)
        self.new.tap do |instance|
            hash.each do |key, value|
                begin
                   instance.send("#{key}=", value) 
                rescue
                    puts "Could not find method#{key}= for #{self}"
                end
            end
            instance.save
        end
    end

    def department=(department)
        @department = department
        department.categories << self
    end

    def sub_categories
        @sub_categories == [] ? nil : @sub_categories
    end

    def items
        @items == [] ? nil : @items
    end

    def add_sub_categories(sub_cat)
        @sub_categories << sub_cat
    end

    def add_items(item)
        @items << item
    end

end
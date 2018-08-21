class Sub_Category

    extend Storable::Class
    include Storable::Instance
    
    attr_accessor :name, :items
    attr_reader :category
    def initialize
        @items  = []
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

    def category=(cat)
        @category = cat
        cat.add_sub_categories(self)
    end

    def add_items(item)
        @items << item
    end

    # def save
    #     @@all << self
    # end

    # def self.all
    #     @@all
    # end
end
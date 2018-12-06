class Sub_Category

    extend Storable::Class
    include Storable::Instance
    extend Findable

    attr_accessor :name, :items
    attr_reader :category
    def initialize
        @items  = []
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
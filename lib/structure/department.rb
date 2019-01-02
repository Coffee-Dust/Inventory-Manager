class Department

    extend Storable::Class
    include Storable::Instance
    extend Findable

    attr_accessor :name, :categories
    def initialize
        self.categories = []
    end

    def find_category(categ)
        self.categories.detect do |cat|
            categ == cat
        end
    end
    
end
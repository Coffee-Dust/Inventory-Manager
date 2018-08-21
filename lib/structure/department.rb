class Department

    extend Storable::Class
    include Storable::Instance
    extend Findable

    attr_accessor :name, :categories
    def initialize
        self.categories = []
    end
    
end
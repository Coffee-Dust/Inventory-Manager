class Department
    @@all = []
    attr_accessor :name, :categories
    def initialize
        self.categories = []
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

    def save
        @@all << self
    end

    def self.all
        @@all
    end
end
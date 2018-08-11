class Category
    @@all = []
    attr_accessor :name, :department, :sub_categories, :items
    def initialize
        
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

end
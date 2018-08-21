module Findable

    def self.create_from_hash(hash)
        self.new.tap do |instance|
            hash.each do |key, value|
                begin
                    instance.send("#{key}=", value) 
                rescue
                    puts "Could not find method#{key}= or #{self}"
                end
            end
            instance.save
        end
    end

    def self.find_by_SKU(sku)

    end

    def self.find_by_name(name)

    end

    def self.find_by_brand(brand)

    end

end#endof module
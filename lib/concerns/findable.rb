module Findable

    def create_from_hash(hash)
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

    def find_by_SKU(sku)
        if self.is_a? Item.class
            self.all.detect { |i| i.sku == sku }
        else
            return "ERROR: The method must be called on Items only."
        end
    end

    def find_by_name(name)
        self.all.detect { |i| i.name == name }
    end

    def find_by_brand(brand)
        self.all.detect { |i| i.brand_name == brand }
    end

end#endof module
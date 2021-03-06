module Findable

    def new_from_hash(hash)
        self.new.tap do |instance|
            hash.each do |key, value|
                begin
                    instance.send("#{key}=", value) 
                rescue
                    puts "Could not find method #{key}= for #{self}."
                end
            end
        end
    end

    def create_from_hash(hash)
        instance = self.new_from_hash(hash)
        instance.save
        instance
    end

    def find_by_name(name)
        self.all.detect { |i| i.name == name }
    end

    def find_by_SKU(sku)
        self.all.detect {|i| i.sku == sku }
    end

    def find_by_weight(weight)
        self.all.detect {|i| i.weight == weight}
    end

end#endof module
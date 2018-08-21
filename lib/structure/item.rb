class Item
    
    extend Storable::Class
    include Storable::Instance

    attr_accessor :name, :brand_name, :desc, :weight, :quantity, :sku, :last_received
    attr_reader :sub_category

    def initialize
        #TODO: Initialize with a new SKU using SKU.new(self)
    end

    def self.create_from_hash(hash)
        self.new.tap do |instance|
            hash.each do |key, value|
                begin
                   instance.send("#{key}=", value) 
                rescue
                    puts "Could not find method #{key}= for #{self}"
                end
            end
            instance.save
        end
    end

    def sub_category=(sub_cat)
        @sub_category = sub_cat
        sub_cat.add_items(self)
    end

    def category=(cat)
        @category = cat
        cat.add_items(self)
    end

    def department
        if @sub_category == nil
            @category.department
        else
            @sub_category.category.department
        end
    end

    def category
        if @category == nil
            @sub_category.category
        else
            @category
        end
    end

end#endof class
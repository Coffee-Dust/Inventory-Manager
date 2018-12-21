class Item

    extend Storable::Class
    include Storable::Instance
    extend Findable

    attr_accessor :name, :brand_name, :desc, :weight, :quantity, :sku, :last_ordered, :last_received
    attr_reader :sub_category

    def initialize
        #TODO: Initialize with a new SKU using SKU.new(self)
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

    def self.find_by_SKU(sku)
        self.all.detect { |i| i.sku == sku }
    end

    def self.find_by_brand(brand)
        self.all.detect { |i| i.brand_name == brand }
    end

end#endof class
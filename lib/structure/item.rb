class Item
    attr_accessor :name, :brand_name, :desc, :weight, :quantity, :sku, :sub_category
    attr_writer :category
    def initialize
        #TODO: Initialize with a new SKU using SKU.new(self)
    end

    def department
        if @sub_category == nil
            @category.department
        else
            @sub_category.category.department
        end
    end

    def category
        @sub_category.category if @category == nil
    end

end#endof class
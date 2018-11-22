class SKU
    @@last_item = []
    def initialize(item)
        @item = item
        @value = []
    end

    def generate_SKU
         #get the lastest/highest SKU number by searching for it.
         @value << @item.department.name.chr
         @value << @item.category.name.chr

    end

    def generate_uniq_number

    end

    def value
        @value
    end
end
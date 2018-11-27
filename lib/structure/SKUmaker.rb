class SKU
    @@last_item = []
    def initialize(item)
        @item = item

        self.generate_SKU
        @@last_item.clear
        @@last_item << @item
    end

    def generate_SKU
        @value = []
        @value << @item.department.name.chr
        @value << @item.category.name.chr
        @value << self.generate_uniq_number
        
        @value = @value.join

    end

    def generate_uniq_number
        if @@last_item.empty? || @@last_item[0].sku[0,2] != @value.join
            amount = 0
        else
            amount = @@last_item[0].sku.scan(/[^0A-Za-z]/).join.to_i 
        end
        amount += 1
        amount  = amount.to_s.split("")
        (8 - amount.length).times do
            amount.unshift("0")
        end

        amount.join
    end

    def value
        @value
    end
end
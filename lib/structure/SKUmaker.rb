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
        begin
           amount = @@last_item.sku.scan(/[^0A-Za-z]/).join.to_i 
        rescue => exception
             amount = 0
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
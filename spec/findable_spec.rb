require_relative "./spec_helper.rb"

describe "Findable Methods" do
    
    it "Can find by name" do
        i = Item.all[0]
        expect(Item.find_by_name("El Sembrador Corn Cakes")).to_eq i
    end

    it "Can find items by sku" do
        i = Item.all[3]
        expect(Item.find_by_sku("DB00000004")).to_eq i
    end

    it "Can find by lowest quantity" do
        sorted = Item.all.sort {|a,b| a.quantity <=> b.quantity}
        sorted.each {|i| puts "#{i.name} has: #{i.quantity}"}
        expect(Item.find_lowest_quantity).to_eq sorted[0]
    end

end


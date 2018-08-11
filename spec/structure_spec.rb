require "spec_helper"

grocery = Department.create_from_hash({name: "Grocery"})

frozen = Category.create_from_hash({name: "Frozen Foods", department: grocery})

pizzas = Sub_Category.create_from_hash({name: "Frozen Pizza's", category: frozen})

gf_pizza = Item.create_from_hash({department: grocery, category: frozen, sub_category: pizzas, brand_name: "Udi's", name: "Udi's gluten free pepperioni pizza", weight: "5oz", quantity: 120})

describe "Department" do
    it "has @@all and stores it self" do
        expect(Department.all).to include(grocery)
    end

    it "has many categories" do
        expect(grocery.categories[0]).to eq frozen
    end

    it "has many Sub_Categorys/items through categories" do
        expect(grocery.categories[0].sub_categories).to_not be nil
    end

end

describe "Category" do
    it "has @@all and stores it self" do
        expect(Category.all).to include(frozen)
    end

    it "belongs to a Department" do
        expect(frozen.department).to eq grocery
    end

    it "has many SubCategorys/items" do
        expect(frozen.sub_categories).to include(pizzas)
    end

    it "has many Items if no SubCategorys are present" do
        expect(frozen.items).to include(gf_pizza) if frozen.sub_categories == nil
    end
end

describe "Sub_Category" do
    it "has @@all and stores it self" do
        expect(Sub_Category.all).to include(pizzas)
    end

    it "Belongs to a Category" do
        expect(pizzas.category).to eq frozen
    end

    it "Has many Items" do
        expect(pizzas.items).to include(gf_pizza)
    end
end

describe "Item" do
    it "has @@all and stores it self" do
        expect(Item.all).to include(gf_pizza)
    end

    it "belongs to a Sub_Category" do
        expect(gf_pizza.sub_category).to eq pizzas
    end

    it "belongs to a Category if no Sub_Category" do
        expect(gf_pizza.category).to eq frozen if Sub_Category == nil
    end

    it "Belongs to a Department through Category/Sub_Category" do
        expect(gf_pizza.department).to eq grocery
    end

    #TODO: Tests below

    it "Has last_received date stored if entered manually" do

    end

    it "Has a unique SKU created from SKUMaker Class" do
        expect(Items.find_by_SKU(gf_pizza.sku)).to eq gf_pizza
    end
end
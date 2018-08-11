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
        expect(grocery.categories[0]).to_equal frozen
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
        expect(frozen.department).to_equal grocery
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
        expect(pizzas.category).to_equal frozen
    end

    it "Has many Items" do
        expect(pizzas.items).to include(gf_pizza)
    end
end
require "spec_helper"

grocery = Department.create_from_hash({name: "Grocery"})

frozen = Category.create_from_hash({name: "Frozen Foods", department: grocery})

pizzas = SubCategory.create_from_hash({name: "Frozen Pizza's", category: frozen})

gf_pizza = Item.create_from_hash({department: grocery, category: frozen, sub_category: pizzas, brand_name: "Udi's", name: "Udi's gluten free pepperioni pizza", weight: "5oz"})

describe "Department" do
    it "has @@all and stores it self" do
        expect(Department.all).to include(grocery)
    end

    it "has many categories" do
        expect(grocery.categories[0]).to_equal frozen
    end

    it "SubCategorys/items through categories" do
        expect(grocery.categories[0].sub_categories).to_not be nil
    end

end
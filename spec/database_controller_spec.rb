require_relative "./spec_helper.rb"

describe "Database_Controller" do

    # s = Scraper.new
    # s.create_database

    s = [{"department5"=>
    {:name=>"Bakery",
     :categories=>
      [{:name=>"Tarts",
        :sub_categories=>nil,
        :items=>
         [{:title=>
            "Oblong Berry European Cream Tart",
           :weight=>""},
          {:title=>
            "Oblong Chocolate Ganache Tart with Fresh Strawberries",
           :weight=>""},
          {:title=>
            "Round European Cream Pineapple BerryTart",
           :weight=>""},
          {:title=>
            "Round European Cream Triple Berry Tart",
           :weight=>""},
          {:title=>
            "Round Vanilla Cream Fruit Tart",
           :weight=>""},
          {:title=>
            "Specialty Mini Fruit Tarts 6ct",
           :weight=>"8 oz Pkg"}]},

        {:name=>"Breads",
        :sub_categories=>
         [{:name=>
            "Fresh Baked Breads and Pizza Dough",
           :items=>
            [{:title=>"French Bread",
              :weight=>"12 oz Pkg"},
             {:title=>"French Bread",
              :weight=>"12 oz Pkg"},
             {:title=>"White Mountain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Italian Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Baguette",
              :weight=>"8 oz Pkg"},
             {:title=>"Italian Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Italian Five Grain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Chicago Italian Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"White Mountain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Sour Dough Round Bread",
              :weight=>"16 oz Pkg"},
             {:title=>
               "Italian Five Grain Baguette",
              :weight=>"8 oz Pkg"},
             {:title=>"Italian Pizza Dough",
              :weight=>"16 oz Pkg"},
             {:title=>"Egg Bread (Challah)",
              :weight=>"16 oz Pkg"},
             {:title=>"Rye Bread",
              :weight=>"16 oz Pkg"},
             {:title=>
               "100% Whole Wheat Mountain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>
               "Egg Bread (Challah) with Raisins",
              :weight=>"16 oz Pkg"},
             {:title=>"Multigrain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>
               "100% Whole Wheat Five Grain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Multi Grain Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Sourdough Round Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Homestyle White Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Breakfast Bread",
              :weight=>"20 oz Pkg"},
             {:title=>"100% Whole Wheat Bread",
              :weight=>"16 oz Pkg"},
             {:title=>"Rye Bread",
              :weight=>"16 oz Pkg"}]},
          {:name=>"Hispanic Breads",
           :items=>
            [{:title=>"Cuban Bread Authentic",
              :weight=>"10 oz Pkg"},
             {:title=>"Authentic Cuban Bread Hot",
              :weight=>"10 oz Pkg"},
             {:title=>"Cuban Bread with Soy",
              :weight=>"10 oz Pkg"},
             {:title=>"Cuban Toast",
              :weight=>"3 oz Pkg"},
             {:title=>"Pan De Queso",
              :weight=>"16 oz Pkg"},
             {:title=>"Puerto Rican Bread",
              :weight=>"12 oz Pkg"},
             {:title=>"Cornbread Pan De Maiz",
              :weight=>"16 oz Pkg"},
             {:title=>"Cornbread Slices 8 Count",
              :weight=>"14 oz Pkg"},
             {:title=>"Cuban Toast with Cream",
              :weight=>"5 oz Pkg"},
             {:title=>"Cuban Bread Traditional",
              :weight=>"12 oz Pkg"}]},
          {:name=>"Specialty",
           :items=>
            [{:title=>
               "Laromme Rolls, Egg Challah, Premium",
              :weight=>"13 oz (368 g)"},
             {:title=>"Homestyle Cornbread",
              :weight=>"15 oz Pkg"},
             {:title=>
               "GreenWise Seeded Whole Wheat Bread",
              :weight=>"24 oz Pkg"},
             {:title=>
               "GreenWise Honey Whole Wheat Bread",
              :weight=>"24 oz Pkg"},
             {:title=>"Alma Panettone",
              :weight=>"17.64 oz Pkg"},
             {:title=>
               "GreenWise Cinnamon Raisin Whole Wheat Bread",
              :weight=>"24 oz Pkg"},
             {:title=>
               "12 Grain & Seed with Omega 3",
              :weight=>"24 oz Pkg"},
             {:title=>"Bread Chips Parmesan",
              :weight=>"7 oz Pkg"},
             {:title=>"Ciabatta Loaf",
              :weight=>"16 oz Pkg"},
             {:title=>
               "Cranberry Walnut Artisan Loaf",
              :weight=>"16 oz Pkg"},
             {:title=>"Crusty Five-Grain Baton",
              :weight=>"8 oz Pkg"},
             {:title=>"Demi Loaf Sourdough",
              :weight=>"8 oz Pkg"},
             {:title=>"Garlic Texas Toast",
              :weight=>"11 oz Pkg"},
             {:title=>
               "GreenWise Crusty Wheat Baguette",
              :weight=>"8.50 oz Pkg"},
             {:title=>
               "GreenWise Crusty White Baguette",
              :weight=>"8.50 oz Pkg"},
             {:title=>
               "GreenWise Sprouted Multi-Grain Bread",
              :weight=>"24 oz Pkg"},
             {:title=>"Tuscan Boule Loaf",
              :weight=>"18 oz Pkg"},
             {:title=>"Tuscan Roasted Garlic Loaf",
              :weight=>"16 oz Pkg"}]}],
        :items=>nil},

       {:name=>"Decorated Cookies",
        :sub_categories=>nil,
        :items=>
         [{:title=>
            "Chocolate Chip Message Cookie",
           :weight=>"16 oz Size"},
          {:title=>
            "1/4 Sheet Chocolate Chip Cookie",
           :weight=>"28 oz Size"},
          {:title=>
            "12\" Decorated Chocolate Chip Cookie",
           :weight=>"36 oz Pkg"},
          {:title=>
            "14\" Decorated Chocolate Chip Cookie",
           :weight=>"52 oz Pkg"},
          {:title=>
            "16\" Decorated Chocolate Chip Cookie",
           :weight=>"64 oz Pkg"},
          {:title=>
            "18\" Decorated Chocolate Chip Cookie",
           :weight=>"80 oz Pkg"},
          {:title=>"Decorated Cookie Cake",
           :weight=>""},
          {:title=>
            "Heart Shaped Chocolate Chip Cookie",
           :weight=>"20 oz Pkg"}]}]}},

           {"department6"=>
           {:name=>"Grocery",
            :categories=>
             [{:name=>"Chips",
              :items=>nil,
               :sub_categories=>[
                 {:name=>"Tortilla Chips",
                  :items=>[
                      {:title=>
                        "Ships Chips",
                       :weight=>"16 oz Size"},
                      {:title=>
                        "Doritos",
                       :weight=>"28 oz Size"},
                      {:title=>
                        "Cool ranch doritos",
                       :weight=>"36 oz Pkg"},
                      {:title=>
                        "MLG Doritos",
                       :weight=>"52 oz Pkg"},
                      {:title=>
                        "Sun chips",
                       :weight=>"64 oz Pkg"}
                  ]
                 }
               ]
              },
              {:name=>"Decorated Cookies",
               :sub_categories=>nil,
               :items=>
                [{:title=>
                   "Chocolate Chip Message Cookie",
                  :weight=>"16 oz Size"},
                 {:title=>
                   "1/4 Sheet Chocolate Chip Cookie",
                  :weight=>"28 oz Size"},
                 {:title=>
                   "12\" Decorated Chocolate Chip Cookie",
                  :weight=>"36 oz Pkg"},
                 {:title=>
                   "14\" Decorated Chocolate Chip Cookie",
                  :weight=>"52 oz Pkg"},
                 {:title=>
                   "16\" Decorated Chocolate Chip Cookie",
                  :weight=>"64 oz Pkg"},
                 {:title=>
                   "18\" Decorated Chocolate Chip Cookie",
                  :weight=>"80 oz Pkg"},
                 {:title=>"Decorated Cookie Cake",
                  :weight=>""},
                 {:title=>
                   "Heart Shaped Chocolate Chip Cookie",
                  :weight=>"20 oz Pkg"}]}]}}
          
          
          ]




    dbc = Database_Controller.new

    it "parses and instantiates objects from Scraper.class" do
        dbc.create_data_from_scraper_hash(s)

        bakery = Department.find_by_name("Bakery")

        puts bakery.categories.select{|category| category.name = "Tarts"}

        expect(bakery.categories.select{|category| category.name = "Tarts"}).to_not be nil

        expect(Item.find_by_name("Chocolate Chip Message Cookie").department).to eq Department.find_by_name("Bakery")
    end

    it "if loading from scraper, it adds a random quantity, and SKU" do
        expect(Item.find_by_name("Specialty Mini Fruit Tarts 6ct").quantity).to be Numeric

        expect(Item.find_by_name("Chocolate Chip Message Cookie").SKU).to_not be nil
    end

    it "can save current loaded database to .json file" do

    end

    it "can load from .json files" do

    end
end
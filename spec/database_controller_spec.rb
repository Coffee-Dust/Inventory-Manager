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
           :weight=>"20 oz Pkg"}]}]}}]




    dbc = Database_Controller.new

    it "parses and instantiates objects from Scraper.class" do
        dbc.create_data_from_scraper_hash(s)

        bakery = Department.find_by_name("Bakery")

        puts bakery.categories.select{|category| category.name = "Tarts"}

        expect(bakery.categories.select{|category| category.name = "Tarts"}).to_not be nil

        expect(Item.find_by_name("Chocolate Chip Message Cookie").department).to eq Department.find_by_name("Bakery")
    end

    it "if loading from scraper, it adds a random quantity, and SKU" do
        expect(Item.find_by_name("Specialty Mini Fruit Tarts 6ct").quantity).to be Integer

        expect(Item.find_by_name("Chocolate Chip Message Cookie").SKU).to_not be nil
    end

    it "can save current loaded database to .json file" do

    end

    it "can load from .json files" do

    end
end
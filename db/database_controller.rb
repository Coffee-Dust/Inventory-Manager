class Database_Controller
    def initialize
        
    end

    def create_data_from_scraper_hash(hash)
        hash.each do |departments|

            departments.each do |key, department|
                dept = Department.new
                dept.name = department[:name]
                
                department[:categories].each do |category|
                    categ = Category.new
                    categ.name = category[:name]
                    categ.department = dept

                    if category[:items] == nil

                        category[:sub_categories].each do |sub_category|
                            sub_cat = Sub_Category.new
                            sub_cat.name = sub_category[:name]
                            sub_cat.category = categ

                            begin
                                sub_category[:items].each do |item|
                                    ite = Item.new
                                    ite.name = item[:title]
                                    ite.weight = item[:weight]
                                    ite.sub_category = sub_cat
                                    ite.quantity = Random.new.rand(2000)
                                    ite.sku = SKU.new(ite).value

                                    ite.save

                                end
                            rescue
                                puts "Found a sub-sub category, we don't need this!"
                            end

                            sub_cat.save
                        end
                    else
                        #make the code fer getting items here...
                        category[:items].each do |item|
                            ite = Item.new
                            ite.name = item[:title]
                            ite.weight = item[:weight]
                            ite.category = categ
                            ite.quantity = Random.new.rand(2000)
                            ite.sku = SKU.new(ite).value
                            
                            ite.save
                        end
                    end
                    categ.save
                end
                dept.save
            end
        end#first loop
    end

    def load_data_from_json
        file = File.read("db/saves/save.json")
        data_hash = JSON.parse(file)

        data_hash["department"].each do |department|
            dept = Department.new
            dept.name = department["name"]

            department["categories"].each do |category|
                categ = Category.new
                categ.name = category["name"]
                categ.department = dept

                if category["items"] == nil

                    category["sub_categories"].each do |sub_category|
                        sub_cat = Sub_Category.new
                        sub_cat.name = sub_category["name"]
                        sub_cat.category = categ

                        sub_category["items"].each do |item|
                            ite = Item.new
                            ite.name = item["title"]
                            item.keys.each do |key|
                                ite.send("#{key}=", item[key])
                            end

                            ite.save

                        end
                        sub_cat.save
                    end
                else
                    #make the code fer getting items here...
                    category["items"].each do |item|
                        ite = Item.new
                        ite.name = item["title"]
                        item.keys.each do |key|
                            ite.send("#{key}=", item[key])
                        end

                        ite.save
                    end
                end
                categ.save
            end
            dept.save
        end
        
    end

    def save_data_to_json
        hash = generate_hash_from_object_data

        File.write("db/saves/save.json",hash.to_json)


    end

    def generate_hash_from_object_data
        hash_holder = {}
        hash_holder["department"] = []
        Department.all.each do |department|
            hash = {}
            hash["name"] = department.name
            hash["categories"] = []
            department.categories.each do |category|
                categ_hash = {}
                categ_hash["name"] = category.name
                if category.sub_categories == nil
                    #has items not sub_categ
                    categ_hash["sub_categories"] = nil
                    categ_hash["items"] = []

                    begin
                       category.items.each do |item|
                           generate_hash_for_item(item, categ_hash) 
                       end 
                    rescue => exception
                        puts "There was an error, bypassing."
                    end
                else
                    categ_hash["items"] = nil
                    categ_hash["sub_categories"] = []
                    category.sub_categories.each do |sub_category|
                        sub_cat = {}
                        sub_cat["name"] = sub_category.name
                        sub_cat["items"] = []
                        sub_category.items.each do |item|
                            generate_hash_for_item(item, sub_cat)
                        end
                        categ_hash["sub_categories"] << sub_cat
                    end
                end
                hash["categories"] << categ_hash
            end
            hash_holder["department"] << hash
        end
        hash_holder
    end

    def generate_hash_for_item(item, parent)
        item_hash = {}

        item_hash["name"] = item.name
        item_hash["brand_name"] = item.brand_name
        item_hash["desc"] = item.desc
        item_hash["weight"] = item.weight
        item_hash["quantity"] = item.quantity
        item_hash["sku"] = item.sku
        item_hash["last_received"] = item.last_received
        parent["items"] << item_hash
    end

end#endof class
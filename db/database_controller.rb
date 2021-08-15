class Database_Controller
    def initialize(base)
      @save_file_location = "#{__dir__}/saves/save.json"
        if File.zero?(@save_file_location)
            puts "Save file is empty. Please add inventory by using the \'add to database\' command."
        else
            self.load_data_from_json
            puts "Successfully loaded database from save."
        end

        base.send("at_exit") do
            puts "Saving all data to database save file."
            #BUGFIX: To prevent saving twice in the case of on-exit being called twice.
            if Thread.current.thread_variable_get("JSON_SAVED_ON_EXIT") == nil && ENV["APP_ENV"] == "DEFAULT"
                self.save_data_to_json
                Thread.current.thread_variable_set("JSON_SAVED_ON_EXIT", true)
                puts "Saved data and exiting. Goodbye \\o/"
            else
                puts "Data already saved, no need to save it twice."
            end
        end


    end

    

    def clear_all_loaded_data
        puts "Are you sure you want to delete the local data? You will not be able to recover or save the data afterwards. y/n"
        input = gets.strip
        if input == "y" || input == "yes"
            Item.all.clear
            Sub_Category.all.clear
            Category.all.clear
            Department.all.clear
            puts "Deleted."
        end
    end

    def delete_json_data
        puts "Are you sure you want to delete the ENTIRE database save? y/n"
        input = gets.strip
        if input == "y" || input == "yes"
            File.truncate(@save_file_location, 0)
            puts "Save file deleted!"
        end
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
        file = File.read(@save_file_location)
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
                            ite.name = item["name"]
                            ite.sub_category = sub_cat
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
                        ite.name = item["name"]
                        ite.category = categ
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

        File.truncate(@save_file_location, 0)

        File.write(@save_file_location, hash.to_json)


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
                        # puts exception
                        # puts "There was an error un-parsing in #{department.name} #{category.name}, bypassing."
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
        item_hash["last_ordered"] = item.last_ordered
        item_hash["last_received"] = item.last_received
        parent["items"] << item_hash
    end

end#endof class
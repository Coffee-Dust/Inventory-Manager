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

                            sub_category[:items].each do |item|
                                ite = Item.new
                                ite.name = item[:name]
                                ite.weight = item[:weight]
                                ite.sub_category = sub_cat
                                ite.quantity = Random.new.rand(2000)
                                ite.SKU = SKU.new(self)

                                dept.save
                                categ.save
                                sub_cat.save
                                ite.save

                            end
                        end
                    else
                        #make the code for getting items here...
                        category[:items].each do |item|
                            ite = Item.new
                            ite.name = item[:title]
                            ite.weight = item[:weight]
                            ite.category = categ
                            ite.quantity = Random.new.rand(2000)
                            ite.sku = SKU.new(self).value

                            dept.save
                            categ.save
                            ite.save
                        end
                    end
                end
            end
        end#first loop
    end

    def load_data_from_json

    end

    def save_data_to_json
        
    end


end#endof class
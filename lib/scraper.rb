class Scraper
    #TODO: Expected behaivor: Department.create_from_hash(scraper.departments[i])
    attr_accessor :database
    def initialize
        @database = []
    end

    def create_database
        department_links = []
        html = open("http://www.publix.com/all-products/")
        publix = Nokogiri::HTML(html)

        publix.css(".category-pod").each { |pod|
            department_links << pod.css("a").attribute("href").value.strip
        }

        department_links.each.with_index do |department, i|
            if i > 4
                @database << {"department#{i}" => create_data_entry_for(department)}
            end
        end
    end

    def create_data_entry_for(link)
        #it will get everything for the one entry or department and wrap it on top of the the database hash
        #Named this way just for the fun of saying it <3
        hash_holder = {}
        site = Nokogiri::HTML(open("http://www.publix.com#{link}"))

        hash_holder[:name] = site.css(".category-title-text").text.strip

        hash_holder[:categories] = []

        site.css(".category-pod").each { |pod|
            category_hash = {}
            name = pod.css(".category-title h3").text.strip
            items_link = pod.css("a").attribute("href").value.strip

            category_hash[:name] = name
            category_hash[:sub_categories] = get_sub_categories_for_category(items_link)
            category_hash[:items] = get_items_for_link(items_link)

            hash_holder[:categories] << category_hash
        }

    end

    def get_sub_categories_for_category(link)
        #go into the next link, and check if it has #NutritionalFacts in it, if it doesnt its a sub_category...

    end

    def get_items_for_link(link)

    end


    def pry
        binding.pry
    end
end

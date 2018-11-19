class Scraper
    #TODO: Expected behaivor: Department.create_from_hash(scraper.departments[i])
    attr_accessor :database
    def initialize
        @database = []
    end

    def create_database
        start_load_timer(true)

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

        start_load_timer(false)
        @database
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
        hash_holder
    end

    def get_sub_categories_for_category(link)
        # This is checking if the link has publix, since link to product pages contain the full link.
        if !link.include?("publix.com")

            #it does not contain a full link, so its a categories page
            site = Nokogiri::HTML(open("http://www.publix.com#{link}"))
            sub_categories = []

            site.css(".category-pod").each { |pod|
                sub_category_hash = {}
                item_link = pod.css("a").attribute("href").value.strip

                sub_category_hash[:name] = pod.css(".category-title h3").text.strip
                sub_category_hash[:items] = get_items_for_link(item_link)

                sub_categories << sub_category_hash
            }

            return sub_categories

        else
            return nil
        end
    end

    def get_items_for_link(link)

        if link.include?("publix.com")
            puts "#get_item_for_link received this link: #{link}"
            site = Nokogiri::HTML(open("#{link}"))
            items = []

            site.css(".product").each { |product| 
                item_hash = {}

                item_hash[:title] = product.css(".fda-title").text.strip
                item_hash[:weight] = product.css(".size-description").text.strip

                # item_link = product.css("div div div div div div a").attribute("href").value.strip
                # item_site = Nokogiri::HTML(open("http://www.publix.com#{item_link}"))

                # item_hash[:desc] = item_site.css("#content_0_OverviewRepeater_OverviewText_0 p").text.strip

                items << item_hash
            }

            return items

        else
            return nil
        end
    end

    def start_load_timer(start)
        if start
            puts "Generating database..."
            Thread.current.thread_variable_set("time", Time.now)

        else
            puts "Load time was: #{Time.now - Thread.current.thread_variable_get("time")} seconds"
        end
    end

    def pry
        binding.pry
    end
end

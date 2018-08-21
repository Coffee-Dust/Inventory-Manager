module Storable
    module Instance

        def save
            self.class.all << self
        end
    end

    module Class
        def self.extended(base)
            puts "#{base} extended #{self}"
            base.class_variable_set("@@all", [])
        end

        def all
            self.class_variable_get("@@all")
        end
    end
    
end
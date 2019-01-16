lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "inventory_manager"
  spec.version       = "0.0.11"
  spec.authors       = ["Coffee Dust"]
  spec.email         = ["coffeedust.io@outlook.com"]

  spec.summary       = %q{"Keep track of your store's inventory so you don't run out. Categorize items by department, categories and sub_categories."}
  # spec.description   = %q{"TODO: Write a longer description or delete this line."}
  spec.homepage      = "https://github.com/Coffee-Dust/Inventory-Manager.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  # spec.files         = ["./Gemfile.lock", "./Gemfile", "lib/concerns/findable.rb", "lib/concerns/storable.rb", "lib/structure/department.rb", "lib/structure/category.rb", "lib/structure/sub_category.rb", "lib/structure/item.rb", "lib/structure/SKUmaker.rb", "lib/scraper.rb", "db/database_controller.rb", "lib/inventory_manager.rb", "lib/concerns/commands.rb", "lib/interface_controller.rb", "config/environments.rb", "config/environment.rb"]
  spec.executables   << "inventory_manager_start"

  spec.add_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.6"
  spec.add_development_dependency "pry", "~> 0.11"
  spec.add_dependency "colorize", "~> 0.8"
  spec.add_dependency "require_all", "~> 2.0"
  spec.add_dependency "json", "~> 1.8"
end

require_relative "./spec_helper.rb"

describe "Database_Controller" do
    it "creates and saves objects from hashes" do
        hash = {
            department: {
                name: "Grocery"                                
            }                       
        }
        Database_Controller.new(hash).load_hash
        expect(Department.find_by_name("Grocery")).to_not eq(nil)
    end

    it "creates and saves objects while assigning them with relationships" do

    end

    it "can save current loaded database to .json file" do

    end

    it "can load from .json files" do

    end
end
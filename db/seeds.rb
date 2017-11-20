# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

    prep_notes_list = [
        ["chopped"],
        ["diced"],
        ["minced"],
        ["peeled"],
        ["flayed"],
        ["slices"],
        ["whole"],
        ["halves"],
        ["grated"],
        ["shaved"]
    ]
    
    units_list = [
        ["cups"],
        ["tablespoons"],
        ["teaspoons"],
        ["ounces"],
        ["drops"],
        ["pinch"],
        ["liters"],
        ["milliliters"]]
    
    # prep_notes_list.each do |name|
    #     prep_note.create( :note => name[0])
    #     #Country.create( :name => country[0], :population => country[1] )
    # end
    
    units_list.each do |name|
        units.create( :unit => name[0])
    end


#units.create(name: 'cups')
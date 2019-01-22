require("pry")
require_relative("models/Property")

Property.delete_all()

home1 = Property.new({"value" => "255000", "no_bedrooms" => "3", "year_built" => "1893", "build" => "flat"})
home1.save()

home2 = Property.new({"value" => "170000", "no_bedrooms" => "1", "year_built" => "1964", "build" => "flat"})
home2.save()

home3 = Property.new({"value" => "215000", "no_bedrooms" => "2", "year_built" => "1909", "build" => "semi-detatched"})
home3.save()

home3.no_bedrooms = 3
home3.update()

binding.pry
nil

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
product_categories = [
	{:category => "Add-Ons", :category_type => "digital" },
	{:category => "Arts", :category_type => "physical" },
	{:category => "Books", :category_type => "physical" },
	{:category => "Comics", :category_type => "digital" },
	{:category => "Diy & Craft", :category_type => "physical" },
	{:category => "E-books", :category_type => "digital" },
	{:category => "Food", :category_type => "physical" },
	{:category => "Gadgets", :category_type => "physical" },
	{:category => "Graphics", :category_type => "digital" },
	{:category => "Home", :category_type => "physical" },
	{:category => "Kids", :category_type => "physical" },
	{:category => "Media", :category_type => "physical" },
	{:category => "Men", :category_type => "physical" },
	{:category => "Music", :category_type => "digital" },
	{:category => "Music", :category_type => "physical" },
	{:category => "Pet", :category_type => "physical" },
	{:category => "Software", :category_type => "digital" },
	{:category => "Software", :category_type => "physical" },
	{:category => "Sports & Outdoors", :category_type => "physical" },
	{:category => "Templates", :category_type => "digital" },
	{:category => "Themes", :category_type => "digital" },
	{:category => "Travel", :category_type => "physical" },
	{:category => "Vehicles", :category_type => "physical" },
	{:category => "Video", :category_type => "digital" },
	{:category => "Women", :category_type => "physical" },
	{:category => "Workspace", :category_type => "physical" },
	{:category => "Other", :category_type => "digital" },
	{:category => "Other", :category_type => "physical" }
]

product_categories.each do |attributes|
	ProductCategory.find_or_initialize_by_category_and_category_type(attributes[:category],attributes[:category_type]).tap do |p|
		#p.category_type = attributes[:category_type]
		#p.amount = Product.where(:category => attributes[:category]).count
		p.save!
	end
end
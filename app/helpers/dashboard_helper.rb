module DashboardHelper
	def conversion(unique_views, sales) 
		number_to_percentage(sales/unique_views.to_f, precision: 2)
	end
end

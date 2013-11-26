# == Schema Information
#
# Table name: traffics
#
#  id         :integer          not null, primary key
#  store_id   :integer          default(0)
#  product_id :integer          default(0)
#  ip_address :string(255)
#  owner_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  view       :integer          default(1)
#

class Traffic < ActiveRecord::Base
  attr_accessible :product_id, :store_id, :ip_address, :owner_id, :referrer
  belongs_to :product, counter_cache: :views 
  belongs_to :store, counter_cache: :views

 	def self.chart_data(id, vc)
 	  start = 3.weeks.ago
	  total_views = views_by_day(start, id, vc)
	  (start.to_date..Date.today).map do |date|
	    {
	      created_at: date,
	      view: total_views[date] || 0
	    }
	  end
	end

	def self.views_by_day(start, id, vc)
	  vs = where(created_at: start.beginning_of_day..Time.zone.now)
	  if vc == "store"
	  	vs = where('store_id = ?', id) 
	  elsif vc == "products"
	  	vs = where('store_id = ? AND owner_id = ?', 0, id) 
	  end
	  vs = vs.group("id")
	  vs = vs.select("id,created_at, sum(view) as total_views")
	  vs.each_with_object({}) do |v, views|
	    views[v.created_at.to_date] = v.total_views
	  end
	end

	def self.current_store_traffic(store_id)
		current_store_id = store_id.to_i
		product_ids = "SELECT id FROM products WHERE products.store_id = #{current_store_id}"
		Traffic.find_by_sql("SELECT traffics.referrer, traffics.ip_address
				FROM traffics
				WHERE traffics.store_id = #{current_store_id} OR traffics.product_id IN (#{product_ids})
				GROUP BY traffics.referrer, traffics.ip_address")
	end

	def count_by_referrer
		Traffic.where(referrer: self.referrer).count(group: 'ip_address')
	end

	def total_sales_by_referrer
		Order.where(referred_from: self.referrer).sum("order_total")
	end

end

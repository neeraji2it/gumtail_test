module LiquidFilters
  include ActionView::Helpers::NumberHelper
  
  def currency(price)
    number_to_currency(price)
  end
  def liquid_cover(product_id,version)
  	cover = FileHandler.where("product_id = ? and is_cover = ?", product_id, true).first
    return cover.blank? ? "http://cf2.thefancy.com/default/442515817800664429_55f4b11ef494.jpg" : cover.file_path_url(:"#{version}").to_s
  end
end
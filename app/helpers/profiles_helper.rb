module ProfilesHelper
	def subscribe_box(title, recent)
		content_tag :div, class: title.downcase do 
			raw(
				title + 
				recent.collect do |user|
					link_to profile_path(user.username) do
						image_tag(user.avatar("thumb"), style: "width: 50px; height:50px;")
					end
				end.join
				)
		end
	end
	class FoundationLinkRenderer < ::WillPaginate::ActionView::LinkRenderer
     protected
 
	     def html_container(html)
	       tag(:ul, html, container_attributes) 
	     end
	 
	     def page_number(page)
	       tag :li, link(page, page, :rel => rel_value(page)), :class => ('current' if page == current_page)
	     end
	 
	     def gap
	       tag :li, link(super, '#'), :class => 'unavailable'
	     end
	 
	     def previous_or_next_page(page, text, classname)
	       tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('unavailable' unless page)].join(' ')
	     end
	 end
	 
	   def page_navigation_links(pages)
	     will_paginate(pages, :class => 'pagination', :inner_window => 2, :outer_window => 0, :renderer => FoundationLinkRenderer, :previous_label => '&laquo;'.html_safe, :next_label => '&raquo;'.html_safe)
	   end
end
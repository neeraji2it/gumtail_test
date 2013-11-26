module ActivitiesHelper
	def is_current_user(id)
		return true if current_user.id == id
	end
end

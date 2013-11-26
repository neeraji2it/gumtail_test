module StoresHelper
	def store_user?(store)
		if signed_in?
	  		return true if store.user_id === current_user.id
	  	end
	end

	def has_store?(user)
		return true if user.store != nil
	end
end

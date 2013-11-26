class UserPresenter < SimpleDelegator
	extend ActiveSupport::Memoizable #depreciated, will create a lke memoize feature myself later
	attr_reader :user
	def initialize(user, view)
		@user = user
		super(view)
	end

	def avatar(version)
		image_tag(user.avatar(version), style: "width: 200px; height: 200px;") 
	end

	def avatar_url(version)
		user.avatar(version)
	end

	def location
		user.try(:location) || "Lives in my casa." 
	end

	def gender
		user.gender.try(:titleize) || "Not specified"
	end

	def member_since
		user.created_at.strftime("%B %d %Y")
	end

	def story
		user.try(:bio) ||  "#{user.full_name} hasn't filled their bio yet"
	end

	def subscription_count
		pluralize(user.subscriptions.size, "Subscription")
	end

	def subscribers_count
		pluralize(user.subscribers.count, "Subscriber")
	end

	def relationship_with_current_user
      if !current_user?(user)
        if current_user.subscribed?(user)
          render 'unsubscribe'
        else
          render 'subscribe'
        end
      end
    end

    def recent_subscribers
    	user.subscribers.order("created_at desc").limit(10)	
    end

    def recent_subscriptions
    	user.subscriptions.order("created_at desc").limit(10)
    end


    #use cache instead
	memoize :avatar, :subscribers_count, :subscription_count, :recent_subscriptions, :recent_subscribers
end


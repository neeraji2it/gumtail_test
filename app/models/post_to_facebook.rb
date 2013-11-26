class PostToFacebook 
  
  class<<self
    def post_to_facebook(user,message)
      me = FbGraph::User.me(user.token)
      me.feed!(
        :message => message        
      )
    end
  end
end

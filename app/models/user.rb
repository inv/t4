class User < TwitterAuth::GenericUser
  # Extend and define your user model as you see fit.
  # All of the authentication logic is handled by the 
  # parent TwitterAuth::GenericUser class.
  has_many :statuses

  def update_tweets
    @response = token.get "http://twitter.com/statuses/user_timeline.json?screen_name=#{self.login}"
    @response.body
  end

end

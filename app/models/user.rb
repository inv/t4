require 'lib/my_twitter'

class User < TwitterAuth::GenericUser
  # Extend and define your user model as you see fit.
  # All of the authentication logic is handled by the 
  # parent TwitterAuth::GenericUser class.
  has_many :statuses

  def update_tweets
    @twitter = MyTwitter.new self.token
    status_infos = @twitter.get_timeline_for self.login
    Status.from_json_array status_infos
  end

  def self.make_or_find_from_json user_info
    if user = User.find_or_create_by_twitter_id(user_info['id'].to_s)
      user.login = user_info['screen_name']
      user.assign_twitter_attributes(user_info)
    end
    user
  end

end

User.blueprint do
  login "jcfischer"
  twitter_id "123456"
  profile_image_url "http://example.com/image.png"
end

Status.blueprint do
  text "some tweet"
  user 
end
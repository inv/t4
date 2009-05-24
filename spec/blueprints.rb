Sham.status_text { Faker::Lorem.sentence[0..130] }
Sham.login { |n| "user#{n}" }

User.blueprint do
  login { Sham.login }
  twitter_id { "#{rand(9999999)}" }
  profile_image_url "http://example.com/image#{rand(9999999)}.png"
end

Status.blueprint do
  text { Sham.status_text }
  user 
end
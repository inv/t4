class MyTwitter

  attr_reader :token
  
  def initialize a_token
    @token = a_token
  end

  def response_from url
    @token.get url
  end

  def timeline_url_for loginname
    "http://twitter.com/statuses/user_timeline.json?screen_name=#{loginname}"
  end

  def parse_json_from response
    JSON.parse(response.body)  
  end

  def get_timeline_for loginname
    url = timeline_url_for loginname
    response = response_from url
    parse_json_from response
  end
end
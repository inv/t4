class Status < ActiveRecord::Base
  belongs_to :user

  def self.from_json json
    @user = User.make_or_find_from_json(json["user"])
    json.delete "user"
    @status = Status.new(json)
    @status.status_id = json["id"].to_s
    @status.user = @user
    @status.save
    @status
  end

  def self.from_json_array arr
    arr.each {|elem| Status.from_json elem }
  end
end

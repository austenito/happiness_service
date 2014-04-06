class User < ActiveRecord::Base
  has_many :surveys

  before_create :generate_api_token

  def generate_api_token
    self.api_token = Digest::SHA256.hexdigest(Time.now.to_s)
  end
end

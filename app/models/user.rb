class User < ActiveRecord::Base
  has_many :surveys
  has_many :survey_questions, through: :surveys

  before_create :generate_token
  before_create :generate_service_user_id

  def generate_token
    self.token = Digest::SHA256.hexdigest(Time.now.to_s + "nyan")
  end

  def generate_service_user_id
    self.service_user_id = Digest::SHA256.hexdigest(Time.now.to_s + "poptarts")
  end
end

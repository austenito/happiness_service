class ApiClient < ActiveRecord::Base
  def self.generate(name: name)
    token = Digest::SHA256.hexdigest(Time.now.to_s)
    ApiClient.create(name: name, token: token)
  end
end

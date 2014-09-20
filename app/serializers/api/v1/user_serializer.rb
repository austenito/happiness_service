class Api::V1::UserSerializer < ActiveModel::Serializer
  attributes :id, :service_user_id, :_links, :token
  self.root false

  def _links
    {
      self: {
        href: api_user_url(object)
      }
    }
  end
end

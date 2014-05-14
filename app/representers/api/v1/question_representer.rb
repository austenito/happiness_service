module Api::V1::QuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :type
  property :text
end

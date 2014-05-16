module Api::V1::QuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :question_type
  property :text
end

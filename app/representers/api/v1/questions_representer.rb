module Api::V1::QuestionsRepresenter
  include Representable::JSON::Collection

  items extend: Api::V1::QuestionRepresenter
end

class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_type, :text
  self.root false
end

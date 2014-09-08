class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_type, :text, :responses, :freeform
  self.root false
end

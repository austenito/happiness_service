class Api::V1::QuestionSerializer < ActiveModel::Serializer
  attributes :id, :question_type, :text, :responses, :freeform, :absolute_index, :parent_question_id, :key
  self.root false
end

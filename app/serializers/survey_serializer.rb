class SurveySerializer < ActiveModel::Serializer
  attributes :id
  has_many :survey_questions
end

class Question < ActiveRecord::Base
  belongs_to :parent_question, class_name: 'Question', foreign_key: 'parent_question_id'
  has_many :related_questions, class_name: 'Question', foreign_key: 'parent_question_id'
end

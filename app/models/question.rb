class Question < ActiveRecord::Base
  belongs_to :parent_question, class_name: 'Question', foreign_key: 'parent_question_id'
  has_many :related_questions, class_name: 'Question', foreign_key: 'parent_question_id'

  def self.create_from_params(params)
    type = params[:question_type]
    question = Question.new(question_type: type, text: params[:text],
                            responses: params[:responses], freeform: params[:freeform],
                            parent_question_id: params[:parent_question_id],
                            absolute_index: params[:absolute_index])

    question.save!
    question
  end
end

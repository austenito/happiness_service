class Question < ActiveRecord::Base
  validates :question_type, presence: true

  def boolean?
    question_type == 'boolean'
  end
end

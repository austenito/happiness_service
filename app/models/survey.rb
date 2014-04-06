class Survey < ActiveRecord::Base
  has_many :survey_questions
  belongs_to :user

  def self.generate(user)
    survey = Survey.new(user: user)
    5.times { survey.add_random_question }
    survey.save
    survey
  end

  def add_random_question
    question_count = Question.count
    offset = Random.rand(question_count)
    question = Question.offset(offset).first
    if survey_questions.include?(question)
      add_random_question
    else
      survey_questions.build(question: question)
    end
  end
end

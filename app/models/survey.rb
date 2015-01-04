class Survey < ActiveRecord::Base
  has_many :survey_questions, -> { order 'order_index ASC' }
  belongs_to :user

  accepts_nested_attributes_for :survey_questions

  def self.generate(user)
    survey = Survey.new(user: user)
    survey.add_random_questions
    survey.save
    survey.reload
  end

  def next_question
    survey_questions.where(answer: nil).first
  end

  def add_random_questions
    remaining_question_count = 5 - survey_questions.to_a.count
    remaining_question_count.times { |i| add_random_question }
  end

  def add_random_question
    question_count = Question.count
    offset = Random.rand(question_count)
    question = Question.offset(offset).first
    if survey_questions.map(&:question).map(&:id).include?(question.id)
      add_random_question
    else
      survey_questions << SurveyQuestion.new(question: question)
    end
  end

  def completed
    survey_questions.where(answer: nil).empty?
  end
end

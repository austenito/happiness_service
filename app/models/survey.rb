class Survey < ActiveRecord::Base
  has_many :survey_questions
  belongs_to :user

  accepts_nested_attributes_for :survey_questions

  def self.generate(user)
    survey = Survey.new(user: user)
    Question.where(always_show: true).each_with_index do |question, index|
      survey.survey_questions.build(question: question, order_index: index)
    end
    5.times { |i| survey.add_random_question(survey.survey_questions.count + 1) }
    survey.save
    survey
  end

  def add_random_question(order_index)
    question_count = Question.count
    offset = Random.rand(question_count)
    question = Question.offset(offset).first
    if survey_questions.include?(question)
      add_random_question
    else
      survey_questions.build(question: question, order_index: order_index)
    end
  end

  def next_question
    survey_questions.where(answer: nil).order(order_index: :asc).first
  end
end

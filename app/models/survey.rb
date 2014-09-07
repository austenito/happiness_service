class Survey < ActiveRecord::Base
  has_many :survey_questions
  belongs_to :user

  accepts_nested_attributes_for :survey_questions

  def self.generate(user)
    survey = Survey.new(user: user)
    survey.build_ordered_survey_questions
    survey.add_random_questions
    survey.build_related_questions
    survey.save
    survey
  end

  def next_question
    survey_questions.where(answer: nil).order(order_index: :asc).first
  end

  def add_random_questions
    remaining_question_count = 5 - survey_questions.to_a.count
    remaining_question_count.times { |i| add_random_question(survey_questions.count + 1) }
  end

  def add_random_question(order_index)
    question_count = Question.count
    offset = Random.rand(question_count)
    question = Question.offset(offset).first
    if survey_questions.map(&:question).map(&:id).include?(question.id) || question.parent_question
      add_random_question(order_index)
    else
      survey_questions.build(question: question, order_index: order_index)
    end
  end

  def build_ordered_survey_questions
    ordered_questions = Question.where.not(absolute_index: nil).order(absolute_index: :asc)
    ordered_questions.each do |question|
      unless question.parent_question
        survey_questions.build(question: question, order_index: question.absolute_index)
      end
    end
  end

  def build_related_questions
    survey_questions.each do |survey_question|
      related_questions = survey_question.question.related_questions
      if related_questions.present?
        survey_questions.build(question: related_questions.sample, order_index: survey_question.order_index)
      end
    end
  end
end

questions = YAML.load_file('config/questions.yml')

# questions.each do |question|
  # text = question['question']
  # type = question['type']

  # case type
    # when "boolean"
      # Question.create(text: text, type: :boolean)
    # when "multiple"
      # Question.create(text: text, type: :multiple, b)
  # end
# end

# Question
#   text
#   belongs_to: questionable, polymorphic: true

# BooleanQuestion
#   has_one :question
#
# MultipleAnswerQuestion
#   # responses: [hi, bye, what]
#
# RangeQuestion
#   min: 0
#   max: 10

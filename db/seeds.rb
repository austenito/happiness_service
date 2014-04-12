questions = YAML.load_file('config/questions.yml')

questions.each do |question_hash|
  text = question_hash['question']
  type = question_hash['type']

  question = Question.create(text: text)
  case type
    when "boolean"
      question.questionable = BooleanQuestion.create
    when "range"
      min = question_hash['min']
      max = question_hash['max']
      question.questionable = RangeQuestion.create(min: min, max: max)
    when "multiple"
      responses = question_hash['responses']
      freeform = question_hash['freeform'] || false
      question.questionable = MultipleResponseQuestion.create(responses: responses, freeform: freeform)
    else
      puts type
  end
  question.save!
end

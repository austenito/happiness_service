questions = YAML.load_file('config/questions.yml')

questions.each do |question_hash|
  text = question_hash['question']
  type = question_hash['type']

  question = Question.create(text: text, question_type: type)
  case type
    when "boolean"
      question.responses = [true, false]
    when "range"
      question.responses = [question_hash['min'], question_hash['max']]
    when "multiple"
      question.responses = question_hash['responses']
  end
  question.save!
end

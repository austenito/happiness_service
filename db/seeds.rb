questions = YAML.load_file('config/questions.yml')

questions.each do |question_hash|
  text = question_hash['question']
  type = question_hash['type']
  always_show = question_hash['always_show']

  question = Question.create(text: text, question_type: type, always_show: always_show)
  case type
    when "boolean"
      question.responses = [true, false]
    when "range"
      question.responses = [question_hash['min'], question_hash['max']]
    when "multiple"
      question.responses = question_hash['responses']
  end
  question.freeform = true if question_hash['freeform'] == true
  question.save!
end

ApiClient.create(name: 'test', token: 'testing')

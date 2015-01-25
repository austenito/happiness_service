def build_question(question_hash)
  text = question_hash['question']
  type = question_hash['type']
  key = question_hash['key']

  question = Question.create(text: text, question_type: type, key: key)
  case type
  when "boolean"
    question.responses = [true, false]
  when "range"
    question.responses = [question_hash['min'], question_hash['max']]
  when "multiple"
    question.responses = question_hash['responses']
  end
  question.save!
  question
end

if Question.count == 0
  puts "Loading seed questions"

  questions = YAML.load_file('config/questions.yml')
  questions.each do |question_hash|
    question = build_question(question_hash)
  end
else
  puts "Questions already loaded"
end

if Rails.env.development? || Rails.env.test?
  ApiClient.create(name: 'test', token: 'testing')
end


if Question.count == 0
  puts "Loading seed questions"

  questions = YAML.load_file('config/questions.yml')
  questions.each do |question_hash|
    text = question_hash['question']
    type = question_hash['type']
    absolute_index = question_hash['absolute_index']

    question = Question.create(text: text, question_type: type, absolute_index: absolute_index)
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
else
  puts "Questions already loaded"
end

if Rails.env.development? || Rails.env.test?
  ApiClient.create(name: 'test', token: 'testing')
end

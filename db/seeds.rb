def build_question(question_hash)
  text = question_hash['question']
  type = question_hash['type']
  absolute_index = question_hash['absolute_index']
  key = question_hash['key']

  question = Question.create(text: text, question_type: type, absolute_index: absolute_index, key: key)
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
  question
end

if Question.count == 0
  puts "Loading seed questions"

  questions = YAML.load_file('config/questions.yml')
  questions.each do |question_hash|
    question = build_question(question_hash)

    related_questions = question_hash['related_questions']
    if related_questions
      related_questions.each do |related_question_hash|
        related_question = build_question(related_question_hash)
        related_question.update_attributes(parent_question_id: question.id)
      end
    end
  end
else
  puts "Questions already loaded"
end

if Rails.env.development? || Rails.env.test?
  ApiClient.create(name: 'test', token: 'testing')
end

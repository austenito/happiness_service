questions = YAML.load_file('config/questions.yml')

questions.each do |question_hash|
  text = question_hash['question']
  type = question_hash['type']

  question = Question.create(text: text)
  case type
    when "boolean"
      question.questionable = BooleanQuestion.create
      question.save!
    else
      puts type
  end
end

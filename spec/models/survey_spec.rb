require 'spec_helper'

describe Survey do
  context '.generate' do
    it "adds 5 different questions" do
      user = create(:user)
      10.times.map { create(:question) }
      survey = Survey.generate(user)
      expect(survey.survey_questions.map(&:id).uniq.count).to eq(5)
    end
  end

  context "#next_question" do
    it "returns next unanswered question" do
      survey_question1 = build(:survey_question)
      survey_question2 = build(:survey_question)
      survey_question3 = build(:survey_question)

      survey = Survey.create(survey_questions: [survey_question1 ,survey_question2, survey_question3])
      expect(survey.next_question).to eq(survey_question1)
      survey_question1.answer = "nyan"
      survey_question1.save
      expect(survey.next_question).to eq(survey_question2)
    end
  end
end

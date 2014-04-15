require 'spec_helper'

describe Survey do
  context '.generate' do
    it "adds 5 unique questions" do
      user = create(:user)
      5.times { create(:question) }
      survey = Survey.generate(user)
      survey.survey_questions.map(&:id).uniq.count.should == 5
    end
  end

  context "#next_question" do
    it "returns next unanswered question by order index" do
      survey_question1 = create(:survey_question, order_index: 1)
      survey_question2 = create(:survey_question, order_index: 2)
      survey_question3 = create(:survey_question, order_index: 3)

      survey = Survey.create(survey_questions: [survey_question2 ,survey_question1, survey_question3])
      survey.next_question.should == survey_question1
      survey_question1.answer = "nyan"
      survey_question1.save
      survey.next_question.should == survey_question2
    end
  end
end

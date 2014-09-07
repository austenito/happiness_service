require 'spec_helper'

describe Survey do
  context '.generate' do
    it "adds 5 questions ordered by absolute index" do
      user = create(:user)
      first_question = create(:question, absolute_index: 0)
      second_question = create(:question, absolute_index: 1)
      5.times.map { create(:question) }
      survey = Survey.generate(user)
      survey.survey_questions.first.question.id.should == first_question.id
      survey.survey_questions.second.question.id.should == second_question.id
      survey.survey_questions.map(&:id).uniq.count.should == 5
    end

    it "adds related questions" do
      user = create(:user)
      first_question = create(:question, absolute_index: 0)
      first_question.related_questions << create(:question)
      20.times.map { create(:question) }
      survey = Survey.generate(user)
      survey.survey_questions.first.question.id.should == first_question.id
      survey.survey_questions.map(&:id).uniq.count.should == 6
      survey.survey_questions.map(&:question).map(&:id).include?(first_question.related_questions.first.id).should be
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

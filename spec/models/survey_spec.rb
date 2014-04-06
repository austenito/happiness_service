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
end

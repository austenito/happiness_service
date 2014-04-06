FactoryGirl.define do
  factory :survey do
    survey_questions { [ create(:survey_question)] }
  end
end

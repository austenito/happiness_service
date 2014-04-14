FactoryGirl.define do
  factory :survey do
    survey_questions { [ create(:survey_question, order_index: 1) ] }
  end
end

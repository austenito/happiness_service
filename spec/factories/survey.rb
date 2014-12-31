FactoryGirl.define do
  factory :survey do
    survey_questions { [ build(:survey_question, order_index: 1) ] }
  end
end

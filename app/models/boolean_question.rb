class BooleanQuestion < ActiveRecord::Base
  has_one :question, as: :questionable
end

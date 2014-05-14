module Api::V1::QuestionRepresenter
  include Roar::Representer::JSON::HAL

  property :id
  property :type
  property :text

  def type
    self.questionable_type
  end
end

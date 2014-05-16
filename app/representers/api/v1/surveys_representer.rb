module Api::V1::SurveyRepresenter
  include Representable::JSON::Collection
  items extend: Api::V1::SurveyRepresenter
end

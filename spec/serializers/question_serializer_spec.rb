require 'rails_helper'

describe Api::V1::QuestionSerializer do
  include Rails.application.routes.url_helpers

  before do
    Rails.application.routes.default_url_options[:host] = 'example.comm'
  end

  it 'returns a question' do
    question = create(:question,
                     text: 'do you like poptarts?',
                     question_type: 'multiple',
                     responses: ['Yes', 'Of course'],
                     absolute_index: 5,
                     key: 'poptarts'
                    )

    serializer = Api::V1::QuestionSerializer.new(question)
    expect(serializer.as_json).to match(a_hash_including(
        text: 'do you like poptarts?',
        question_type: 'multiple',
        responses: ['Yes', 'Of course'],
        key: 'poptarts',
        absolute_index: 5
      )
    )
  end

  it 'returns the url to the question' do
    question = create(:question)
    serializer = Api::V1::QuestionSerializer.new(question)
    expect(serializer.as_json).to match(a_hash_including(
        _links: a_hash_including(
          self: { href: api_question_url(question) }
        )
      )
    )
  end
end

class SurveyQuestion < ActiveRecord::Base
  belongs_to :survey
  belongs_to :question

  attr_writer :text, :responses, :type

  def text
    @text || question.text
  end

  def type
    @type || question.questionable_type
  end

  def responses
    return @responses if @responses

    if question.questionable && question.questionable.respond_to?(:responses)
      question.questionable.responses
    else
      nil
    end
  end
end

class Api::V1::SurveyQuestionsController < ApplicationController
  include Roar::Rails::ControllerAdditions
  respond_to :json

  def show
    representer = if survey_question.boolean?
      Api::V1::BooleanQuestionRepresenter
    elsif survey_question.multiple?
      Api::V1::MultipleResponseQuestionRepresenter
    elsif survey_question.range?
      Api::V1::RangeQuestionRepresenter
    end
    respond_with survey_question, show_next: false, represent_with: representer
  end

  def update
    survey_question.answer = params[:survey_question][:answer]
    survey_question.save!
    respond_with survey_question, { status: :created, location: nil, show_next: true,
                                    represent_with: nil}
  end

  def create
    respond_with Survey.find(params[:survey_id]).survey_questions.create(survey_question_params), status: :created
  end

  private

  def survey_question_params
    params.require(:survey_question).permit(:question_id)
  end

  def survey_question
    @survey_question ||= current_user.surveys.find(params[:survey_id]).survey_questions.find(params[:id])
  end
end

class Api::V1::SurveyQuestionsController < ApplicationController
  respond_to :json

  def show
    respond_with survey_question, show_next: false, represent_with: representer
  end

  def update
    survey_question.answer = params[:survey_question][:answer]
    survey_question.save!
    respond_with survey_question, { status: :created, location: nil, show_next: true,
                                    represent_with: nil}
  end

  def create
    respond_with Survey.find(params[:survey_id]).survey_questions.create(survey_question_params), status: :created, location: nil
  end

  private

  def survey_question_params
    params.require(:survey_question).permit(:question_id)
  end

  def survey_question
    @survey_question ||= Survey.find(params[:survey_id]).survey_questions.find(params[:id])
  end
end

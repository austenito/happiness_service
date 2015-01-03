class Api::V1::SurveyQuestionsController < ApplicationController
  respond_to :json
  before_filter :authenticate_user

  def index
    survey_questions = user.survey_questions.includes(:question).includes(:survey)
    if params[:question_id]
      survey_questions = survey_questions.where(question_id: params[:question_id])
    elsif params[:key]
      survey_questions = survey_questions.joins(:question).where('questions.key = ?', params[:key])
    elsif params[:survey_id]
      survey_questions = survey_questions.where(survey_id: params[:survey_id])
    end

    respond_with survey_questions, { each_serializer: Api::V1::SurveyQuestionSerializer }
  end

  def show
    respond_with survey_question, { serializer: Api::V1::SurveyQuestionSerializer }
  end

  def update
    survey_question.answer = params[:survey_question][:answer]
    survey_question.save!
    respond_with survey_question, { status: :no_content, location: nil, show_next: true,
                                    represent_with: nil}
  end

  def create
    survey_question = Survey.find(params[:survey_id]).survey_questions.create(survey_question_params)
    respond_with survey_question, { status: :created, location: nil, serializer: Api::V1::SurveyQuestionSerializer }
  end

  private

  def survey_question_params
    params.require(:survey_question).permit(:question_id)
  end

  def survey_question
    @survey_question ||= user.surveys.find(params[:survey_id]).survey_questions.find(params[:id])
  end
end

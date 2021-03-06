HappinessService::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: 1) do
      resources :questions, only: [:index, :show, :create]
      resources :survey_questions, only: [:index]
      resources :surveys, only: [:show, :index, :create] do
        resources :survey_questions, only: [:show, :update, :create] do
        end
      end
      resource :user, only: [:create, :show]
    end
  end

  root 'api/v1/root#index'
end

HappinessService::Application.routes.draw do
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: 1) do
      resources :surveys, only: [:show, :index, :create] do
        resources :survey_questions, only: [:show, :create, :new]
      end
    end
  end
end

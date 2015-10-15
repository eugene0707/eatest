Rails.application.routes.draw do

  namespace :api do
    resources :skills, :vacancies, :applicants, except: [:edit, :new]
  end

end

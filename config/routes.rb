Rails.application.routes.draw do

  namespace :api do
    resources :skills,:vacancies, except: [:edit, :new]
  end

end

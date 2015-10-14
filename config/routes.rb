Rails.application.routes.draw do

  namespace :api do
    resources :skills, except: [:edit, :new]
  end

end

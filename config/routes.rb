Rails.application.routes.draw do
  root to: 'home#index'

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  namespace :api do
    resources :skills, :vacancies, :applicants, except: [:edit, :new]
  end

end

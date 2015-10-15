Rails.application.routes.draw do

  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  namespace :api do
    resources :skills, :vacancies, :applicants, except: [:edit, :new]
  end

end

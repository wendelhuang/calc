Rails.application.routes.draw do
  get 'homepage/index'

  get 'salary/index'
  get 'salary/calc'

  root 'homepage#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

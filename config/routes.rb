Rails.application.routes.draw do
  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #resources :articles
  resources :scores
  get "scores_debug", to: "scores#index_debug"

  ##resources :scores_debug

end

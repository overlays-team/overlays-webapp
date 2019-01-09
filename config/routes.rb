Rails.application.routes.draw do

### this list order is important. Was oben steht hat mehr prioritaet.

  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  ##create route for scores automatically
  #resources :scores

  ## add extra route
  get "scores/index.html", to: "scores#index"

  #create route for scores automatically
  resources :scores

  ## add extra route
  get "scores_debug", to: "scores#index_debug"



end

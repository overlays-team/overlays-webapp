Rails.application.routes.draw do

### this list order is important. Was oben steht hat mehr prioritaet.

  get 'welcome/index'
  root 'welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  ## add extra route (old version)
  ##get "scores/index_ruby.html", to: "scores#index"

  #create route for scores automatically
  resources :scores

  ## add extra route
  get "scores_ruby", to: "scores#index_ruby"
  get "scores_debug", to: "scores#index_debug"
  get "scores_desc", to: "scores#scores_desc"
  get "scores_updated_at_desc_with_ranking", to: "scores#scores_updated_at_desc_with_ranking"

end

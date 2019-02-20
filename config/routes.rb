Rails.application.routes.draw do

### this list order is important. Was oben steht hat mehr prioritaet.
### For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #get 'welcome/index'   ## created by default. http://hostname:port/welcome/index
  root 'welcome#index'    ##created by default.  redirect / to index in welcome_controller.rb

  ## add extra route for the score board with embedded Ruby implementation
  get "scores/index_ruby.html", to: "scores#index_ruby"

  ##create route for scores automatically
  resources :scores

  ## add extra route
  get "scores_ruby", to: "scores#index_ruby"
  get "scores_debug", to: "scores#index_debug"
  get "scores_desc", to: "scores#scores_desc"
  get "scores_updated_at_desc_with_ranking", to: "scores#scores_updated_at_desc_with_ranking"

end

RRE::Application.routes.draw do

  get "sitemap" => "sitemaps#sitemap"

  get "users", :to => 'users#index'
  post "users/editor", :to => 'users#make_editor', :as => :make_editor

  devise_for :users

  post "songs/soft_delete", :to => "songs#soft_delete", :as => :soft_delete
  get "songs/deleted_list", :to => "songs#deleted_songs", :as => :deleted_songs
  resources :songs
  post 'shows/tag_show/:id', :to => "shows#tag_show", :as => :tag_show
  delete 'shows/tag_show/:id', :to => "shows#delete_tag", :as => :delete_show_tag
  get 'shows/tabs', :to => 'shows#tabs'
  get 'songs/position_info/:id', :to => 'songs#position_info'
  get 'shows/shows_per_year', to: 'shows#shows_per_year'
  get 'shows/shows_per_month', to: 'shows#shows_per_month'
  
  resources :shows
  resources :venues


  get 'shows/year/:year', :to => 'shows#year'

  root :to => 'shows#welcome'
end

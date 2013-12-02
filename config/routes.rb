Yt::Application.routes.draw do
  devise_for :users
  get "/profile" => "users#profile"
  get "/about" => "home#about"
  get "/uploaded" => "home#uploaded"
  get '/auth/:provider/callback' => 'authentications#create'
  post "/post" => "home#index"

  namespace :api do
    resource :votes
  end

  root "home#index"
end

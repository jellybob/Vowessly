Vowessly::Application.routes.draw do
  resources :pages
  root :to => "home#index"
end

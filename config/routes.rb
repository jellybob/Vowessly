Vowessly::Application.routes.draw do
  resources :pages do
    resources :facts
  end
  
  match 'autocomplete/:field' => "autocomplete#index"
  match ':type/:name' => "pages#find_page"

  root :to => "home#index"
end

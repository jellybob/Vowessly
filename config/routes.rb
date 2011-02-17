Vowessly::Application.routes.draw do
  resource :search, :controller => "search"
  resource :autocompletion, :controller => "autocompletion"
  resources :pages do
    resources :facts
  end
  
  match ':type' => "pages#index", :as => :type_index
  match ':type/:name', :to => "pages#find_page"
  
  root :to => "home#index"
end

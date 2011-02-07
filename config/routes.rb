Vowessly::Application.routes.draw do
  resources :pages do
    resources :facts
  end
  resource :search, :controller => "search"

  match ':type/:name', :controller => "pages", :action => "find_page"
  
  root :to => "home#index"
end

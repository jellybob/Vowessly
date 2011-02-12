Vowessly::Application.routes.draw do
  resource :search, :controller => "search"
  resources :pages do
    resources :facts
  end
  
  match ':type/:name', :controller => "pages", :action => "find_page"
  
  root :to => "home#index"
end

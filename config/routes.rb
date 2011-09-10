Vowessly::Application.routes.draw do
  resource :search, :controller => "search"
  resource :autocompletion, :controller => "autocompletion"
  resources :content_types
  resources :pages do
    resources :facts do
      member do
        post :link
      end
    end
  end
    
  match 'by_province/:province', :controller => "pages", :action => "by_province"
  match ':type/:name', :controller => "pages", :action => "find_page"
  
  root :to => "home#index"
end

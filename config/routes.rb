Blog::Application.routes.draw do
   resources :posts
   resource :sessions
   root to: "welcome#index"
 
end

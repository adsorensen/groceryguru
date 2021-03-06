Rails.application.routes.draw do
  post 'products/done'
  get 'products/done'

  get 'store_display/index'

  get 'store_display/new'
  
  get 'store_display/create'

  get 'list/new'

  get 'list/create'

  get '/recipes/url', to: 'recipes#url'
  get '/recipes/text', to: 'recipes#text'
  post '/recipes/text', to: 'recipes#create'
  
  get '/about', to: 'about#index'
  post '/about', to: 'about#create'

  resources :saved_recipes
  resources :recipes
  resources :instructions
  resources :ingredients
  resources :prep_notes
  resources :ingredients
  resources :users
  resources :carts
  resources :events
  resources :event
  resources :cart, :collection => { :checkout => :post }
  get 'cart', to: 'cart#index'
  post 'checkout', to: 'cart#checkout'
  get 'checkout', to: 'cart#checkout_get'

  root 'users#home'
  get 'new_age/index', :path => "/get-started"

  get 'cart/loadcart'
  get 'sessions/new'

  post 'cart', to: 'cart#create'
  post '/calendar' => 'event#save'
  delete 'calendar', to: "event#destroy"
  post '/calendar/drag' => 'event#update'
  get '/event', to: "event#index"
  get 'event/:id', to: 'event#show'
  post '/list/add_item' => 'list#add_item'
  post '/list/remove_item' => 'list#remove_item'
  delete 'cart', to: 'cart#destroy'
  get 'calendar', to: 'calendar#index'
  get  'signup',  to: 'users#new'
  get    'login',   to: 'sessions#new'
  post   'login',   to: 'sessions#create'
  post '/recipes/new', to: 'recipes#create'
  delete 'logout',  to: 'sessions#destroy'
  get 'create_list', to: 'list#create_list'
  post '/addReview', to: 'recipes#review'
  post '/saved_recipes/:id', to: "saved_recipes#destroy"
  post "/recipes/edit_review" => "recipes#edit_review"
  post "/recipes/url_parse" => "recipes#parse_url"
  delete "/review/:id" => "recipes#delete_review"
  get "/cart/checkout_to_store", to: "store_display#index"
  post '/userplans', to: 'meal_plans#user_plans' 
  post '/mealplans', to: 'meal_plans#create'
  post '/addtoplan', to: 'meal_plans#add_recipe'
  post '/deleteplan/:id', to: 'meal_plans#destroy'
  get '/mealplans/:id', to: "meal_plans#show"
  get '/mealplans', to: "meal_plans#index"
  post '/plans/:id', to: 'plans#destroy'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

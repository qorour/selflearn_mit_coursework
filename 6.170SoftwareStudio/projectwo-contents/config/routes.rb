Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  #post "/sites/:id/visits", to: "sites#create"
  post "/shops", to: "shops#create"
  get "/shops", to: "shops#index" #displays all available shops/catalogs
  get "/shops/:id", to: "shops#show" #displays specific site/show catalog
  #put "/sites/:id", to: "sites#update"
  post "/shops/:id/catalog", to: "shops#createcatalog" # creates catalog for shop
  put "/shops/:id/catalog", to: "shops#updatecatalog" # update catalog for shop
  get "/shops/:id/catalog", to: "shops#showcatalog" # get catalog for specific shop
  delete "/shops/:id/catalog", to: "shops#deletecatalog" # deletes catalog for shop
  #
  get "/shops/:id/orders", to: "shops#showallorders" #show all orders for a specific shop


  post "/users", to: "users#create" # begin process for creating new user
  #get "/users", to: "users#index" #dont think ever need display of all users
  get "/users/:id", to: "users#show" #access specific user, will need to add login
  # cart is one-to-one with user, so only methods for it are in user
  post "/users/:id/cart" # creates cart for user
  put "/users/:id/cart", to: "users#updatecart" #update content of cart
  get "/users/:id/cart", to: "users#currentcart" #access current cart of user.
  delete "/users/:id/cart" # deletes cart user owns (one-to-one)
  # order is NOT one-to-one, one of many, so you can create it here but its it's own methods too
  # ...esp cause we need to display all orders for specific constraints/filters
  get "/users/:id/order", to: "users#currentorder" #access current order(s) of user put in
  put "/users/:id/order", to: "users#updateorder" #update contents of order(s)


  # no direct methods for catalog/carts, as you need a shop/user respectively to create one
  #post "/carts", to: "carts#create" # create new cart based on id of user (add check if already has cart)
  #get "/carts/:id", to: "carts#show" #access specific info on cart
  #post "/carts/:id/product/:item" to "carts#addproduct" #add specific product to specific cart
  #delete "/carts/:id/product/:item" to "carts#addproduct" #remove specific product from specific cart
  #post "/catalogs", to: "catalogs#create" # doesnt use,as needs a shop to create it. parent-child relationship
  #get "/catalogs", to: "catalogs#index" # never need to display all catalogs
  #get "/catalogs/:id", to: "catalogs#show" #access specific catalog based on id
  #get "/catalogs/:id/items", to: "catalogs#items" #access specific catalog items


  post "/orders", to: "orders#create" # create new order 
  get "/orders/:id", to: "orders#show" #access specific order based on id
  get "/orders/:id/cart", to: "orders#currentcart" #access specific order's current cart based on id
  get "/orders/:id/info", to: "orders#orderinfo" #access specific order info


  post "/products", to: "products#create" # create new product with specific id
  get "/products", to: "products#index" #access list of products, will display in catalog i imagine
  get "/products/:id", to: "products#show" #access specific product via id

  
  #match "*path", to: "application#handle_options_request", via: [:options] # for CORS handling
end

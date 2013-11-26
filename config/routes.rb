require 'sidekiq/web'
Aries::Application.routes.draw do


  #remove from comment once we have correct domain instead of heroku url
  constraints(Subdomain) do
    match '/' => 'stores#show'
    post '/orders' => 'orders#create'
    post '/requests' => 'requests#create'
    match "/:number" => "products#show",:as => "product"
  end
  
  mount Sidekiq::Web, at: "/sidekiq"

  root :to => "home#index"
  
  
  resources :file_handlers
  resources :orders do
    resources :comments,:only => [:new,:create,:show] 
  end
  
  #get "images/new"
  
  resources :home do
    collection do
      get :subscriptions
      get :stories
      get :recommendations
    end
  end
  
  get '/find_friends', to: 'settings#find_friends', as: :find_friends

  get "new/create"

  get "new/destroy"
  get 'tags/:tag', to: 'products#index', as: :tag
  get '/notifications', to: 'settings#user_notifications', as: :notifications
  devise_for :users

  match "auth/:provider/callback" => "social_sites#create"
  
  resources :user_registrations,:only => [:new,:create] do
    collection do
      get :confirm_account
      put :resend_confirmations
    end
  end
  
  resources :dashboard do
    collection do
      get :products 
      get :orders
      get :views
      get :reviews
    end
  end
  
  resources :settings,:except => [:new,:create,:show,:edit,:update,:index,:destroy],:path => '/dashboard/settings/' do
    member do
      get :notifications
      post :create_notification
      get :edit_notifications
      put :notification_updation
    end
    collection do
      get :account
      put :update_account
      get :social
      post :send_twitter_message
      get :complete_social_signup
      put :update_social_signup
    end
  end
  resources :stores, :except =>[:show]
  resources :products,:except => [:show,:edit,:update] do
    member do
      get :payment
      put :recommend
      put :post_product
    end
    
    collection do
      get :top_products
      put :product_delete
    end
  end

  resources :profiles, :except => [:show] do
    collection do
      get :balance
      get :shopping
      get :referral
    end
    member do
      get :subscriptions, :subscribers
    end
  end

  resources :relationships, only: [:create, :destroy]
  resources :requests, only: [:index]
  resources :activities, only: [:index]
  resources :questions, except: [:new, :edit] do
    collection do
      get :answered
      get :your_questions
    end
    resources :answers, only: [:new,:create]
  end
  resources :themes
  
  match "/discover" => "discover#discover"
  match "/discover/products" => "discover#product"
  match "/discover/shops" => "discover#shop"
  match "/discover/people" => "discover#people"
  match "/discover/tags" => "discover#tags"
  match "/products/add" => "products#add", :as => "add_product"
  match "/listing/:id" => "products#listing_complete", :as => "listing"
  match "customise/:username" => "stores#customise"
  match 'products/:product_id/make_payment' => 'products#make_payment', :as => :confirm_payment
  match "/products/:number/edit" => "products#edit",:as => "edit_product"
  match "/products/:number" => "products#update",:as => "update_product"
  match "/products/:random_no/download_product" => 'products#download_product',:as => 'download'
  match "profiles/:username" => "profiles#show"
  match "profiles/:username/drawer" => "profiles#drawer", :as => "drawer"
  match "profiles/:username/recommendations" => "profiles#recommends", :as => "recommends"
  match "profiles/:username/activities" => "profiles#activities", :as => "activities"
  match "stores/update_theme_content" => "stores#update_theme_content"
  match "/update_custom_appearance" => "stores#custom_appearance_update"
  post  "/shipping_option", to: "stores#add_shipping_profiles"



  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

Niceneighbor::Application.routes.draw do

  devise_for :users do
    get "sign_in", :to => "devise/sessions#new"
    get "sign_up", :to => "devise/registrations#new"
    get "sign_out", :to => "devise/sessions#destroy"
  end

  match 'voice' => 'twilio#voice'
  match 'sms' => 'twilio#sms'

  scope '/post' do
    resources :have, :need
  end

  resources :users, :only => [:show, :new, :create]
  scope :path => '/profile', :controller => :users do
    match '' => :edit, :as => :profile
    match 'update' => :update, :as => :update_profile
    match 'destroy' => :destroy, :as => :destroy_profile
  end

  resources :neighborhoods , :only => [:index, :show, :new, :create, :edit, :update] do
    member do
      post 'join'
      post 'leave'
    end
  end
  match '/neighborhoods/near/:location' => 'neighborhoods#index'

  match '/search' => 'search#redirect', :as => :search
  match '/:activity/*other' => 'search#results', :activity => /(have|need|find)/, :as => :search_results
  match '/needs' => 'search#results', :activity => 'need', :as => :needs

  scope :controller => :site do
    match '/about' => :about
    match '/terms' => :terms
  end
  root :to => 'site#index'

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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end

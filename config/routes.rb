SampleApp::Application.routes.draw do

  resources :users, :hurdles, :wattballs, :teams, :matches, :tickets
  match '/tickets/send_mail', to: 'tickets#send_mail'
  resources :sessions, only: [:new, :create, :destroy]
  resources :heats do
    member do
      get 'add_result'
      put 'update_result'
    end
  end
  

  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/signout', to: 'sessions#destroy', via: :delete
  
  match '/help',    to: "static_pages#help"
  match '/about',   to:"static_pages#about"
  match '/contact', to: "static_pages#contact"
  
  match '/participants', to: "static_pages#participants"
  match '/participants/athletes', to: "hurdles#index"
  match '/participants/teams', to: "teams#index"
  
  match '/schedules', to: "static_pages#schedules"
  match '/schedules/matches', to: "matches#index"
  match '/schedules/heats', to: "heats#index"

  
  root to: 'static_pages#home'
  
  namespace :admin do
    resources :staffs
    resources :staff_sessions, only: [:new, :create, :destroy]
    resources :users
    resources :hurdles
    resources :wattballs
    resources :teams
    resources :umpires
    resources :matches
    resources :tickets
    resources :scores
    resources :tournaments do
      member do
        post 'generate_heats'
        post 'populate_heats'
        post 'delete_heats'
      end
    end
    resources :salesreports, only: [:index]
    match "/tickets/:id/activate" => "tickets#activate", :as => "activate_ticket"
    match '/staffsignin', to: 'staff_sessions#new'
    match '/staffsignout', to: 'staff_sessions#destroy', via: :delete
    match '', to: 'dashboard#index'
    match 'admin/umpires', to: "admin#umpires"
    match 'admin/matches', to: "admin#matches"
    match 'admin/salesreport', to: "admin#help"
  end


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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

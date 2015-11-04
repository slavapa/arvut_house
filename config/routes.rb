ArvutHouse::Application.routes.draw do



  get "ajax/users"
  root 'home#default'
  scope '(:locale)' do 
    match "/home/loc_lang" => "home#loc_lang", :as => 'loc_lang', via: 'post'
    resources :person_event_relationships, only: [:create, :destroy]
    resources :person_payments, only: [:create, :destroy, :update]
    resources :department_person_roles
    resources :app_setup_types

 
    resources :people do
      member do
        get 'languages'
      end
    end
    
    resources :events do
      member do
        get 'all_people'
      end
    end
    
    resources :payments do
      member do
        get 'all_people'
      end
    end
     
    resources :payment_types do
      member do
        get 'payments_report'
      end
    end
      
    resources :event_types do
      member do
        get 'events_report'
      end
    end
    
    resources :person_languages, only: [:create, :destroy]
  
    get "home/default"
    match '/about',       to: 'home#about',           via: 'get'
    match '/contact_us',  to: 'home#contact_us',      via: 'get'    
    match '/signup',      to: 'people#new',            via: 'get'
    match '/signin',      to: 'sessions#new',         via: 'get'
    match '/signout',     to: 'sessions#destroy',     via: 'delete'
    
    resources :sessions, only: [:new, :create, :destroy]
    resources :languages
    resources :statuses
    resources :roles
    resources :departments
    
    get "person_payments/create"
    get "person_payments/destroy"
    get "person_payments/update"
  end

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

Rails.application.routes.draw do

  root 'home#index'
  get 'home/index'
  get 'home/credits' => 'home#credits', as: 'credits'

  devise_for :users
  get 'users/:id' => 'users#show', as: 'user'

  resources :suppliers do
    resources :inventory_items
  end

  get 'orders/deliveries' => 'orders#deliver', as: 'deliveries'

  resources :orders do
    resources :invoices
  end


  get 'invoices' => 'invoices#index', as: 'invoices'

  resources :order_items
  resources :restaurants

  patch 'order_items' => 'order_items#mass_update'
  patch 'invoice_items' => 'invoice_items#mass_update'

  resources :invoice_items
  resources :items, except: %w(edit)
  resources :permissions, except: %w(show)

  get 'filter_index' => 'orders#filter_index', as: 'filter_index'

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

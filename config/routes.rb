Rails.application.routes.draw do

	resources :products

	get 'products/:id/delete' => 'products#delete', as: 'product_delete'
	put 'products/:id' => 'products#update', as: 'product_update'
	root 'welcome#index'


# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
	get '/companies' => 'companies#index'
	get '/companies/new' => 'companies#new'
	post '/companies' => 'companies#create'
	get '/companies/:id/edit' => 'companies#edit'
  patch '/companies/:id' => 'companies#update'
  get '/companies/:id' => 'companies#show'
  delete '/companies/:id' => 'companies#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

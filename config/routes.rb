Rails.application.routes.draw do


   devise_for :authors,controllers: { registrations: "registrations"}
   # resources :authors do
   #   member do
   #        get :following, :followers
   #     end
   #   end
   root to: "blog/posts#index"


   namespace :authors do
     get '/account' => 'accounts#edit', as: :account
     put '/info' => "accounts#update_info", as: :info
     put '/change_password' => 'accounts#change_password', as: :change_password
     get '/changepassword'=>'accounts#password', as: :password

     resources :authors do
       member do
         get :following, :followers
       end
     end
     resources :posts do
       put 'publish' => 'posts#publish', on: :member
       put 'unpublish' => 'posts#unpublish', on: :member
     end
   end


  scope module: 'blog' do
    get 'about'=>"pages#about", as: :about
    get 'contact'=>"pages#contact", as: :contact
    get 'posts' =>'posts#index', as: :posts
    get 'posts/:id' =>'posts#show', as: :post
    resources :posts do
      get 'author' => 'posts#author', on: :member
      get 'following'=>'posts#following', on: :member
      get 'followers' =>'posts#followers', on: :member
    end


    resources :relationships,       only: [:create, :destroy]

  end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  
   resources :products do 
     member do
     get "trans"
     end
     collection do 
       put 'trans_pay'
     end
   end
   
   get "/sign_up" , :to=> "users#new"
   get 'users/login_page'
   put 'users/validate_login'
   get 'users/logout'
   resources :users 
   root to: "users#login_page"
end


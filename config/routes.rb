Rails.application.routes.draw do

  post '/auth/login', to: 'authentication#login'
#Get User
  get '/users/:_username', to: 'users#show'
  get '/users', to: 'users#index'

 #Create Booking
  get '/booking/:id', to: 'bookings#show'
  get '/booking', to: 'bookings#index'
  post '/booking/create-booking', to: 'bookings#create'
  post '/booking/check-in', to: 'bookings#check_in'
  get '/booking-me/', to: 'bookings#all_by_current'
#create Room
  resources :rooms

  get '/*a', to: 'application#not_found'
#Create User
  post '/users', to: 'users#create'

  
end

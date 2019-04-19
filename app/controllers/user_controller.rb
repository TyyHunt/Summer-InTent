class UserController < ApplicationController
  
  get '/login' do
    if !session[:user_id]
      erb :'users/login'
    else
      redirect '/users/show'
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:id] = user.id
      redirect to '/users/show'
    else
      redirect '/login'
    end
  end
  
  get '/signup' do
    if !session[:user_id]
      erb :'/users/new'
    else
      redirect to '/users/show'
    end
  end
  
  post '/signup' do
  end

  get '/users/show' do
    erb :'/users/show'
  end
end
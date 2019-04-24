class UserController < ApplicationController
  
  get '/users/:id' do
    if !logged_in?
      redirect '/login'
    end

    @user = User.find(session[:user_id])
    if !@user.nil? && @user == current_user
      erb :'/users/show'
    else
      redirect '/plans'
    end
  end
  
  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      redirect '/plans'
    end
  end
  
  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/plans"
    else
      redirect to '/login'
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
    if params[:username] == "" || params[:password] == ""
      redirect to '/signup'
    else
      @user = User.create(:username => params[:username], :password => params[:password])
      session[:user_id] = @user.id
      redirect to '/plans'
    end
  end
  
  get '/users/:slug' do
    @user = User.find_by(params[:slug])
    erb :'/users/show'
  end

  get '/logout' do
    if !session[:user_id] != nil 
      session.clear
      redirect to '/login'
    else
      redirect to '/'
    end
  end
  
end
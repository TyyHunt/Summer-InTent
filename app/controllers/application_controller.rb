require './config/environment'

class ApplicationController < Sinatra::Base 
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "for_password_security"
  end
  
  get '/' do
    erb :index
  end
  
  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
    
    def correct_user?(user)
      user == current_user
    end
    
    def account_route
      if logged_in?
        "/users/#{ current_user.id }"
      else
        "/login"
      end
    end
  end
  
end
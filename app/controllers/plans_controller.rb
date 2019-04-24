class PlanController < ApplicationController
  
  get '/plans' do
    if logged_in?
      @plans = Plan.all
      erb :'/plans/index'
    else
      redirect to '/'
    end
  end
  
  get '/plans/new' do
    if logged_in?
      erb :'/plans/new'
    else
      redirect to '/login'
    end
  end
  
  post '/plans' do
    
    if params[:location] == "" || params[:party_number] == "" || params[:shelter_type] == ""
      redirect to '/plans/new'
    else
      @plan = Plan.new(params)
      @plan.user_id = current_user.id
      @plan.save
      redirect to '/users/show'
    end
  end
  
  get '/plans/:id' do
    if logged_in?
      @plan = Plan.find(params[:id])
      erb :'/plans/show'
    else
      redirect '/login'
    end
  end
  
  get '/plans/:id/edit' do
    if logged_in?
      @plan = Plan.find(params[:id])
      erb :'/plans/edit'
    else
      redirect '/login'
    end
  end
  
  patch '/plans/:id' do
    if logged_in?
      @plan = Plan.find(params[:id])
      if params[:location] == "" || params[:party_number] == "" || params[:shelter_type] == ""
        redirect "/plans/#{@plan.id}/edit"
      else
        @plan.update(:location => params[:location], :party_number => params[:party_number], :shelter_type => params[:shelter_type], :user_id => @plan.user_id)
        redirect "/plans/#{@plan.id}"
      end
    else
      redirect '/login'
    end
  end

  delete '/plans/:id' do
    if logged_in?
      @plan = Plan.find(params[:id])
      if @plan.user == current_user
        @plan.delete
        redirect "/plans"
      else
        redirect "/plans"
      end
    else
      redirect "/login"
    end
  end
  

  
end
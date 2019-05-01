class PlanController < ApplicationController
  
  get '/plans' do
    if_not_logged_in 
    @plans = Plan.all
    erb :'/plans/index'
  end
  
  get '/plans/new' do
    if_not_logged_in
    erb :'/plans/new'
  end
  
  post '/plans' do
    if_not_logged_in
    if params[:location] == "" || params[:party_number] == "" || params[:shelter_type] == ""
      redirect to '/plans/new'
    else
      @plan = current_user.plans.build(params)
      @plan.save
      redirect to "/users/#{@plan.user_id}"
    end
  end
  
  get '/plans/:id' do
    @plan = Plan.find_by(id: params[:id])
    if @plan == nil
      erb :'/error'
    else
      erb :'/plans/show'
    end
  end
  
  get '/plans/:id/edit' do
    @plan = Plan.find(params[:id])
    if correct_user?(@plan.user)
      erb :'/plans/edit'
    else
      redirect "/plans/#{@plan.id}"
    end
  end
  
  patch '/plans/:id' do
    @plan = Plan.find(params[:id])
    if logged_in? && correct_user?(@plan.user)
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
    if_not_logged_in
    @plan = Plan.find(params[:id])
    if @plan.user == current_user
      @plan.delete
    end
      redirect "/plans"
  end
  

  
end
class PlanController < ApplicationController
  get '/plans' do
    if !logged_in?
      @plans = Plan.all
      erb :'/plans/index'
    else
      redirect to '/'
    end
  end
  
  get '/plans/new' do
    if !logged_in?
      erb :'/plans/new'
    else
      redirect to '/login'
    end
  end
  
  post '/plans' do
    @plan = Plan.new(:location => params[:location], :party_number => params[:party_number], :shelter_type => params[:shelter_type])
    if params[:location] == "" || params[:party_number] == "" || params[:shelter_type] == ""
      redirect to '/plans/new'
    else
      @plan.save
      redirect to '/plans'
    end
  end
  
end
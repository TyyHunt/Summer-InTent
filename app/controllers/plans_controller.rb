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
  end
end
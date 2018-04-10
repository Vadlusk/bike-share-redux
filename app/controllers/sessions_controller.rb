class SessionsController < ApplicationController
  def new
    session[:user_id] = nil
  end
end

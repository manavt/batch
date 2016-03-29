class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  
  before_action :check_seesion
  
  before_action :first_me
  
  def check_seesion
    flash[:notice] =  "Hello I am here "   
  end
  
  def first_me
      flash[:notice] = "I am the top of every action" 
      puts "I am below of every action"   
  end
   before_action :check_session
   
   def check_session
     if session[:user_id].blank?
       redirect_to root_path
     end
   end
end

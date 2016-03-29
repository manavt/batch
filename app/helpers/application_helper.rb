module ApplicationHelper
  def current_user_email 
    (User.find session[:user_id]).email
  end
  def admin?
    (User.find session[:user_id]).email == "admin@gmail.com"
  end
  def return_user_object
    @user = (User.find session[:user_id])
  end
end


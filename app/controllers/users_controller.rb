class UsersController < ApplicationController
 
  skip_before_action :first_me , :only => [:new, :create, :edit, :update, :destroy, :show]
  skip_before_action :check_session, :only => [:new, :create, :login_page, :validate_login]
 
  def index
    @user = User.paginate(:page => params[:page], :per_page => 5)
    logger = Logger.new("#{Rails.root}/log/manual_log.log")
    logger.info(@user)
    @user + []
  end

  def new
    @user = User.new
    @user.build_image
  end
  
  def create
    
    @user = User.new(user_params)
    respond_to do | format |
    if @user.save
      format.html do 
      #  session[:user_id] = @user.id
        EmailSend.welcome(@user, "Welcome to batch250 store").deliver!
        redirect_to :action=>"index"
        flash[:notice] = "Successfully created user records :)"
      end
      format.json  do
        render json: @user
      end 
    else
      format.html do
        render "new"
        flash[:notice] = "Opps something went wrong!"
      end
      format.json do 
        render json: {:status => "Opps something went wrong!"}
      end
       format.xml do 
        render xml: {:status => "Opps something went wrong!"}
      end
      
    end
    end
  end
  
  def edit
     @user = User.find params[:id]
  end
   def update
    @user = User.find params[:id]
    if @user.update_attributes(user_params)
      redirect_to :action=>"index"
      flash[:notice] = "Successfully updated user records :)"
    else
      render "new"
      flash[:notice] = "Opps something went wrong!"
    end
  end
  def show
     @user = User.find params[:id]
  end
  def destroy
    @user = User.find params[:id]
    @user.delete
    redirect_to :action=>"index"
    flash[:notice] = "Successfully deleted records :)"
  end
  def login_page
    @user = User.new
  end
  def validate_login
    @user = User.authenticate(user_params)  
    if @user 
      session[:user_id] = @user.id
      redirect_to :action => "index"
    else
      redirect_to :action => "login_page"
    end 
  end
  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
  private
  def  user_params
    params.require(:user).permit!
  end
end


#params = {}
#params = {:user={:name=>"", :email=>, :address=>""}}









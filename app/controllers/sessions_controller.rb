class SessionsController < ApplicationController
  def new
  end
  
  def create
   email = params[:session][:email]
   password = params[:session][:password]
   user = User.authenticate(email, password)
   
   if user # if authentication is succesful
     session[:user_id] = user.id
     flash[:notice]="You've been logged in."
     redirect_to :root
   else # If wrong credentials
     flash[:error] = "Wrong credentials, please try again."
     render :action => "new"
   end
  end
    #Logout
    def destroy
      session[:user_id]=nil
      flash[:notice]="You've been logged out."
      redirect_to :root
    end


end

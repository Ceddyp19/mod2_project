class SessionsController < ApplicationController
    def new
    end
 
    def create
        @user = User.find_by(email: session_params["email"])
        #byebug
       if @user && @user.authenticate(session_params["password"])
          session[:user_id] = @user.id
          redirect_to '/user_home'
       else
          flash.now[:danger] = 'Invalid email/password combination'
          render :new
       end
        # @user = User.find_by(email: params[:email])
        # return head(:forbidden) unless @user.authenticate(params[:password])
        # session[:user_id] = @user.id
        # redirect_to controller: 'welcome', action: 'user_home'
        # user = User.find_by(name: params[:user][:name])

        # user = user.try(:authenticate, params[:user][:password])

        # return redirect_to(controller: 'sessions', action: 'new') unless user

        # session[:user_id] = user.id

        # @user = user

        # redirect_to controller: 'welcome', action: 'user_home'
    end

    def destroy
        session.delete :user_id
    
        redirect_to '/'
    end

    private

    def session_params
        params.require(:session).permit(:email, :password, :password_confirmation)
     end
end
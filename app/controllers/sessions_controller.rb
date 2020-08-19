class SessionsController < ApplicationController
    def new
    end
 
    def create
        @user = User.find_by(email: params[:email])
        return head(:forbidden) unless @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to controller: 'welcome', action: 'user_home'
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
end
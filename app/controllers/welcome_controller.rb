class WelcomeController < ApplicationController
    before_action :require_login, only: [:user_home]
    def home
    end

    def about 
    end

    def user_home
        @user = current_user
    end

    def analytics
    end
end


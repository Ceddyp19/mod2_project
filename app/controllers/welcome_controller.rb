class WelcomeController < ApplicationController
    before_action :require_login, only: [:user_home]
    def home
    end

    def user_home
    end
end


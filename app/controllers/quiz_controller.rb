class QuizController < ApplicationController
    def intro
    end

    def play
        render :layout => 'quiz'
    end

    def test
        render :layout => 'quiz'
    end

end

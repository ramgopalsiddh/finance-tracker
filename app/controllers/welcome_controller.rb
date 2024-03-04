class WelcomeController < ApplicationController

  # show index route without authenticate user
  skip_before_action :authenticate_user!, only: [:index]

  def index
  # redirect user to my_portfolio_path after login
  redirect_to my_portfolio_path if user_signed_in?
  end

end

class UsersController < ApplicationController
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  # Search friends 
  def search
    if params[:friend].present?
      @friends = User.search(params[:friend])
      @friends.delete(current_user)  # to avoid finding himself

      if @friends
        respond_to do |format|
          format.js { render partial: 'users/friend_result_js' }
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Sorry, could not find the user"
          format.js { render partial: 'users/friend_result_js' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = "Please enter a name or email address to search"
        format.js { render partial: 'users/friend_result_js' }
      end
    end
  end

end

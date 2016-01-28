class UsersController < ApplicationController

  def signup
    render template: "devise/registrations/new"
  end

  def show
    @user = current_user
  end
end
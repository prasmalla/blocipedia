class UsersController < ApplicationController

  def signup
    render template: "devise/registrations/new"
  end

  def show
    @user = current_user
  end

  def downgrade
    @user = current_user
    @user.downgrade!

    flash[:notice] = "Account downgraded successfully!"
    redirect_to current_user
  end
end
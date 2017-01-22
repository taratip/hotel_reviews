class Admin::UsersController < ApplicationController
  before_action :authorize_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to root_path, notice: 'The user was deleted.'
  end
end

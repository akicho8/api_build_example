class UsersController < ApplicationController
  before_action do
    @users = User.order(:id)
    @user = User.order(:id).first
  end
end

class UsersController < ApplicationController
  # TODO to be removed
  def index
    @users = User.all
  end
end

class UsersController < ApplicationController
  def hoge
    redirect_to new_user_registration_path
  end
end

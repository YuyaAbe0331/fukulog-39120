class UsersController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :set_user, only: [:show, :edit, :update]
      
  def show
    @garments = @user.garments.order("created_at DESC")
  end

  def edit
    if user_signed_in? && current_user != @user
      redirect_to root_path
    end
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(@user.id)
    else
      render :edit
    end
  end

  def redirect_user
    redirect_to new_user_registration_path
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email, :sex_id, :height_id, :weight_id)
  end

  def set_user
    @user = User.find(params[:id])
  end

end

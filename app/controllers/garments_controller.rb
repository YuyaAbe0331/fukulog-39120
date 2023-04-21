class GarmentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_garment, only: [:show, :edit, :update, :destroy]
  before_action :check_current_user, only: [:edit, :destroy]

  def index
    @garments = Garment.includes(:user).order("created_at DESC")
  end

  def new
    @garment = Garment.new
  end

  def create
    @garment = Garment.new(garment_params)
    @garment = Garment.create(garment_params)
    unless @garment.save
      render :new
    end
  end

  def redirect_garment
    redirect_to new_garment_path
  end

  def show
  end

  def edit
  end

  def update
    if @garment.update(garment_params)
      redirect_to garment_path(@garment)
    else
      render :edit
    end
  end


  def destroy
    if @garment.destroy
      redirect_to root_path
    end
  end

  private

  def garment_params
    params.require(:garment).permit(:image, :name, :genre_id, :category_id, :brand, :material, :size, :other).merge(user_id: current_user.id)
  end

  def set_garment
    @garment = Garment.find(params[:id])
  end

  def check_current_user
    if user_signed_in? && current_user.id != @garment.user.id
      redirect_to root_path
    end
  end

end

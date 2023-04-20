class GarmentsController < ApplicationController
  before_action :authenticate_user!, except: :index

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
    @garment = Garment.find(params[:id])
  end

  private

  def garment_params
    params.require(:garment).permit(:image, :name, :genre_id, :category_id, :brand, :material, :size, :other).merge(user_id: current_user.id)
  end

end

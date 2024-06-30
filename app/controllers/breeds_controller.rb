# app/controllers/breeds_controller.rb
class BreedsController < ApplicationController
  def index
    @breeds = Breed.page(params[:page]).per(10)
  end

  def show
    @breed = Breed.find(params[:id])
  end

  def new
    @breed = Breed.new
  end

  def create
    @breed = Breed.new(breed_params)
    if @breed.save
      redirect_to @breed
    else
      render :new
    end
  end

  def edit
    @breed = Breed.find(params[:id])
  end

  def update
    @breed = Breed.find(params[:id])
    if @breed.update(breed_params)
      redirect_to @breed
    else
      render :edit
    end
  end

  def destroy
    @breed = Breed.find(params[:id])
    @breed.destroy
    redirect_to breeds_path
  end

  private

  def breed_params
    params.require(:breed).permit(:name, :sub_breeds)
  end
end

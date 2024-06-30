
class DogShowsController < ApplicationController
  def index
    @dog_shows = DogShow.page(params[:page]).per(10)
  end

  def show
    @dog_show = DogShow.find(params[:id])
  end

  def new
    @dog_show = DogShow.new
  end

  def create
    @dog_show = DogShow.new(dog_show_params)
    if @dog_show.save
      redirect_to @dog_show
    else
      render :new
    end
  end

  def edit
    @dog_show = DogShow.find(params[:id])
  end

  def update
    @dog_show = DogShow.find(params[:id])
    if @dog_show.update(dog_show_params)
      redirect_to @dog_show
    else
      render :edit
    end
  end

  def destroy
    @dog_show = DogShow.find(params[:id])
    @dog_show.destroy
    redirect_to dog_shows_path
  end

  private

  def dog_show_params
    params.require(:dog_show).permit(:name, :date)
  end
end

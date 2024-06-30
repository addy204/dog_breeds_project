class DogShowsController < ApplicationController
  def index
    @dog_shows = DogShow.page(params[:page]).per(10)
  end

  def show
    @dog_show = DogShow.includes(:breeds).find(params[:id])
  end
end

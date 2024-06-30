class DogShowsController < ApplicationController
  def index
    @dog_shows = if params[:search].present?
                   DogShow.where('name LIKE ?', "%#{params[:search]}%")
                 else
                   DogShow.all
                 end.page(params[:page]).per(10)
  end

  def show
    @dog_show = DogShow.find(params[:id])
  end
end

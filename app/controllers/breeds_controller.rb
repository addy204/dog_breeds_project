class BreedsController < ApplicationController
  def index
    @breeds = Breed.page(params[:page]).per(10)
  end

  def show
    @breed = Breed.includes(:owner, :dog_shows, :breed_facts).find(params[:id])
  end
end

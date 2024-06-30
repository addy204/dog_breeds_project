class BreedsController < ApplicationController
  def index
    @owners = Owner.all
    @breeds = if params[:search].present? && params[:owner_id].present?
                Breed.where('name LIKE ? AND owner_id = ?', "%#{params[:search]}%", params[:owner_id])
              elsif params[:search].present?
                Breed.where('name LIKE ?', "%#{params[:search]}%")
              elsif params[:owner_id].present?
                Breed.where(owner_id: params[:owner_id])
              else
                Breed.all
              end.page(params[:page]).per(10)
  end

  def show
    @breed = Breed.find(params[:id])
  end
end

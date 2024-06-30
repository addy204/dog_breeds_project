class OwnersController < ApplicationController
  def index
    @owners = if params[:search].present?
                Owner.where('name LIKE ?', "%#{params[:search]}%")
              else
                Owner.all
              end.page(params[:page]).per(10)
  end

  def show
    @owner = Owner.find(params[:id])
  end
end

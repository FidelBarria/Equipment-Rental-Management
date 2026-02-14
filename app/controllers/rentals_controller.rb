class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to rentals_path, notice: "Rental was successfully created."
    else
      render :new
    end
  end

  private
  def rental_item_params
  params.require(:rental_item).permit(:rental_id)
  end

  def rental_params
    params.require(:rental).permit(:client_id, :event_id, :user_id, :start_date, :end_date, :total_value, :status)
  end
end

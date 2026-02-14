class RentalItemsController < ApplicationController
  before_action :set_rental
  def index
    @rental_items = RentalItem.all
  end
  def new
    @rental_item = @rental.rental_items.build
  end
  def create
    @rental_item = @rental.rental_items.build(rental_item_params)
    if @rental_item.save
      redirect_to rentals_path, notice: "Rental item was successfully created."
    else
      render :new
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:rental_id])
  end

  def rental_item_params
    params.require(:rental_item).permit(:equipment_id, :rental_id, :quantity, :daily_price, :subtotal)
  end
end

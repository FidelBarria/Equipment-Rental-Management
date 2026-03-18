class RentalItemsController < ApplicationController
  before_action :set_rental

  def index
    @rental_items = @rental.rental_items
  end

  def new
    @rental_item = @rental.rental_items.build
    @equipment = if params[:query].present?
                   Equipment.by_name(params[:query])
                 else
                   Equipment.available_for_rental
                 end
  end

  def create
    @rental_item = @rental.rental_items.build(rental_item_params)
    if @rental_item.save
      redirect_to new_rental_rental_item_path(@rental), notice: "Item added to rental successfully."
    else
      @equipment = Equipment.available_for_rental
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @rental_item = @rental.rental_items.find(params[:id])
    @rental_item.destroy
    redirect_to new_rental_rental_item_path(@rental), notice: "Item removed from rental."
  end

  private

  def set_rental
    @rental = Rental.find(params[:rental_id])
  end

  def rental_item_params
    params.require(:rental_item).permit(:equipment_id, :rental_id, :quantity, :daily_price, :subtotal)
  end
end

class RentalItemsController < ApplicationController
  before_action :set_rental
  def index
    @rental_items = RentalItem.all
  end
  def new
    @rental_item = @rental.rental_items.build
    if params[:query].present?
      @equipment = Equipment.by_name(params[:query])
    else
      @equipment = Equipment.all
    end
  end
  def create
    @rental = Rental.find(params[:rental_id])
    @rental_item = @rental.rental_items.build(rental_item_params)
    if @rental_item.save
      redirect_to new_rental_rental_item_path(@rental), notice: "Rental item was successfully created."
    else
      @equipment = Equipment.all
      render :new
    end
  end

  def destroy
    @rental_item = @rental.rental_items.find(params[:id])
    @rental_item.destroy
    puts "Rental item with ID #{@rental_item.id} has been deleted."
    redirect_to new_rental_rental_item_path(@rental), notice: "Rental item was successfully deleted."
  end

  private

  def set_rental
    @rental = Rental.find(params[:rental_id])
  end

  def rental_item_params
    params.require(:rental_item).permit(:equipment_id, :rental_id, :quantity, :daily_price, :subtotal)
  end
end

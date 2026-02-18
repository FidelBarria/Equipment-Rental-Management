class RentalsController < ApplicationController
  def index
    if params[:status].present?
      @rentals = Rental.by_status(params[:status])
    else
      @rentals = Rental.all
    end
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def new
    @rental = Rental.new
    @rental.event_id = params[:event_id] if params[:event_id].present?
    @rental.start_date = params[:start_date] if params[:start_date].present?
    @rental.end_date = params[:end_date] if params[:end_date].present?
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to rentals_path, notice: "Rental was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @rental = Rental.find(params[:id])

    if @rental.update(rental_status_params)
      redirect_to @rental, notice: "Status update confirmed."
    else
      render :show, status: :unprocessable_entity
    end
  end

  private
  def rental_item_params
  params.require(:rental_item).permit(:rental_id)
  end

  def rental_status_params
    params.require(:rental).permit(:status)
  end
  def rental_params
    params.require(:rental).permit(:client_id, :event_id, :user_id, :start_date, :end_date, :total_value, :status)
  end
end

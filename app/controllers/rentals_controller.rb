class RentalsController < ApplicationController
  def index
    @rentals = Rental.all
    @rentals = @rentals.by_status(params[:status]) if params[:status].present?
    @rentals = @rentals.by_start_date(params[:start_date]) if params[:start_date].present?
  end

  def show
    @rental = Rental.find(params[:id])
  end

  def show_details_print
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
      redirect_to @rental, notice: "Status updated successfully."
    else
      render :show, status: :unprocessable_entity
    end
  end

  def pdf
    @rental = Rental.find(params[:id])
    render pdf: "rental_report_#{@rental.id}",
           template: "rentals/show_details_print",
           layout: "pdf"
  end

  private

  def rental_status_params
    params.require(:rental).permit(:status)
  end

  def rental_params
    params.require(:rental).permit(:client_id, :event_id, :user_id, :start_date, :end_date, :total_value, :status)
  end
end

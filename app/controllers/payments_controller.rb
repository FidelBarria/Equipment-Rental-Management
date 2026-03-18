class PaymentsController < ApplicationController
  before_action :set_rental

  def index
    @payments = @rental.payments
  end

  def new
    @payment = @rental.payments.build
  end

  def create
    @payment = @rental.payments.build(payment_params)
    if @payment.save
      redirect_to @rental, notice: "Payment recorded successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def set_rental
    @rental = Rental.find(params[:rental_id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date, :payment_method, :status)
  end
end

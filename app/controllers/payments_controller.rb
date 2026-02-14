class PaymentsController < ApplicationController
  before_action :set_payment
  def index
    @payments = Payment.all
  end

  def new
    @payment = @rental.payments.build
    puts params.inspect
  end

  def create
    @payment = @rental.payments.build(payment_params)
    if @payment.save
      redirect_to rentals_path, notice: "Payment was successfully created."
    else
      render :new
    end
  end

  private

  def set_payment
    @rental = Rental.find(params[:rental_id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date, :payment_method, :status)
  end
end

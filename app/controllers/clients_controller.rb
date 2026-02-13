class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def edit
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_path, notice: "Client created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.expect(client: [ :name, :cpf_cnpj, :email, :name, :phone, :address ])
  end
end

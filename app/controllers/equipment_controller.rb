class EquipmentController < ApplicationController
  before_action :set_equipment, only: %i[ show edit update destroy ]

  # GET /equipment or /equipment.json
  def index
    if params[:query].present?
      @equipment = Equipment.by_name(params[:query])
    else
      @equipment = Equipment.all
    end
  end

  # GET /equipment/1 or /equipment/1.json
  def show
  end

  # GET /equipment/new
  def new
    @equipment = Equipment.new
    @category = Category.all
  end

  # GET /equipment/1/edit
  def edit
  end

  # POST /equipment or /equipment.json
  def create
    @equipment = Equipment.new(equipment_params)

    respond_to do |format|
      if @equipment.save
        format.html { redirect_to @equipment, notice: "Equipment was successfully created." }
        format.json { render :show, status: :created, location: @equipment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /equipment/1 or /equipment/1.json
  def update
    respond_to do |format|
      if @equipment.update(equipment_params)
        format.html { redirect_to @equipment, notice: "Equipment was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @equipment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /equipment/1 or /equipment/1.json
  def destroy
    @equipment.destroy!

    respond_to do |format|
      format.html { redirect_to equipment_index_path, notice: "Equipment was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipment
      @equipment = Equipment.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def equipment_params
      params.expect(equipment: [ :name, :category_id, :quantity, :daily_value, :statu ])
    end
end

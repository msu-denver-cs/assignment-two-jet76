class CarsPartsController < ApplicationController
  before_action :set_cars_part, only: [:show, :edit, :update, :destroy]

  # GET /cars_parts
  # GET /cars_parts.json
  def index
    @cars_parts = CarsPart.all
  end

  # GET /cars_parts/1
  # GET /cars_parts/1.json
  def show
  end

  # GET /cars_parts/new
  def new
    @cars_part = CarsPart.new
  end

  # GET /cars_parts/1/edit
  def edit
  end

  # POST /cars_parts
  # POST /cars_parts.json
  def create
    @cars_part = CarsPart.new(cars_part_params)

    respond_to do |format|
      if @cars_part.save
        format.html { redirect_to @cars_part, notice: 'Cars part was successfully created.' }
        format.json { render :show, status: :created, location: @cars_part }
      else
        format.html { render :new }
        format.json { render json: @cars_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars_parts/1
  # PATCH/PUT /cars_parts/1.json
  def update
    respond_to do |format|
      if @cars_part.update(cars_part_params)
        format.html { redirect_to @cars_part, notice: 'Cars part was successfully updated.' }
        format.json { render :show, status: :ok, location: @cars_part }
      else
        format.html { render :edit }
        format.json { render json: @cars_part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars_parts/1
  # DELETE /cars_parts/1.json
  def destroy
    @cars_part.destroy
    respond_to do |format|
      format.html { redirect_to cars_parts_url, notice: 'Cars part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cars_part
      @cars_part = CarsPart.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cars_part_params
      params.require(:cars_part).permit(:car_id, :part_id)
    end
end

class VehiclesController < ApplicationController
  def index
    @vehicles = Vehicle.all
  end
  def new
    @vehicle = Vehicle.new
  end
  def create
    @vehicle = Vehicle.create!(vehicle_params)
    redirect_to vehicle_path(@vehicle), notice: "Transport was successfully created"
  end
  def show
    @vehicle = Vehicle.find(params[:id])
    begin
      @films = JSON.parse(@vehicle.films)
    rescue => e
    end
  end
  def edit
    @vehicle = Vehicle.find(params[:id])
  end
  def update
    @vehicle = Vehicle.find(params[:id])
    @vehicle.update(vehicle_params)
    redirect_to vehicle_path(@vehicle), notice: "Transport was successfully created"
  end
  def destroy
    @vehicle = Vehicle.find(params[:id])
    @vehicle.transportations.destroy_all
    @vehicle.destroy
    redirect_to vehicles_path, notice: "Transport was successfully destroyed"
  end
  private
  def vehicle_params
    params.require(:vehicle).permit(:name, :model, :img_url, :manufacturer, :cost_in_credits, :cargo_capacity, :vehicle_class, :max_atmosphering_speed, :crew, :passengers, :length, :films)
  end

end

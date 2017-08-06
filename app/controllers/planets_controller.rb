class PlanetsController < ApplicationController
  def index
    @planets = Homeworld.all
  end
  def new
    @planet = Homeworld.new
  end
  def create
    @planet = Homeworld.find(params[:id])
    @planet.create(planet_params)
    redirect_to planet_path(@planet)
  end
  def show
    @planet = Homeworld.find(params[:id])
  end
  def edit
  end
  def update
  end
  def destroy
  end
  private
  def planet_params
    params.require(:planet).permit(:name, :bio, :img_url, :climate, :terrain, :population, :gravity, :films)
  end
end

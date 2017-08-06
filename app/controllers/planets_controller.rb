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
    @planet = Homeworld.find(params:id)
  end
  def update
    @planet = Homeworld.find(params:id)
    @planet.update(planet_params)
    redirect_to planet_path(@planet)
  end
  def destroy
    @planet = Homeworld.find(params:id)
    @planet.destroy
    redirect_to planets_path
  end
  private
  def planet_params
    params.require(:planet).permit(:name, :bio, :img_url, :climate, :terrain, :population, :gravity, :films)
  end
end

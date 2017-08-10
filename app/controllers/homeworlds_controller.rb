class HomeworldsController < ApplicationController
  def index
    @planets = Homeworld.all
  end

  def new
    @planet = Homeworld.new
  end

  def create
    @planet = Homeworld.create!(planet_params)
    redirect_to homeworld_path(@planet), notice: "Planet was successfully created"
  end

  def show
    @planet = Homeworld.find(params[:id])
    begin
      @films = JSON.parse(@planet.films)
    rescue
    end 
  end

  def edit
    @planet = Homeworld.find(params[:id])
  end

  def update
    @planet = Homeworld.find(params[:id])
    @planet.update(planet_params)
    redirect_to homeworld_path(@planet), notice: "Planet was successfully updated"
  end

  def destroy
    @planet = Homeworld.find(params[:id])
    @planet.destroy
    redirect_to homeworlds_path, notice: "Planet was successfully destroyed"
  end

  private
  def planet_params
    params.require(:homeworld).permit(:name, :bio, :img_url, :climate, :terrain, :population, :gravity, :films)
  end
end

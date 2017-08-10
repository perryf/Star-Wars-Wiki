class SpeciesController < ApplicationController

  def index
    @species = Species.all
  end

  def new
    @species = Species.new
  end

  def create
    @species = Species.create!(species_params)
    redirect_to species_path(@species), notice: "Species was successfully created"
  end

  def show
    @species = Species.find(params[:id])
    begin
      @films = JSON.parse(@species.films)
    rescue => e
    end 
  end

  def edit
    @species = Species.find(params[:id])
  end

  def update
    @species = Species.find(params[:id])
    @species.update(species_params)
    redirect_to species_path(@species), notice: "Species was successfully updated"
  end

  def destroy
    @species = Species.find(params[:id])
    @species.destroy
    redirect_to species_index_path, notice: "Species was successfully destoryed"
  end

  private
  def species_params
    params.require(:species).permit(:name, :designation, :classification, :img_url, :average_height, :average_lifespan, :skin_colors, :language, :films, :homeworld_id)
  end
end

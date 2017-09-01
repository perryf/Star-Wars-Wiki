class CharactersController < ApplicationController
  def index
    @characters = Character.all
    @alliances = Alliance.all
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.create!(character_params)
    # You may want to set up error handling so that if Character fails created (maybe
    # name is nil) that it doesn't error out
    redirect_to characters_path, notice: "Character was successfully created."
  end

  def show
    @character = Character.find(params[:id])
    begin
      @films = JSON.parse(@character.films)
    rescue => e
    end
  end

  def edit
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    @character.update(character_params)
    @character.transportations.destroy_all
    params[:character][:vehicles].each do |vehicle|
      @character.transportations.create(vehicle_id: vehicle)
    end
    # Maybe instead of wiping and recreating all of them, use find_or_create_by
    redirect_to characters_path, notice: "Character was successfully edited."
  end

  def destroy
    @character = Character.find(params[:id])
    @character.transportations.destroy_all
    @character.destroy
    redirect_to characters_path, notice: "Character was successfully destroyed"
  end

  private
  def character_params
    params.require(:character).permit(:name, :classification, :birth_year, :height, :mass, :bio, :catch_phrase, :img_url, :vehicles, :species_id, :homeworld_id, :alliance_id)
  end
end

class CharactersController < ApplicationController
  def index
    @characters = Character.all
    @alliances = Alliance.all
  end

  def new
    @character = Character.new
  end

  def create
    @character = Character.new(character_params)
    @character.save
    redirect_to characters_path, notice: "Character was successfully created."
  end

  def show
    @character = Character.find(params[:id])
  end

  def edit
    @alliances = Alliance.all
    @character = Character.find(params[:id])
  end

  def update
    @character = Character.find(params[:id])
    @character.update(character_params)
    redirect_to characters_path, notice: "Character was successfully edited."
  end

  def destroy
    @character = Character.find(params[:id])
    @character.destroy
    redirect_to characters_path, notice: "Character was successfully destroyed"
  end

  private
  def character_params
    params.require(:character).permit(:name, :species, :classification, :birth_year, :height, :mass, :homeworld, :vehicles, :bio, :catch_phrase, :img_url, :alliance_id)
  end
end

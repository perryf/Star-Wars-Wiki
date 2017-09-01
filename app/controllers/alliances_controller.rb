class AlliancesController < ApplicationController
  # One thing you could do to dry up your code is use before_action to locate an alliance:
  # before_action :find_alliance



  def index
    @alliances = Alliance.all
  end

  def new
    @alliance = Alliance.new
  end

  def create
    @alliance = Alliance.create(alliance_params)
    redirect_to alliance_path(@alliance), notice: "Alliance was successfully created"
  end

  def show
    @alliance = Alliance.find(params[:id])
  end

  def edit
    @alliance = Alliance.find(params[:id])
  end

  def update
    @alliance = Alliance.find(params[:id])
    @alliance.update(alliance_params)
    redirect_to alliance_path(@alliance), notice: "Alliance was successfully updated"
  end

  def destroy
    @alliance = Alliance.find(params[:id])
    @alliance.destroy
    redirect_to alliances_path, notice: "Alliance was successfully destroyed"
  end

  private

  def find_alliance
    if params[:id]
      @alliance = Alliance.find(params[:id])
    end
  end

  def alliance_params
    params.require(:alliance).permit(:name, :img_url)
  end
end

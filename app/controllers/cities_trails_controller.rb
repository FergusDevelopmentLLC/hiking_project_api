class CitiesTrailsController < ApplicationController
  before_action :set_cities_trail, only: [:show, :update, :destroy]

  # GET /cities_trails
  def index
    @cities_trails = CitiesTrail.all

    render json: @cities_trails
  end

  # GET /cities_trails/1
  def show
    render json: @cities_trail
  end

  # POST /cities_trails
  def create

    @cities_trail = CitiesTrail.new(cities_trail_params)
    
    if @cities_trail.save
      render json: @cities_trail, status: :created, location: @cities_trail
    else
      render json: @cities_trail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cities_trails/1
  def update
    if @cities_trail.update(cities_trail_params)
      render json: @cities_trail
    else
      render json: @cities_trail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cities_trails/1
  def destroy
    @cities_trail.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cities_trail
      @cities_trail = CitiesTrail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cities_trail_params
      params.require(:cities_trail).permit(:city_id, :trail_id)
    end
end

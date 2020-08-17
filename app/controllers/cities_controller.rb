class CitiesController < ApplicationController
  before_action :set_city, only: [:show, :update, :destroy]

  # GET /cities
  def index
    @cities = City.all

    render json: @cities
  end

  # GET /cities/1
  def show
    #render the city with the associated trails
    render :json => @city.to_json(include: [:trails])
  end

  # POST /cities
  def create
    @city = City.new(city_params)

    if @city.save
      render json: @city, status: :created, location: @city
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cities/1
  def update
    if @city.update(city_params)
      render json: @city
    else
      render json: @city.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cities/1
  def destroy
    @city.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_city
      if params[:slug] && params[:state_abbrev]
        @city = City.where('lower(slug) = ? and lower(state_abbrev) = ?', params[:slug], params[:state_abbrev]).first 
      else
        @city = City.find(params[:id])
      end
    end

    # Only allow a trusted parameter "white list" through.
    def city_params
      params.require(:city).permit(:name, :state, :country, :latitude, :longitude, :timezone, :population, :slug, :state_abbrev)
    end
end

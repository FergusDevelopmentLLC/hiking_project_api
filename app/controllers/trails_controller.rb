class TrailsController < ApplicationController
  before_action :set_trail, only: [:show, :update, :destroy]

  # GET /trails
  def index
    @trails = Trail.all
    render json: @trails
  end

  # GET /trails/1
  def show
    render json: @trail
  end

  # POST /trails
  def create
    @trail = Trail.new(trail_params)

    if @trail.save
      render json: @trail, status: :created, location: @trail
    else
      render json: @trail.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trails/1
  def update
    if @trail.update(trail_params)
      render json: @trail
    else
      render json: @trail.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trails/1
  def destroy
    @trail.destroy
  end

  def for_city
    
    @trails = []

    # city = City.where('lower(slug) = ?', params[:slug]).first
    city = City.where(["lower(slug) = ? and lower(state_abbrev) = ?", params[:slug], params[:state_abbrev]]).first
    
    if city
    
      # TODO: redo this better
      city_trails = if params[:limit]
                      CitiesTrail.where('city_id = ?', city.id).order({ distance: :asc }).limit(params[:limit].to_i)
                    else
                      CitiesTrail.where('city_id = ?', city.id).order({ distance: :asc })
                    end

      city_trails.each {|city_trail|
        trail = Trail.find(city_trail.trail_id)
        trail_hash = trail.attributes
        trail_hash['distance_meters'] = city_trail.distance
        trail_hash['distance_miles'] = city_trail.distance * 0.000621371
        @trails.push(trail_hash)
      }
    end

    render json: @trails
  end

  def for_coords
    all_trails = Scraper.get_trails_from_api(latitude: params[:latitude], longitude: params[:longitude], max_distance: params[:max_distance], max_results: 500)
    all_trails_array = []
    
    all_trails.each {|trail_hash|
      distance = Geodesics.distance(params[:latitude].to_f, params[:longitude].to_f, trail_hash[:latitude].to_f, trail_hash[:longitude].to_f)
      trail_hash[:distance_meters] = distance
      trail_hash[:distance_miles] = distance * 0.000621371
      all_trails_array.push(trail_hash)
    }

    all_trails_array = all_trails_array.sort_by { |trail| trail[:distance_meters] }
    @trails = all_trails_array[0 ... params[:max_results].to_i]
    render json: @trails
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail
      @trail = Trail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trail_params
      params.require(:trail).permit(:hiking_project_id, :name, :trail_type, :summary, :difficulty, :stars, :starVotes, :location, :url, :imgSqSmall, :imgSmall, :imgSmallMed, :imgMedium, :length, :ascent, :descent, :high, :low, :longitude, :latitude, :conditionStatus, :conditionDetails, :conditionDate, :features, :overview, :description)
    end
end

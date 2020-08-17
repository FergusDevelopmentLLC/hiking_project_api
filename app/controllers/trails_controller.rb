class TrailsController < ApplicationController
  before_action :set_trail, only: [:show, :update, :destroy]

  # GET /trails
  def index
    @trails = Trail.all
    render json: @trails
  end

  # GET /trails/1
  def show
    # render json: @trail
    #render the trail with the associated cities
    render :json => @trail.to_json(include: [:cities])
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

  def for_city#TODO: shouldnt this be cities/1/trails
    
    @trails = []

    city = City.where(["lower(slug) = ? and lower(state_abbrev) = ?", params[:slug], params[:state_abbrev]]).first

    if city
      
      city_trails = if params[:limit]
                      CitiesTrail.where('city_id = ?', city.id).order({ distance: :asc }).limit(params[:limit].to_i)
                    else
                      CitiesTrail.where('city_id = ?', city.id).order({ distance: :asc })
                    end
    
      city_trails.each {|city_trail|
        trail = Trail.find_by(id: city_trail.trail_id)
        if trail
          trail_hash = trail.attributes
          @trails.push(trail_hash)
        end
      }

    end

    render json: @trails
  end

  def for_coords

    raw_trails = Scraper.get_trails_from_api(latitude: params[:latitude], longitude: params[:longitude], max_distance: params[:max_distance], max_results: params[:max_results])
    
    @trails = []
    
    #save each trail to the local db
    raw_trails.each do |trail|
      t = Trail.find_or_create_by(hiking_project_id: trail[:hiking_project_id])
      # https://stackoverflow.com/questions/3669801/dry-way-to-assign-hash-values-to-an-object
      t.assign_attributes(trail)
      t.save()
      @trails.push(t)
    end
    
    render json: @trails
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trail
      @trail = Trail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trail_params
      params.require(:trail).permit(:id, :hiking_project_id, :name, :trail_type, :summary, :difficulty, :stars, :starVotes, :location, :url, :imgSqSmall, :imgSmall, :imgSmallMed, :imgMedium, :length, :ascent, :descent, :high, :low, :longitude, :latitude, :conditionStatus, :conditionDetails, :conditionDate, :features, :overview, :description, :detail_views)
    end
end

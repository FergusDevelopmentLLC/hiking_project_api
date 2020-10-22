class TrailsController < ApplicationController
  before_action :set_trail, only: [:show, :update, :destroy]

  # GET /trails
  def index
    @trails = null
    if params[:city_id]
      city = City.find_by(id: params[:city_id])
      @trails = city.trails
    else
      #limit display of all trails to 100
      @trails = Trail.all.limit(100).order("id asc")
    end
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

  def for_cityslug_state
    
    city = City.where(["lower(slug) = ? and lower(state_abbrev) = ?", params[:slug], params[:state_abbrev]]).first

    @trails = city.trails if city
    
    render json: @trails
  end

  def for_coords

    raw_trails = Scraper.get_trails_from_api(latitude: params[:latitude], longitude: params[:longitude], max_distance: params[:max_distance], max_results: params[:max_results])
    puts "raw_trails"
    puts raw_trails
    
    @trails = []
    
    #save each trail to the local db
    raw_trails.each do |trail|
      
      puts "trail"
      puts trail

      t = Trail.find_or_create_by(hiking_project_id: trail[:hiking_project_id])
      puts "t"
      puts t

      # https://stackoverflow.com/questions/3669801/dry-way-to-assign-hash-values-to-an-object
      t.assign_attributes(trail)
      puts "t"
      puts t

      t.save()
      puts "t"
      puts t
      
      @trails.push(t)
    end
    
    puts "@trails"
    puts trails

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

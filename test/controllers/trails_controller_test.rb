require 'test_helper'

class TrailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @trail = trails(:one)
  end

  test "should get index" do
    get trails_url, as: :json
    assert_response :success
  end

  test "should create trail" do
    assert_difference('Trail.count') do
      post trails_url, params: { trail: { ascent: @trail.ascent, conditionDate: @trail.conditionDate, conditionDetails: @trail.conditionDetails, conditionStatus: @trail.conditionStatus, descent: @trail.descent, description: @trail.description, difficulty: @trail.difficulty, features: @trail.features, high: @trail.high, imgMedium: @trail.imgMedium, imgSmall: @trail.imgSmall, imgSmallMed: @trail.imgSmallMed, imgSqSmall: @trail.imgSqSmall, latitude: @trail.latitude, length: @trail.length, location: @trail.location, longitude: @trail.longitude, low: @trail.low, name: @trail.name, overview: @trail.overview, starVotes: @trail.starVotes, stars: @trail.stars, summary: @trail.summary, trail_type: @trail.trail_type, url: @trail.url } }, as: :json
    end

    assert_response 201
  end

  test "should show trail" do
    get trail_url(@trail), as: :json
    assert_response :success
  end

  test "should update trail" do
    patch trail_url(@trail), params: { trail: { ascent: @trail.ascent, conditionDate: @trail.conditionDate, conditionDetails: @trail.conditionDetails, conditionStatus: @trail.conditionStatus, descent: @trail.descent, description: @trail.description, difficulty: @trail.difficulty, features: @trail.features, high: @trail.high, imgMedium: @trail.imgMedium, imgSmall: @trail.imgSmall, imgSmallMed: @trail.imgSmallMed, imgSqSmall: @trail.imgSqSmall, latitude: @trail.latitude, length: @trail.length, location: @trail.location, longitude: @trail.longitude, low: @trail.low, name: @trail.name, overview: @trail.overview, starVotes: @trail.starVotes, stars: @trail.stars, summary: @trail.summary, trail_type: @trail.trail_type, url: @trail.url } }, as: :json
    assert_response 200
  end

  test "should destroy trail" do
    assert_difference('Trail.count', -1) do
      delete trail_url(@trail), as: :json
    end

    assert_response 204
  end
end

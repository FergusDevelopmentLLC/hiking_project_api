require 'test_helper'

class CitiesTrailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cities_trail = cities_trails(:one)
  end

  test "should get index" do
    get cities_trails_url, as: :json
    assert_response :success
  end

  test "should create cities_trail" do
    assert_difference('CitiesTrail.count') do
      post cities_trails_url, params: { cities_trail: { city_id: @cities_trail.city_id, trail_id: @cities_trail.trail_id } }, as: :json
    end

    assert_response 201
  end

  test "should show cities_trail" do
    get cities_trail_url(@cities_trail), as: :json
    assert_response :success
  end

  test "should update cities_trail" do
    patch cities_trail_url(@cities_trail), params: { cities_trail: { city_id: @cities_trail.city_id, trail_id: @cities_trail.trail_id } }, as: :json
    assert_response 200
  end

  test "should destroy cities_trail" do
    assert_difference('CitiesTrail.count', -1) do
      delete cities_trail_url(@cities_trail), as: :json
    end

    assert_response 204
  end
end

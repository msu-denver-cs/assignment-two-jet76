require 'test_helper'

class CarsPartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cars_part = cars_parts(:one)
  end

  test "should get index" do
    get cars_parts_url
    assert_response :success
  end

  test "should get new" do
    get new_cars_part_url
    assert_response :success
  end

  test "should create cars_part" do
    assert_difference('CarsPart.count') do
      post cars_parts_url, params: { cars_part: { car_id: @cars_part.car_id, part_id: @cars_part.part_id } }
    end

    assert_redirected_to cars_part_url(CarsPart.last)
  end

  test "should show cars_part" do
    get cars_part_url(@cars_part)
    assert_response :success
  end

  test "should get edit" do
    get edit_cars_part_url(@cars_part)
    assert_response :success
  end

  test "should update cars_part" do
    patch cars_part_url(@cars_part), params: { cars_part: { car_id: @cars_part.car_id, part_id: @cars_part.part_id } }
    assert_redirected_to cars_part_url(@cars_part)
  end

  test "should destroy cars_part" do
    assert_difference('CarsPart.count', -1) do
      delete cars_part_url(@cars_part)
    end

    assert_redirected_to cars_parts_url
  end
end

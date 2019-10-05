require 'test_helper'

class CarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @car = cars(:one)
  end

  test "should get index" do
    get cars_url
    assert_response :success
  end

  test "should get new" do
    get new_car_url
    assert_response :success
  end

  # Modified to create new car
  test "should create car" do
    assert_difference('Car.count') do
      post cars_url, params: { car: { make_id: makes(:one).id, model: cars(:one).model, vin: "ABCD1234", part_ids: [parts(:one).id] } }
    end

    assert_redirected_to car_url(Car.last)
  end

  # search shouldn't find missing model
  test "shouldn't find missing model" do
    assert Car.where("model like ?", "Turnip").length == 0 # .length is the number of results returned
  end

  # search shouldn't find missing vin
  test "shouldn't find missing vin" do
    assert Car.where("vin like ?", "QQQ666").length == 0 # .length is the number of results returned
  end

  # search should find model fixture
  test "should find model from fixture" do
    assert Car.where("model like ?", "DeLorean").length == 1 # .length is the number of results returned
  end

  # search should find vin fixture
  test "should find vin from fixture" do
    assert Car.where("vin like ?", "ABC123").length == 1 # .length is the number of results returned
  end

  # search always returns 200 OK
  test "searches always return 200" do
    get search_cars_url, params: {query: "T-Rex"}
    assert_equal 200, status
  end

  # should find DeLorean (model)
  test "should find DeLorean" do
    get search_cars_url, params: {query: "DeLorean"}
    assert_select 'td', 'DeLorean'
  end

  # should find ABC123 (vin)
  test "should find ABC123" do
    get search_cars_url, params: {query: "ABC123"}
    assert_select 'td', 'ABC123'
  end

  # shouldn't find Porg (model)
  test "shouldn't find Porg" do
    get search_cars_url, params: {query: "Porg"}
    assert_select 'td', false
  end

  # shouldn't find QQQ666 (vin)
  test "shouldn't find QQQ666" do
    get search_cars_url, params: {query: "QQQ666"}
    assert_select 'td', false
  end

  test "should show car" do
    get car_url(@car)
    assert_response :success
  end

  test "should get edit" do
    get edit_car_url(@car)
    assert_response :success
  end

  # modify update car to test updating of car
  test "should update car" do
    patch car_url(@car), params: { car: { make_id: makes(:one).id, model: "DeLorean 2", vin: "A1B2", part_ids: parts(:one).id } }
    assert_redirected_to car_url(@car)
  end

  test "should destroy car" do
    assert_difference('Car.count', -1) do
      delete car_url(@car)
    end

    assert_redirected_to cars_url
  end
end

require 'test_helper'

class MakesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @make = makes(:one)
  end

  test "should get index" do
    get makes_url
    assert_response :success
  end

  test "should get new" do
    get new_make_url
    assert_response :success
  end

  # modified to create new make
  test "should create make" do
    assert_difference('Make.count') do
      post makes_url, params: { make: { country: "Germany", name: "Volkswagen" } }
    end

    assert_redirected_to make_url(Make.last)
  end

  # search shouldn't find missing make
  test "shouldn't find missing make" do
    assert Make.where("name like ?", "Kia").length == 0 # .length is the number of results returned
  end

  # search should find make fixture
  test "should find make from fixture" do
    assert Make.where("name like ?", "Porsche").length == 1 # .length is the number of results returned
  end

  # search always returns 200 OK
  test "searches always return 200" do
    get search_makes_url, params: {query: "Tuba"}
    assert_equal 200, status
  end

  # should find DMC
  test "should find DMC" do
    get search_makes_url, params: {query: "DMC"}
    assert_select 'td', 'DMC'
  end

  # shouldn't find Kia
  test "shouldn't find Warp Core" do
    get search_makes_url, params: {query: "Kia"}
    assert_select 'td', false
  end
  
  test "should show make" do
    get make_url(@make)
    assert_response :success
  end

  test "should get edit" do
    get edit_make_url(@make)
    assert_response :success
  end

  test "should update make" do
    patch make_url(@make), params: { make: { country: @make.country, name: @make.name } }
    assert_redirected_to make_url(@make)
  end

  test "should destroy make" do
    assert_difference('Make.count', -1) do
      delete make_url(@make)
    end

    assert_redirected_to makes_url
  end
end

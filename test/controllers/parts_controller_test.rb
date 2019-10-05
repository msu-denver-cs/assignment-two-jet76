require 'test_helper'

class PartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @part = parts(:one)
  end

  test "should get index" do
    get parts_url
    assert_response :success
  end

  test "should get new" do
    get new_part_url
    assert_response :success
  end

  # Modified to create new part
  test "should create part" do
    assert_difference('Part.count') do
      post parts_url, params: { part: { name: "Warp Core" } }
    end

    assert_redirected_to part_url(Part.last)
  end

  # search shouldn't find missing part
  test "shouldn't find missing part" do
    assert Part.where("name like ?", "Trash Panda").length == 0 # .length is the number of results returned
  end

  # search should find part fixture
  test "should find part from fixture" do
    assert Part.where("name like ?", "Flux Capacitor").length == 1 # .length is the number of results returned
  end

  # search always returns 200 OK
  test "searches always return 200" do
    get search_parts_url, params: {query: "Velociraptor"}
    assert_equal 200, status
  end

  # should find Mr. Fusion
  test "should find Mr. Fusion" do
    get search_parts_url, params: {query: "Mr. Fusion"}
    assert_select 'td', 'Mr. Fusion'
  end

  # shouldn't find Warp Core
  test "shouldn't find Warp Core" do
    get search_parts_url, params: {query: "Warp Core"}
    assert_select 'td', false
  end

  test "should show part" do
    get part_url(@part)
    assert_response :success
  end

  test "should get edit" do
    get edit_part_url(@part)
    assert_response :success
  end

  test "should update part" do
    patch part_url(@part), params: { part: { name: @part.name } }
    assert_redirected_to part_url(@part)
  end

  test "should destroy part" do
    assert_difference('Part.count', -1) do
      delete part_url(@part)
    end

    assert_redirected_to parts_url
  end
end

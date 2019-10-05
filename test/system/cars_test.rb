require "application_system_test_case"

class CarsTest < ApplicationSystemTestCase
  setup do
    @car = cars(:one)
  end

  test "visiting the index" do
    visit cars_url
    assert_selector "h1", text: "Cars"
    assert_selector "td", text: cars(:one).make # added to test presence of make in table
    assert_selector "td", text: cars(:one).model # added to test presence of model in table
    assert_selector "td", text: cars(:one).vin # added to test presence of vin in table
  end

  # test missing model in search
  test "missing model in search" do
    visit cars_url
    fill_in "query", with: "Cucumber"
    click_on "Search"
    refute_selector "td"
  end

  # test found model in search
  test "found model in search" do
    visit cars_url
    fill_in "query", with: "DeLorean"
    click_on "Search"
    assert_selector "td", text: "DeLorean"
  end

  # test missing vin in search
  test "missing vin in search" do
    visit cars_url
    fill_in "query", with: "QQQ666"
    click_on "Search"
    refute_selector "td"
  end

  # test found vin in search
  test "found vin in search" do
    visit cars_url
    fill_in "query", with: "ABC123"
    click_on "Search"
    assert_selector "td", text: "ABC123"
  end

  test "creating a Car" do
    visit cars_url
    click_on "New Car"

    select "DMC", :from => "car_make_id" # modified to test dropdown
    fill_in "Model", with: @car.model
    fill_in "Vin", with: "YYY" # modified to update to new vin because vin must be unique
    check "Mr. Fusion" # added to update because validation requires parts presence
    click_on "Create Car"

    assert_text "Car was successfully created"
    click_on "Back"
  end

  test "updating a Car" do
    visit cars_url
    click_on "Edit", match: :first

    select "DMC", :from => "car_make_id" # modified to test dropdown
    fill_in "Model", with: @car.model
    fill_in "Vin", with: "ZZZ" # modified to update to new vin because vin must be unique
    click_on "Update Car"

    assert_text "Car was successfully updated"
    click_on "Back"
  end

  test "destroying a Car" do
    visit cars_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Car was successfully destroyed"
  end
end

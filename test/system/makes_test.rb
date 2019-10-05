require "application_system_test_case"

class MakesTest < ApplicationSystemTestCase
  setup do
    @make = makes(:one)
  end

  test "visiting the index" do
    visit makes_url
    assert_selector "h1", text: "Makes"
    assert_selector "td", text: makes(:one).name # added to test presence of name in table
    assert_selector "td", text: makes(:one).country # added to test presence of country in table
  end

  # test missing make in search
  test "missing make in search" do
    visit makes_url
    fill_in "query", with: "Kia"
    click_on "Search"
    refute_selector "td"
  end

  # test found make in search
  test "found make in search" do
    visit makes_url
    fill_in "query", with: "DMC"
    click_on "Search"
    assert_selector "td", text: "DMC"
  end

  test "creating a Make" do
    visit makes_url
    click_on "New Make"

    fill_in "Country", with: @make.country
    fill_in "Name", with: "Toyota" # modified to update part name because validation requires unique name
    click_on "Create Make"

    assert_text "Make was successfully created"
    click_on "Back"
  end

  test "updating a Make" do
    visit makes_url
    click_on "Edit", match: :first

    fill_in "Country", with: @make.country
    fill_in "Name", with: "Kia" # modified to update make name because validation requires unique name 
    click_on "Update Make"

    assert_text "Make was successfully updated"
    click_on "Back"
  end

  test "destroying a Make" do
    visit makes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Make was successfully destroyed"
  end
end

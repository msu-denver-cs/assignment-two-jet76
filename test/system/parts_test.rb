require "application_system_test_case"

class PartsTest < ApplicationSystemTestCase
  setup do
    @part = parts(:one)
  end

  test "visiting the index" do
    visit parts_url
    assert_selector "h1", text: "Parts"
    assert_selector "td", text: parts(:one).name # added to test presence of part in table
  end

  # test missing part in search
  test "missing part in search" do
    visit parts_url
    fill_in "query", with: "Velociraptor"
    click_on "Search"
    refute_selector "td"
  end

  # test found part in search
  test "found part in search" do
    visit parts_url
    fill_in "query", with: "Flux Capacitor"
    click_on "Search"
    assert_selector "td", text: "Flux Capacitor"
  end

  test "creating a Part" do
    visit parts_url
    click_on "New Part"

    fill_in "Name", with: "New Part Name" # modified to update part name because validation requires unique name
    click_on "Create Part"

    assert_text "Part was successfully created"
    click_on "Back"
  end

  test "updating a Part" do
    visit parts_url
    click_on "Edit", match: :first

    fill_in "Name", with: "Updated Part Name" # modified to update part name because validation requires unique name
    click_on "Update Part"

    assert_text "Part was successfully updated"
    click_on "Back"
  end

  test "destroying a Part" do
    visit parts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Part was successfully destroyed"
  end
end

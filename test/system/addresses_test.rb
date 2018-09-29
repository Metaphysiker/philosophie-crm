require "application_system_test_case"

class AddressesTest < ApplicationSystemTestCase
  setup do
    @address = addresses(:one)
  end

  test "visiting the index" do
    visit addresses_url
    assert_selector "h1", text: "Addresses"
  end

  test "creating a Address" do
    visit addresses_url
    click_on "New Address"

    fill_in "Company", with: @address.company
    fill_in "Country", with: @address.country
    fill_in "Firstname", with: @address.firstname
    fill_in "Form Of Address", with: @address.form_of_address
    fill_in "Lastname", with: @address.lastname
    fill_in "Location", with: @address.location
    fill_in "Plz", with: @address.plz
    fill_in "Street", with: @address.street
    click_on "Create Address"

    assert_text "Address was successfully created"
    click_on "Back"
  end

  test "updating a Address" do
    visit addresses_url
    click_on "Edit", match: :first

    fill_in "Company", with: @address.company
    fill_in "Country", with: @address.country
    fill_in "Firstname", with: @address.firstname
    fill_in "Form Of Address", with: @address.form_of_address
    fill_in "Lastname", with: @address.lastname
    fill_in "Location", with: @address.location
    fill_in "Plz", with: @address.plz
    fill_in "Street", with: @address.street
    click_on "Update Address"

    assert_text "Address was successfully updated"
    click_on "Back"
  end

  test "destroying a Address" do
    visit addresses_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Address was successfully destroyed"
  end
end

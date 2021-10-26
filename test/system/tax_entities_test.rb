require "application_system_test_case"

class TaxEntitiesTest < ApplicationSystemTestCase
  setup do
    @tax_entity = tax_entities(:one)
  end

  test "visiting the index" do
    visit tax_entities_url
    assert_selector "h1", text: "Tax Entities"
  end

  test "creating a Tax entity" do
    visit tax_entities_url
    click_on "New Tax Entity"

    fill_in "Address", with: @tax_entity.address
    fill_in "City", with: @tax_entity.city
    fill_in "Ein", with: @tax_entity.ein
    fill_in "Flags", with: @tax_entity.flags
    fill_in "Name", with: @tax_entity.name
    fill_in "Post code", with: @tax_entity.post_code
    fill_in "State", with: @tax_entity.state
    click_on "Create Tax entity"

    assert_text "Tax entity was successfully created"
    click_on "Back"
  end

  test "updating a Tax entity" do
    visit tax_entities_url
    click_on "Edit", match: :first

    fill_in "Address", with: @tax_entity.address
    fill_in "City", with: @tax_entity.city
    fill_in "Ein", with: @tax_entity.ein
    fill_in "Flags", with: @tax_entity.flags
    fill_in "Name", with: @tax_entity.name
    fill_in "Post code", with: @tax_entity.post_code
    fill_in "State", with: @tax_entity.state
    click_on "Update Tax entity"

    assert_text "Tax entity was successfully updated"
    click_on "Back"
  end

  test "destroying a Tax entity" do
    visit tax_entities_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tax entity was successfully destroyed"
  end
end

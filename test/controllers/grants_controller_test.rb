require "test_helper"
class GrantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tax_entity_a = FactoryBot.create(:tax_entity)
    @tax_entity_b = FactoryBot.create(:tax_entity)
    @grant = FactoryBot.create(:grant, from: @tax_entity_a, to: @tax_entity_b)
    @new_grant = FactoryBot.build(:grant, from: @tax_entity_a, to: @tax_entity_b)
  end

  test "should get index" do
    get grants_url
    assert_response :success
  end

  test "should get new" do
    get new_grant_url
    assert_response :success
  end

  test "should create grant" do
    assert_difference('Grant.count') do
      post grants_url, params: { grant: { amount: @new_grant.amount, from_ein: @new_grant.from.ein, to_ein: @new_grant.to.ein } }
    end

    assert_redirected_to grant_url(Grant.last)
  end

  test "should show grant" do
    get grant_url(@grant)
    assert_response :success
  end

  test "should get edit" do
    get edit_grant_url(@grant)
    assert_response :success
  end

  test "should update grant" do
    patch grant_url(@grant), params: { grant: { amount: @grant.amount, from_ein: @grant.from.ein, to_ein: @grant.to.ein } }
    assert_redirected_to grant_url(@grant)
  end

  test "should destroy grant" do
    assert_difference('Grant.count', -1) do
      delete grant_url(@grant)
    end

    assert_redirected_to grants_url
  end
end

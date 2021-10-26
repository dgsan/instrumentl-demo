require "test_helper"

class TaxEntitiesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tax_entity = FactoryBot.create(:tax_entity)
    @new_tax_entity = FactoryBot.build(:tax_entity)
  end

  test "should get index" do
    get tax_entities_url
    assert_response :success
  end

  test "should get new" do
    get new_tax_entity_url
    assert_response :success
  end

  test "should create tax_entity" do
    assert_difference('TaxEntity.count') do
      post tax_entities_url, params: { tax_entity: {
        address: @new_tax_entity.address,
        city: @new_tax_entity.city,
        ein: @new_tax_entity.ein,
        flags: @new_tax_entity.flags,
        name: @new_tax_entity.name,
        post_code: @new_tax_entity.post_code,
        state: @new_tax_entity.state } }
    end

    assert_redirected_to tax_entity_url(TaxEntity.find_by(
      address: @new_tax_entity.address,
      city: @new_tax_entity.city,
      ein: @new_tax_entity.ein,
      flags: @new_tax_entity.flags,
      name: @new_tax_entity.name,
      post_code: @new_tax_entity.post_code,
      state: @new_tax_entity.state
    ))
  end

  test "should show tax_entity" do
    get tax_entity_url(@tax_entity)
    assert_response :success
  end

  test "should get edit" do
    get edit_tax_entity_url(@tax_entity)
    assert_response :success
  end

  test "should update tax_entity" do
    patch tax_entity_url(@tax_entity), params: { tax_entity: { address: @tax_entity.address, city: @tax_entity.city, ein: @tax_entity.ein, flags: @tax_entity.flags, name: @tax_entity.name, post_code: @tax_entity.post_code, state: @tax_entity.state } }
    assert_redirected_to tax_entity_url(@tax_entity)
  end

  test "should destroy tax_entity" do
    assert_difference('TaxEntity.count', -1) do
      delete tax_entity_url(@tax_entity)
    end

    assert_redirected_to tax_entities_url
  end
end

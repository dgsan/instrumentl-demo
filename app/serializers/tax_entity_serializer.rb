class TaxEntitySerializer
  include JSONAPI::Serializer

  set_id do |tax_entity, _params|
    tax_entity.ein
  end

  attributes :ein, :name, :address, :city, :state, :post_code
  has_many :granted, record_type: :grant, serializer: GrantSerializer, if: Proc.new { |record, params| record.grants }
end

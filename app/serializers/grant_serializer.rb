class GrantSerializer
  include JSONAPI::Serializer
  attributes :year, :amount
  belongs_to :to, record_type: :tax_entity, serializer: TaxEntitySerializer, id_method_name: :to_ein
end

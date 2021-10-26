json.extract! tax_entity, :id, :ein, :name, :address, :city, :state, :post_code, :flags, :created_at, :updated_at
json.url tax_entity_url(tax_entity, format: :json)

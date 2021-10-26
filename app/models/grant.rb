class Grant < ApplicationRecord
  belongs_to :from, class_name: 'TaxEntity', foreign_key: :from_ein, primary_key: :ein
  belongs_to :to, class_name: 'TaxEntity', foreign_key: :to_ein, primary_key: :ein
end

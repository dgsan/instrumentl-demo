FactoryBot.define do
  factory :grant do
    from factory: :tax_entity
    to factory: :tax_entity
    sequence(:amount) { |n| n }
  end
end

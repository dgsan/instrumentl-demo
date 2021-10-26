FactoryBot.define do
  factory :tax_entity do
    sequence(:id) { |n| n }
    sequence(:ein) { |n| "EIN#{n}" }
    sequence(:name) { |n| "Name#{n}" }
    sequence(:address) { |n| "Address#{n}" }
    sequence(:city) { |n| "City#{n}" }
    sequence(:state) { |n| "State#{n}" }
    sequence(:post_code) { |n| "Code#{n}" }
  end
end

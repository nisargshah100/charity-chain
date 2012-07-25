FactoryGirl.define do
  factory :payment do
    amount    1000
    last_four "5432"
    card_type "Visa"
  end
end
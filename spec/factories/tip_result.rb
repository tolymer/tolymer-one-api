FactoryBot.define do
  factory :tip_result do
    participant
    tip
    score { 50 }
  end
end

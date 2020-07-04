FactoryBot.define do
  factory :comment do
    user
    article

    body {'Hello again'}
  end
end
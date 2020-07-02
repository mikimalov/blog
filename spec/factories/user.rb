FactoryBot.define do
  factory :user do
    email {'testing@test.com'}
    name {'John'}
    password {'123456'}
    password_confirmation {'123456'}
  end
end
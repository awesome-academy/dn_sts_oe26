FactoryBot.define do
  password = "123456"
  factory :user do
    name {Faker::Name.name}
    sequence(:email){|n| "#{n*100}#{Faker::Internet.email}"}
    password {password}
    password_confirmation {password}
    birthday  {Date.new 1998, 11, 07}
    company {Faker::Company.bs}
    university {Faker::University.name}
    address {Faker::Address.street_address}
    role {'trainee'}
    gender {'male'}
    joined {false}
    activated {true}
    deleted {false}
  end

  factory :admin, class: User do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password {password}
    password_confirmation {password}
    birthday  {Date.new 1998, 11, 07}
    company {Faker::Company.bs}
    university {Faker::University.name}
    address {Faker::Address.street_address}
    role {'trainee'}
    gender {'male'}
    joined {false}
    activated {true}
    deleted {false}
  end
end

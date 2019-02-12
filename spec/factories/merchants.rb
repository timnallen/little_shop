FactoryBot.define do
  factory :merchant, class: User do
    name {"Jim"}
    email {"jim@tim.com"}
    password {"IAmJim"}
    address {"123 Fake"}
    city {"Ventura"}
    state {"CA"}
    zipcode {"11111"}
    role {1}
  end
end

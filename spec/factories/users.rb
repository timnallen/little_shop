FactoryBot.define do
  factory :user do
    name {"Tim"}
    email {"tim@tim.com"}
    password {"IAmTim"}
    address {"123 Test"}
    city {"Somewhere"}
    state {"CA"}
    zipcode {"99999"}
  end
end

FactoryBot.define do
  factory :admin, class: User do
    name {"Ian"}
    email {"ian@tim.com"}
    password {"IAmJim"}
    address {"123 Admin Street"}
    city {"Washington"}
    state {"DC"}
    zipcode {"11112"}
    role {2}
  end
end

FactoryBot.define do
  factory :user, class: User do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    sequence(:password) { "password" }
    sequence(:name) { |n| "User Name #{n}" }
    sequence(:address) { |n| "Address #{n}" }
    sequence(:city) { |n| "City #{n}" }
    sequence(:state) { |n| "A#{n}" }
    sequence(:zipcode) { |n| "#{n}0000" }
    role { 0 }
    disabled { false }
  end
  factory :inactive_user, parent: :user do
    sequence(:name) { |n| "Inactive User Name #{n}" }
    sequence(:email) { |n| "inactive_user_#{n}@gmail.com" }
    disabled { true }
  end

  factory :merchant, parent: :user do
    sequence(:email) { |n| "merchant_#{n}@gmail.com" }
    sequence(:name) { |n| "Merchant Name #{n}" }
    role { 1 }
    disabled { false }
  end
  factory :inactive_merchant, parent: :user do
    sequence(:email) { |n| "inactive_merchant_#{n}@gmail.com" }
    sequence(:name) { |n| "Inactive Merchant Name #{n}" }
    role { 1 }
    disabled { true }
  end

  factory :admin, parent: :user do
    sequence(:email) { |n| "admin_#{n}@gmail.com" }
    sequence(:name) { |n| "Admin Name #{n}" }
    role { 2 }
    disabled { false }
  end
end

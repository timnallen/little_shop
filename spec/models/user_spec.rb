require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :email}
    it {should validate_presence_of :address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zipcode}
    it {should validate_presence_of :role}

    it {should validate_uniqueness_of(:email)}

    it {should validate_numericality_of(:zipcode)
        .only_integer
        }


    it {should validate_length_of(:name)
        .is_at_least(1)
    }

    it {should validate_length_of(:email)
        .is_at_least(1)
    }

    it {should validate_length_of(:address)
        .is_at_least(1)
    }

    it {should validate_length_of(:city)
        .is_at_least(1)
    }

    it {should validate_confirmation_of(:password)}

  end
  describe 'relationships' do
    it {should have_many :orders}
    it {should have_many :items}
  end
  describe 'instance methods' do
  end
  describe 'class methods' do
  end
end

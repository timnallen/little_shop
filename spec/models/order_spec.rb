require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'validations' do
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should belong_to :user}
  end

  describe 'instance methods' do
  end

  describe 'class methods' do
  end
end

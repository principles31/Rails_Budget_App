require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create!(name: 'Tom', email: 'Tom@gmail.com', password: 'password123',
                         password_confirmation: 'password123')
  end
  context 'validations' do
    it 'is valid with valid attributes' do
      @user.save
      expect(@user).to be_valid
    end
    it 'Invalid without a name' do
      @user.name = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'Invalid without email' do
      @user.email = nil
      @user.save
      expect(@user).to_not be_valid
    end

    it 'Invalid without password' do
      @user.password = nil
      @user.save
      expect(@user).to_not be_valid
    end
  end
  context 'associations' do
    it 'has many transactions' do
      assc = described_class.reflect_on_association(:transactions)
      expect(assc.macro).to eq :has_many
    end
    it 'has many categories' do
      assc = described_class.reflect_on_association(:categories)
      expect(assc.macro).to eq :has_many
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Test secure password' do
  # http://api.rubyonrails.org/classes/ActiveModel/SecurePassword/ClassMethods.html
    before :each do
      @user = User.new(
        name: "david", 
        email: "david@test.com", 
        password: '', 
        password_confirmation: 'nomatch'
      )
    end

    it 'save user with no password' do
      @user.save
      # can't be blank
      expect(@user.errors[:password].size).to eq(1)
    end

    it 'save user with nomatch passowrd' do
      @user.password = 'mUc3m00RsqyRe'
      @user.save
      # doesn't match Password
      expect(@user.errors[:password_confirmation].size).to eq(1)
    end

    it 'save user with match password' do
      @user.password = 'mUc3m00RsqyRe'
      @user.password_confirmation = 'mUc3m00RsqyRe'
      expect(@user.save).to be true
    end

    context 'after save user, authenticate' do
      before :each do
        @user.password = 'mUc3m00RsqyRe'
        @user.password_confirmation = 'mUc3m00RsqyRe'
        @user.save
      end

      it 'authenticate with no right password' do
        expect(@user.authenticate('notright') ).to be false
      end

      it 'authenticate with right password' do
        expect(@user.authenticate('mUc3m00RsqyRe') ).to be_truthy
      end

      it 'authenticate with name and no right password' do
        user = User.find_by(name: 'david').try(:authenticate, 'notright')
        expect(user).to be false
      end

      it 'authenticate with name and right password' do
        user = User.find_by(name: 'david').try(:authenticate, 'mUc3m00RsqyRe')
        expect(user).to be_truthy
      end
    end

  end

end

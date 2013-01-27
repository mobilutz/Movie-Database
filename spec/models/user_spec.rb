require 'spec_helper'

describe User do
  context 'Validations' do
    it 'should check for presence of email' do
      user = User.new(password: 'passwort', password_confirmation: 'passwort')
      user.valid?.should be_false
    end

    it 'should check for correct password matching' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'WRONG')
      user.valid?.should be_false
    end

    it 'should be a valid user' do
      user = User.new(email: 'test@test.de', password: 'passwort', password_confirmation: 'passwort')
      user.valid?.should be_true
    end
  end
end

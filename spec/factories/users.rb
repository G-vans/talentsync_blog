FactoryBot.define do
    factory :user do
      username { 'test_user' }
      password_digest { BCrypt::Password.create('password123') }
    end
  end
  
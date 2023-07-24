require 'rails_helper'
RSpec.describe User, type: :model do
    context "validations" do
      it "is valid with valid attributes" do
        user = User.new(
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        )
        expect(user).to be_valid
      end
  
      it "is not valid without an email" do
        user = User.new(
          password: "password",
          password_confirmation: "password"
        )
        expect(user).not_to be_valid
      end
  
      it "is not valid with an invalid email format" do
        user = User.new(
          email: "invalid_email",
          password: "password",
          password_confirmation: "password"
        )
        expect(user).not_to be_valid
      end
  
      it "is not valid without a password" do
        user = User.new(
          email: "test@example.com",
          password_confirmation: "password"
        )
        expect(user).not_to be_valid
      end
  
      it "is not valid with mismatched password confirmation" do
        user = User.new(
          email: "test@example.com",
          password: "password",
          password_confirmation: "different_password"
        )
        expect(user).not_to be_valid
      end
    end
  
    context "has_secure_password" do
      it "returns true if the password is correct" do
        user = User.new(
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        )
        expect(user.authenticate("password")).to eq(user)
      end
  
      it "returns false if the password is incorrect" do
        user = User.new(
          email: "test@example.com",
          password: "password",
          password_confirmation: "password"
        )
        expect(user.authenticate("wrong_password")).to be_falsey
      end
    end

    context "uniqueness" do
        it "is not valid with a non-unique email" do
          # Create a user with a specific email
          existing_user = User.create(
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          )
    
          # Attempt to create another user with the same email
          duplicate_user = User.new(
            email: "test@example.com",
            password: "another_password",
            password_confirmation: "another_password"
          )
    
          # The duplicate user should not be valid
          expect(duplicate_user).not_to be_valid
        end
    
        it "is valid with a unique email" do
          # Create a user with a specific email
          existing_user = User.create(
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          )
    
          # Attempt to create another user with a different email
          unique_user = User.new(
            email: "another_test@example.com",
            password: "password",
            password_confirmation: "password"
          )
    
          # The unique user should be valid
          expect(unique_user).to be_valid
        end
    end
end
  
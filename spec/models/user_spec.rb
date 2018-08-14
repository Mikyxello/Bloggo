require 'rails_helper'

RSpec.describe User, type: :model do
  # Association test

  it { should have_many(:blogs) }
  it { should have_many(:posts) }
  it { should have_many(:comments) }
  # Validation tests

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:surname) }
  it { should validate_presence_of(:username) }

  describe "New user without username" do
    it "should be invalid" do
      user = User.new(:name => "Simone", :surname => "Staffa", :email => "simo@gmail.com", :password => "staffa", :password_confirmation => "staffa")
      expect(user).not_to be_valid
    end
  end

  describe "New user without email" do
    it "should be invalid" do
      user = User.new(:username => "Pincopallino", :name => "Simone", :surname => "Staffa", :password => "staffa", :password_confirmation => "staffa")
      expect(user).not_to be_valid
    end
  end

end

require 'rails_helper'

RSpec.describe Blog, type: :model do
	before(:each) do
		@user = FactoryBot.create(:user, :is_bloggoer)
		@blog = FactoryBot.create(:blog, :user => @user)
	end

	describe "Creating a invalid blog" do
		context "When i put a blank name" do
			it "should not be valid" do
				blog = Blog.new(:name => "", :description => @Faker::String , :user => @user)
				expect(blog).not_to be_valid
			end
		end
	end
end
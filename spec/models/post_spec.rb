require 'rails_helper'

RSpec.describe Post, type: :model do
	before(:each) do
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @user)
	end

	context "Creating a invalid post" do
		describe "When i put a blank title" do
			it "should not be valid" do
				post = @blog.posts.build(:title => '', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).not_to be_valid
			end
		end

		describe "When i put a title that is too long" do
			it "should not be valid" do
				post = @blog.posts.build(:title => ' Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus consectetur vulputate justo, eu sed.', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).not_to be_valid
			end
		end

		describe "When i put a subtitle that is too long" do
			it "should not be valid" do
				post = @blog.posts.build(:title => ' Lorem ipsum dolor.', :subtitle => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque imperdiet felis vitae varius pretium. Ut dictum mauris vel est imperdiet gravida. Nullam sed lacinia justo. Aenean arcu velit amet.', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).not_to be_valid
			end
		end
	end
end

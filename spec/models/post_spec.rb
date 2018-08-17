require 'rails_helper'

RSpec.describe Post, type: :model do
	before(:each) do
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @user)
		@post = FactoryBot.create(:post, :blog => @blog, :user => @user)
	end

	describe "Creating a invalid post" do
		context "When i put a blank title" do
			it "should not be valid" do
				post = @blog.posts.build(:title => '', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).not_to be_valid
			end
		end

		context "When i put a title that is too long" do
			it "should not be valid" do
				post = @blog.posts.build(:title => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus consectetur vulputate justo, eu sed.', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).not_to be_valid
			end
		end

		context "When i put a subtitle that is too long" do
			it "should not be valid" do
				post = @blog.posts.build(:title => 'Lorem ipsum dolor.', :subtitle => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque imperdiet felis vitae varius pretium. Ut dictum mauris vel est imperdiet gravida. Nullam sed lacinia justo. Aenean arcu velit amet.', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).not_to be_valid
			end
		end

		context "When i put a blank content" do
			it "should not be valid" do
				post = @blog.posts.build(:title => 'Rspec title test', :subtitle => '', :tag_list => '', :content => '', :user => @user)
				expect(post).not_to be_valid
			end
		end

		context "When i put a file that has not valid extension" do
			it "should not be valid" do
				post = @blog.posts.build(:title => 'Rspec title test', :subtitle => '', :tag_list => '', :content => 'Content', :remote_file_url => 'https://www.eecs.yorku.ca/course_archive/2003-04/W/3311/sectionM/case_studies/money/KentBeck_TDD_byexample.pdf', :user => @user)
				expect(post).not_to be_valid
			end
		end

		context "When it has no user" do
			it "should not be valid" do
				post = @blog.posts.build(:title => 'Rspec title test', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing')
				expect(post).not_to be_valid
			end
		end
	end

	describe "Creating a valid post" do
		context "When i put a blank title" do
			it "should be valid" do
				post = @blog.posts.build(:title => 'Rspec post title', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing', :user => @user)
				expect(post).to be_valid
			end
		end

		context "When i put a valid file" do
			it "should be valid" do
				post = @blog.posts.build(:title => 'Rspec post title', :subtitle => 'Rspec subtitle', :tag_list => 'tag, list', :content => 'Rspec post content testing', :remote_file_url => 'https://commons.wikimedia.org/wiki/File:JPEG_example_JPG_RIP_100.jpg', :user => @user)
				expect(post).to be_valid
			end
		end
	end
end

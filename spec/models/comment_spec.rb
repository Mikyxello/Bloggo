require 'rails_helper'

RSpec.describe Comment, type: :model do
	before(:each) do
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @user)
		@post = FactoryBot.create(:post, :blog => @blog, :user => @user)
	end

	describe "Creating a invalid comment" do
		context "When i put a blank content" do
			it "should not be valid" do
				comment = @post.comments.build(:content => '', :user => @user)
				expect(comment).not_to be_valid
			end
		end

		context "When i put a content that is too long" do
			it "should not be valid" do
				comment = @post.comments.build(:content => Faker::String.random(1001), :user => @user )
				expect(comment).not_to be_valid
			end
		end

		context "When i put an invalid ancestry comment" do
			it "should not be valid" do
				expect{@post.comments.build(:content => Faker::String.random(10), :user => @user, :parent_id => Comment.count+1 )}.to raise_error(ActiveRecord::RecordNotFound)
			end
		end
	end

	describe "Creating a valid comment" do
		context "When i put valid content" do
			it "should be valid" do
				comment = @post.comments.build(:content => Faker::String.random(1..1000), :user => @user)
				expect(comment).to be_valid
			end
		end

		context "When i put valid content and ancestry" do
			it "should be valid" do
				@comment = FactoryBot.create(:comment, :post => @post, :user => @user)
				comment = @post.comments.build(:content => Faker::String.random(1..1000), :user => @user, :parent_id => @comment.id)
				expect(comment.parent).to eql @comment
				expect(comment).to be_valid
			end
		end
	end
end

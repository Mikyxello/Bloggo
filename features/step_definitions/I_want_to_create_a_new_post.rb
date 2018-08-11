#require "rails_helper"

Given("There is at least one blog") do
  @blog = create(:blog)
  @user = create(:user)
  create(blog_id: @blog.id, user_id: @user.id)
end

Given("I am on the blog page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I am the creator of the blog") do
  pending # Write code here that turns the phrase above into concrete actions
end

When("I click on {string}") do |string|
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I am on the new post page") do
  pending # Write code here that turns the phrase above into concrete actions
end

Given("I fill all the fields") do
  pending # Write code here that turns the phrase above into concrete actions
end

Then("I should see the post on the blog page") do
  pending # Write code here that turns the phrase above into concrete actions
end
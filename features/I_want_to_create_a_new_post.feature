Feature: I want to create a new post
	As a user
	I want to create a new post
	Such that I can see the post on the blog page

Scenario: create a new post
	Given There is at least one blog
	And I am on the blog page
	And I am the creator of the blog
	When I click on "Create new post"
	Given I am on the new post page
	And I fill all the fields
	When I click on "Publish"
	Then I should see the post on the blog page
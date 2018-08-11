Feature: User can create a new post
	As a USER
	I want to CREATE A NEW POST
	So that I can SEE THE POST ON THE BLOG PAGE

Scenario: Create a new post
	Given I am a registered user
	And There is at least one blog
	And I am the owner of the blog
	And I am on the blog page
	When I click Create Postoes
	Given I am on the new post page
	And I fill in "title" with "Post title"
	And I fill in "subtitle" with "Post subtitle"
	And I fill in "tag_list" with "post, test, tags"
	And I fill in "content" with "The post content"
	When I click Publish
	Then I should be on the post page
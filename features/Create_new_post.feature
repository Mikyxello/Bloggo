Feature: User can create a new post
	As a USER
	I want to CREATE A NEW POST
	So that I can SEE THE POST ON THE BLOG PAGE

Scenario: Create a new post
	Given There is at least a registered user
	And There is at least one blog
	And I am the owner of the blog
	And I am on the blog page
	When I follow "Create Postoes"
	Given I am on the new post page
	And I fill in "post[title]" with "Post title"
	And I fill in "post[subtitle]" with "Post subtitle"
	And I fill in "post[tag_list]" with "post, test, tags"
	And I fill in "post[content]" with "The post content"
	When I press "Publish"
	Then I should be on the post page


Scenario: Cannot create a new post
	Given There are at least two registered user
	And There is at least one blog
	And I am not the owner of the blog
	And I am on the blog page
	Then I should not see "Create Postoes"
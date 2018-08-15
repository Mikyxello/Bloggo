Feature: User can create a new blog
	As a USER
	I want to CREATE A NEW BLOG
	So that I can SEE THE BLOG ON THE USER PAGE

Scenario: Create a new blog
	Given I am a bloggoer user
	When I visit the user_index page
	When I follow "Create Bloggoes"
	Given I am on the new blog page
	And I fill in "blog_name" with "Blog Name"
	And I fill in "blog_description" with "Blog Description"
	And I attach the file "404_robot.png" to "blog_header"
	And I attach the file "404_robot.png" to "blog_profile"
	When I press "Create Blog"
	Then I should be on the blog page
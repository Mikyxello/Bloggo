Feature: User can edit a new post
	As a USER
	I want to EDIT AN EXISTING POST
	So that I can SEE THE EDITED POST ON THE BLOG PAGE

Scenario: Can edit a post
	Given There is at least a registered user
	And There is at least one blog
	And The blog has at least one post
	And I am the owner of the blog
	And I am on the post page
	When I follow "Edit"
	Then I should be on the post edit page
	And I should see "Edit Post"
	And I fill in "post_title" with "New post title"
	And I fill in "post_subtitle" with "New post subtitle"
	And I fill in "post_tag_list" with "new, tags, edited"
	And I fill in "post_content" with "New post content"
	When I press "Update"
	Then I should be on the post page
	And I should see "New post content"
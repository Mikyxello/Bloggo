Feature: User can create new comments
	As a USER
	I want to CREATE A NEW COMMENT
	So that I can SEE THE COMMENT ON THE POST PAGE

Scenario: Create a new comment
	Given There is at least a registered user
	And I am logged in
	And There is at least one blog
	And The blog has at least one post
	And I am on the post page
	And I fill in "comment[content]" with "Comment content"
	When I press "Comment"
	Then I should be on the post page
	Then I should see "Comment content"

Scenario: Cannot create a new comment
	Given There is at least a registered user
	And I am not logged in
	And There is at least one blog
	And The blog has at least one post
	And I am on the post page
	And I should not see "comment[content]"
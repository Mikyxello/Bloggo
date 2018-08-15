Feature: User can change username
	As a USER
	I want to HAVE A PROFILE
	So that I can CHANGE MY USERNAME

Scenario: Change Username
	Given I am a registered user
  And I am on the home page
  When I follow "Profile Page"
  And I follow "Edit Profile"
  And I fill in "username" with "cristiano"
	Then I press "updateusername"
	And I should be on the home page
  Then I follow "Profile Page"
  And I should see "cristiano"

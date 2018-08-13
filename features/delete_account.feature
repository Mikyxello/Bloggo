Feature: User can set an avatar
  As a REGISTERED USER
  I want to HAVE A PROFILE
  So that i can DELETE MY ACCOUNT

Scenario: Deleting my account
  Given I am a registered user
  Then I should be on the home page
  Then I follow "Profile Page"
  Then I follow "Edit Profile"
  And I press "deleteaccount"
  Then I should be on the home page
  And I should see "Login"

Scenario: Deleting others account
  Given I am a registered user
  Then I should be on the home page
  And I try to delete an account of others
  Then I should be on the home page
  And I should see "Profile Page"

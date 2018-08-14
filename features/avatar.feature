Feature: User can set an avatar
  As a REGISTERED USER
  I want to HAVE A PROFILE
  So that i can SET AN AVATAR

Scenario: Add an avatar
  Given I am a registered user
  When I log in
  Then I should be on the home page
  Then I follow "Profile Page"
  Then I follow "Edit Profile"
  And I attach the file "404_robot.png" to "avatarimage"
  And I press "update"
  Then I should be on the home page
  And I should see "Profile Page"
  When I follow "Profile Page"
  And I should see the image

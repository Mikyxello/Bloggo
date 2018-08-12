Feature: User can create a new account
  As a USER
  I want to LOGIN WITH EMAIL
  so that I can INTERACT WITH THE SYSTEM

Scenario: Login success
  Given I am on the login page
  And I am a registered user
  When I fill in "loginemail" with "simonestaffa96@gmail.com"
  And I fill in "loginpassword" with "staffa"
  And I press "loginbutton"
  Then I should be on the home page
  And I should see "Logout"

Scenario: Login failed
  Given I am on the login page
  When I fill in "loginemail" with "pippoplutopaperino@gmail.com"
  And I fill in "loginpassword" with "123456"
  And I press "loginbutton"
  Then I should be on the login page
  And I should see "Invalid Email or password."

Scenario: Login banned
  Given I am on the login page
  And I am a banned user
  Then I should be on the login page
  And I should see "Cannot Login: ACCOUNT BANNED."

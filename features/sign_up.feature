Feature: User can create a new account
  As an UNREGISTERED USER
  I want to LOGIN WITH EMAIL
  so that I can BECOME A USER

Scenario: Create a new account
  Given I am on the sign up page
  When I fill in "username" with "simoncino"
  And I fill in "name" with "Simone"
  And I fill in "surname" with "Staffa"
  And I fill in "email" with "simonestaffa96@gmail.com"
  And I fill in "password" with "staffa"
  And I fill in "user[password_confirmation]" with "staffa"
  And I press "signupp"
  Then I should be on the home page
  Then I follow "Profile Page"
  And I should see "Simone Staffa"

Scenario: Can't create an account (email required)
  Given I am on the sign up page
  When I fill in "username" with "simoncino"
  And I fill in "name" with "Simone"
  And I fill in "surname" with "Staffa"
  And I fill in "password" with "staffa"
  And I fill in "user[password_confirmation]" with "staffa"
  And I press "signupp"
  Then I should be on the users page
  And I should see "Email can't be blank"

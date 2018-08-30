Feature: User can search on navbar
    As a USER
    I want to SEARCH BLOGS,POSTS and TAGS
    so that I can SEE THE RESULTS

Scenario: Search blogs
  Given I am on the homepage
  Then I fill in "q" with "BlogName"
  Then I press "Search"
  Then I should be on the search page
  And I should see the results

Scenario: Search tags
  Given I am on the homepage
  Then I fill in "q" with "TagName"
  Then I press "Search"
  Then I should be on the search page
  And I should see the results

Scenario: Search posts
  Given I am on the homepage
  Then I fill in "q" with "PostTitle"
  Then I press "Search"
  Then I should be on the search page
  And I should see the results

Scenario: Search blank
  Given I am on the homepage
  Then I fill in "q" with "blank"
  Then I press "Search"
  Then I should be on the search page
  And I should see the results

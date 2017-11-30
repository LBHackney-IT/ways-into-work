Feature: Client signs in and can tell story
  As a client
  I should be able to view my profile
  So I can see what information I have provided

  Background:
    Given I have just signed up as a client
    And I sign in
    
  Scenario: Client views profile
    Given I am on my profile page
    Then I should see my profile details

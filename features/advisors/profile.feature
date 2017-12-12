Feature: Advisor views profile

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is assigned to me
    
  Scenario: Advisor can see referrer details
    Given the client has a referrer
    And I am on the advisors edit client page
    Then I should see the referrer's details

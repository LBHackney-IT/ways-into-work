Feature: Advisor updates profile

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is not assigned to me

  Scenario: Updating does not reassign client
    Given I am on the advisors edit client page
    And I update the client's details
    Then the client should not be assigned to me

  Scenario: Updates contact method
    Given I am on the advisors edit client page
    And I update the client's preferred contact details to all
    Then the client should be contactable by sms reminder

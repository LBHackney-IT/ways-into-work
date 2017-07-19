Feature: Advisor archives client
  So I can remove a client from any further contact
  As an advisor
  I should be archive a client from view

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is assigned to me

  Scenario: Advisor archives client
    Given I am on the my clients page
    When I archive the client
    Then the client should be removed from view


Feature: Advisor uploads file for information page
  So that I can easily find suitable clients
  As an Advisor
  I should be able to filter a list of clients

  Background:
    Given I am signed in as an advisor
    And there is a client who has been assessed
    And the client is assigned to me

  @javascript
  Scenario: Advisor filters by types of work
    Given the client is looking to work in Retail
    And I am on the my clients page
    When I filter by to Retail as types of work
    Then I should see my client in the filtered list

@advisor_cv
Feature: Advisor uploads file for information page
  So that I can upload CV documents of clients
  As an Advisor
  I should be able to upload a file that can be downloaded from the clients account

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is assigned to me

  @javascript
  Scenario: Advisor uploads pdf
    Given I am on the advisors edit client page
    When I upload a cv file
    Then a cv upload reference should be saved
    And I should see that I uploaded the file

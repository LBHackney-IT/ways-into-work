Feature: Client signs in and can tell story
  As a client
  I should be able to come back to my profile
  So I that can give more information to advisors

  Background:
    Given I have just signed up as a client
    And I sign in

  Scenario: client is asked for eligibility
    Then I should be on the client dashboard page
    And I should be asked to provide more information

  Scenario: client skips through all information with out adding
    Given I am on the client dashboard page
    And when I navigate through all the profile steps
    Then I should be on the client next steps page

  Scenario: details get saved when client goes back through the form
    Given I fill out the first three profile steps
    And I go back to a previous step
    Then my options should be saved

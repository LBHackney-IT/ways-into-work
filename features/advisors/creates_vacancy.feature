Feature: Advisor creates a new vacancy
  As an Advisor
  I should be able to create a new vacancy
  So I can advertise the types of vacancy available on the homepage
  
  Background:
    Given I am signed in as a member of the employer engagement team
  
  Scenario: Advisor creates a brand new vacancy
    Given I create a new vacancy
    Then I should be redirected to the vacancy index page
    And the vacancy should exist in the database
    
  Scenario: Advisor edits a vacancy
    Given there is a vacancy
    And I edit the vacancy's title
    Then I should be redirected to the vacancy index page
    And the vacancy's title should have changed
    
  Scenario: Advisor deletes a vacancy
    Given there is a vacancy
    And I delete that vacancy
    Then the vacancy should not exist

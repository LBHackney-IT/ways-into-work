@javascript
Feature: Advisor creates a new vacancy
  As an Advisor
  I should be able to order vacancies on the homepage
  So I can choose what vacancies appear to the public
  
  Background:
    Given I am signed in as a member of the employer engagement team
    Given there are 3 featured vacancies
    And there are 5 vacancies
    And I am on the advisor vacancies page
    
  Scenario: User drags vacancies to featured slots
    When I drag three of the vacancies to featured slots
    Then the featured vacancies should be stored correctly

Feature: Default hubs on advisor page

  Background:
    Given I am signed in as an advisor
    And there are 5 clients from my hub
    And there are 6 clients from another hub
  
  Scenario: Advisor sees their hub as default
    Given I am on the advisor clients page
    Then my hub should be selected by default
    And I should only see clients from my hub
    
  Scenario: Admin sees all clients
    Given I am an admin
    And I am on the advisor clients page
    Then the any hub option should be selected by default
    And I should see all clients

  Scenario: Employer Engagement team member sees all clients
    Given I am in the employer engagement team
    And I am on the advisor clients page
    Then the any hub option should be selected by default
    And I should see all clients

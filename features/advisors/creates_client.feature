Feature: Advisor creates a new client
  As an Advisor
  I should be able to create a new client
  So that client can apply for the service
  
  Background:
    Given I am an advisor
    And I sign in
  
  @homerton_postcode
  Scenario: Create a new client
    Given I register a client as "client@example.com"
    Then the client should be assigned to me

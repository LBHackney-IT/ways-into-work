Feature: Advisor creates a new client
  As an Advisor
  I should be able to create a new client
  So that client can apply for the service

  Background:
    Given I am signed in as an advisor

  @homerton_postcode
  Scenario: Create a new client
    Given I register a client as "client@example.com"
    Then the client should be assigned to me
    And that client should have an initial meeting created

  @haringey_postcode
  Scenario: client outside borough can't register
    When I try and register a client from Haringey
    Then I should see that the client must have a hackney postcode

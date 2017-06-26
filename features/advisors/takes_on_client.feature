Feature: Advisor takes on new case
  So I can work flexibily in case service managers are off
  As an advisor
  I should be able to assign clients to myself

  Background:
    Given I am an advisor
    And there is a client who just registered

  Scenario: Sees client in unassigned cases
    Given I have signed in
    When I am on the advisor my clients page
    Then I should not see the client in my case load
    When I navigate to the unnassigned clients
    Then I should see the new client listed

  Scenario: Sees client in unassigned cases
    Given I have signed in
    And I am on the advisor unassigned clients page
    When I assign the client to myself
    Then the client should be part of my case load

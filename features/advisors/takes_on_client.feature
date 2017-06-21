Feature: Advisor takes on new case
  As a advisor
  I should be able to sign in
  So I can assign client cases to advisors

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

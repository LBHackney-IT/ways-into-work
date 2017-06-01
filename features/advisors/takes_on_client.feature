Feature: Advisor takes on new case
  As a advisor
  I should be able to sign in
  So I can assign client cases to advisors

  Background:
    Given I am an advisor
    And there is a client who just registered

  Scenario: Sees client in unassigned cases
    Given I have signed in
    When I am on the advisor my cases page
    Then I should not see the client in my case load
    When I navigate to the unnassigned cases
    Then I should see the new client listed

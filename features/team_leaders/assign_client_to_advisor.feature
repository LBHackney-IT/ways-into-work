Feature: Team leader assigns client to another Advisor

  Background:
    Given there is an advisor
    And there is a client who just registered
    And I am signed in as a service manager

  Scenario: Advisor is able to assign client
    Given I am on the service manager clients page
    When I navigate to see the client's details
    Then I should see that the client has not been assigned yet
    And I should be able to assign the client to the advisor

  Scenario: Advisor assigns client
    Given I am on the service manager client page
    When I assign the client to the advisor
    Then I should see the advisor assigned success message
    And the client should now appear in the assigned clients list

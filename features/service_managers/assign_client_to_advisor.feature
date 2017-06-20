Feature: Service Manager assigns client

  Background:
    Given there is an advisor
    And there is a client who just registered
    And I am signed in as a service manager

  Scenario: Advisor is able to assign client
    Given I am on the service manager clients page
    When I navigate to see the client's details
    Then I should see that the client has not been assiged yet
    And I should be able to assign the client to the advisor

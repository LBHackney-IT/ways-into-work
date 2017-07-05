Feature: Team leader assigns client to another Advisor

  Background:
    Given there is a client who just registered
    And I am signed in as the clients team leader
    And there is an advisor Dave in my hub

  Scenario: Advisor is able to assign client
    Given I am on the advisor clients page
    When I navigate to see the client's details
    Then I should see that the client is assigned to me
    And I should be able to assign the client to Dave

  Scenario: Advisor assigns client
    Given I am on the advisors edit client page
    When I assign the client to dave
    Then I should see the advisor assigned success message
    And dave should receive a client asssigned notification

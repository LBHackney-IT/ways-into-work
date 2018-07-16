Feature: Advisor takes on new case
  So I can work flexibily in case service managers are off
  As an advisor
  I should be able to assign clients to myself

  Background:
    Given I am an advisor
    And there is a client who just registered

  Scenario: Sees client in all cases
    Given I have signed in
    When I am on the advisor my clients page
    Then I should not see the client in my case load
    When I navigate to see all clients
    Then I should see the new client listed

  Scenario: Advisor assigns client to them self
    Given I have signed in
    And I am on the advisor clients page
    When I assign the client to myself
    Then the client should be part of my case load
  
  Scenario: Employer engagement can't see assign button
    Given I am an in the employer engagement team
    And I have signed in
    And I am on the advisor clients page
    Then I should not be able to see the assign to me button

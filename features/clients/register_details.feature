Feature: Client signs up for the service
  As a client
  I should be able to register minimal details
  So I that an advisor can contact me for an appointment

  Background:
    Given I have just registered a user login

  Scenario: client asked create profile
    When I sign in with the user login details
    Then I should be asked to start creating my profile

Feature: Client signs up for the service
  As a client
  I should be able to register minimal details
  So I that an advisor can contact me for an appointment

  Background:
    Given I have just registered a user login

  Scenario: client asked create profile
    When I sign in with the user login details
    Then I should be asked to start creating my profile

  @wip
  Scenario: Client creates minimal profile
    Given I have signed in
    And there is a service manager
    When I register my client details
    Then my client details should be saved against my user login
    Then the service manager should receive a new client notification


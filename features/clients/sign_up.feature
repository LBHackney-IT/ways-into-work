Feature: Client signs up for the service
  As a client
  I should be able to sign up
  So I that can apply for the service

  Scenario: client is asked for eligibility
    Given I am on the home page
    When I follow the link to register for the service
    Then I should be asked to accept the eligibility criteria

  Scenario: client signs up
    When I register my self as "client@example.com"
    Then "client@example.com" receive an email asking to confirm address
    When I click the opt-in email confirmation link
    Then I should see the client email confirmed notice message
    And I should be on the new user login session page


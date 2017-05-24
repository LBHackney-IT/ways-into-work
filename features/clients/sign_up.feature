Feature: Client registers for the service
  As a client
  I should be able to sign up
  So I that can apply for the service

  Scenario: user is asked for eligibility
    Given I am on the home page
    When I follow the link to register for the service
    Then I should be asked to accept the eligibility criteria

  @wip
  Scenario: user signs up
    When I register my self as "user@example.com"
    Then "user@example.com" receive an email asking to confirm address
    When I open the email
    Then I should see the client email confirmed notice message
    And I should be on the new user login session page


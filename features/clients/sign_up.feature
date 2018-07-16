Feature: Client signs up for the service
  As a client
  I should be able to sign up
  So I that can apply for the service

  Background:
    Given there is a hub covering homerton
    And there is a team leader for homerton

  @outside_hackney_postcode
  Scenario: client outside borough can't register
    Given I am on the home page
    When I navigate to register for the service
    And I try and register with a postcode outside the borough
    Then I should be on the outside hackney page

  Scenario: client must enter a postcode
    Given I am on the home page
    When I navigate to register for the service
    And I try and register without a postcode
    Then I should see an error telling me I need a postcode

  @homerton_postcode
  Scenario: team leader receives notification
    When I register my self as "client@example.com"
    Then the team leader should receive a new client notification
    And I should be auto assigned to homerton

  @homerton_postcode
  Scenario: client signs up
    When I register my self as "client@example.com"
    Then "client@example.com" receive an email asking to confirm address
    When I click the opt-in email confirmation link
    And I create a new password
    Then I should see a password updated notice message
  
  @homerton_postcode
  Scenario: client can't sign up with an exisitng phone number
    Given I have just signed up as a client
    And I try and register with the same phone number
    Then I should see an error telling me the phone number already exists

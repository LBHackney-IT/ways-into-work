Feature: Service manager signs in
  As a service manager
  I should be able to sign in
  So I can assign client cases to advisors

  Background:
    Given I am a service manager
    And there is a client who just registered

  Scenario: Successful sign in
    When I sign in
    Then I should be signed in
    And I should be on the service manager cases page
    And should see the new client listed

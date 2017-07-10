Feature: Advisor updates client fields in assessment
  So that I can complete an initial assessment
  As an Advisor
  I should be able to digitally record a clients information

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is assigned to me

  Scenario: Advisor uploads pdf
    Given I am on the advisors edit client page
    When I indicate my client is looking to work in Retail
    Then my client should be updated with looking for Retail work

Feature: Advisor records meeting arrangement
  As a advisor
  I should be able to sign in
  So I can assign client cases to advisors

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is assigned to me

  @wip
  Scenario: Advisor records new appointment booking
    Given I am on the advisor my clients page
    And I schedule a meeting for next week with notes
    Then I should see the meeting has been booked



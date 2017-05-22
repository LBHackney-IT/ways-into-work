Feature: Agent sign in
  As an agent
  I should be able to sign in
  So I can manage my case load

  Background:
    Given I am an advisor

  Scenario: Successful sign in
    When I sign in
    Then I should be signed in
    And I should be on the advisor cases page

Feature: Advisor records action plan item
  As an advisor
  I should be able to assign action plan tasks to clients
  So I can review them at the next meeting

  Background:
    Given I am signed in as an advisor
    And there is a client who just registered
    And the client is assigned to me

  Scenario: Advisor records new action plan item
    Given I am on the advisor my clients page
    And I assign a new action plan task to them
    Then I should see the task has been recorded

  Scenario: Advisor marks action plan task as completed
    Given my client has an action plan task
    And I am on the edit action plan task page
    And I mark the task as completed
    Then I should see the task has been completed

  Scenario: Action plan task with linked achievement
    Given my client has an action plan task with an achievement
    And I am on the edit action plan task page
    And I mark the task as completed
    Then my client should have an achievement recorded

  Scenario: Advisor views empty achievements
    Given I am on the client achievements page
    Then I should see there are no achievements yet
    When I add several achievements manually
    Then I should see the counts are displayed correctly

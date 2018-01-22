Feature: Advisor sign in roles

  Background:
    Given I am an advisor

  Scenario: Default role
    When I sign in
    Then I should be on the my clients page
    And I should see a link to the my clients page
    And I should see a link to the dashboard page
  
  Scenario: Admin role
    Given I am an admin
    When I sign in
    And I should see a link to the dashboard page
    And I should not see a link to the my clients page
  
  Scenario: Employer Engagement role
    Given I am an in the employer engagement team
    When I sign in
    And I should not see a link to the dashboard page
    And I should not see a link to the my clients page

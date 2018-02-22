@javascript
Feature: Advisor restores client
  So I can ensure an revist an old clients records
  As an advisor
  I should be restore an archived client to be included in the main system again

  Background:
    Given I am signed in as an advisor
    And there is a client who has been archived

  Scenario: Advisor can find archived clients
    Given I am on the advisor clients page
    Then I should not see the client listed
    When I am on the advisor archived clients page
    Then I should see the archived client listed

  Scenario: Advisor restores archived client
    Given I am on the advisor archived clients page
    And I include archived clients in the results
    When I restore the client to the system
    Then I should be redirected to the client's edit page
    And the client should be restored and found by default

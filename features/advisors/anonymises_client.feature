Feature: Advisor anonymises client
  So I can ensure compliance with GDPR
  As an advisor
  I should be able to remove a client's personal details if they request it

  Background:
    Given I am signed in as an admin
    And there is a client who has been archived

  Scenario: Admin anonymises archived client
    Given I am on the advisor archived clients page
    When I anonymise the client
    Then the client's personal details should be anonymised
    
  Scenario: Advisor cannot see anonymisation button
    Given I am on the advisor archived clients page
    Then I should not be able to see the anonymise client button

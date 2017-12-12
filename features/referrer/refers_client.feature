Feature: Client is referred via another agency
  As a council officer outside Hackney Works
  I want to refer clients to the programme
  So I can help them find a job
  
  Background:
    Given there is a hub covering homerton
    And there is a team leader for homerton
  
  @homerton_postcode
  Scenario: Referral creates a new client
    Given I am on the client referral page
    And I fill in the referral form
    Then a new client should be created in the database

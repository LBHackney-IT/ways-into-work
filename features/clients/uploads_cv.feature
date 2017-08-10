Feature: Client uploads file for information page
  So that I can upload CV documents to share with my advisor
  As an Client
  I should be able to upload a file that can be downloaded from the clients page

  Background:
    Given I am signed in as an Client

  @javascript
  Scenario: Client uploads pdf
    Given I am on the client dashboard page
    When I upload my cv file
    Then a cv upload reference should be saved
    And I should see that I uploaded the file

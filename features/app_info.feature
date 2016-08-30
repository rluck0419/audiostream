Feature: When visiting the website, the info buttton reveals info about the app.
  Scenario: Someone visits the website
    Given I have an existing set of sound-based data
    When I visit homepage
    And I click "info"
    Then I should see "About Soundhouse"

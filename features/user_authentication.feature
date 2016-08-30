Feature: As a User, I should be able to sign in or sign up to use the app
  Scenario: Existing user logs in
    Given I have an existing user account
    And I have an existing set of sound-based data
    When I visit homepage
    And I click "Sign In"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    Then I should see "Profile"

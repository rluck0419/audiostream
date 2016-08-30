Feature: As a User, I should be able to see my profile after signing in
  Scenario: Existing user logs in and clicks profile
    Given I have an existing user account
    And I have an existing set of sound-based data
    When I visit homepage
    And I click "Sign In"
    And I fill in "Email" with "user@example.com"
    And I fill in "Password" with "password"
    And I press "Submit"
    And I click "Profile"
    Then I should see "Favorite"

Feature: The home page
  As a researcher
  I want to see a useful home page
  So that I don't feel lost and alone

  Scenario: No pages have been created yet
    When I go to the home page
    Then I should be on the home page
    Then I should see "Welcome to Vowessly" in the title
    And I should see "To get started, lets create your first page."

  Scenario: A page has been created
    Given I have created a "Page" page called "Home"
    When I go to the home page
    Then I should be on the "Page" page for "Home"

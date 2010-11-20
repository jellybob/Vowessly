Feature: The home page
  As a researcher
  I want to see a useful home page
  So that I don't feel lost and alone
  
  @wip
  Scenario: No pages have been created yet
    When I am on the home page
    Then I should see "Welcome to Vowessly" in the title
    And I should see "To get started, lets create your first page."

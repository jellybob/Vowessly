@wip
Feature: Displaying vowesses by their province
  As a researcher
  I want to see all Vowesses listed by their province
  So that I can find correlations between them

  Background:
    Given I have the following vowesses with a province
      | Name              | Province   |
      | Jane Chamberlayne | Canterbury |
      | Alice Vavasor     | York       |

  Scenario: No vowesses match the specified location
    When I choose to view vowesses with a province of "Mars"
    Then no vowesses should be listed
  
  Scenario Outline: Listing vowesses by province
    When I choose to view vowesses with a province of "<Province>"
    Then the vowess "<Visible>" should be listed
    And the vowess "<Invisible>" should not be listed
    
    Examples:
      | Province   | Visible           | Invisible         |
      | Canterbury | Jane Chamberlayne | Alice Vavasor     |
      | York       | Alice Vavasor     | Jane Chamberlayne |

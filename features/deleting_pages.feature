Feature: Deleting pages
  As a researcher
  I want to delete a page
  In order to remove unwanted information
  So that my data is accurate

  Scenario: Delete
    When I am viewing a page
    And I choose to delete the page
    Then the page should have been deleted
    And I should be told it was deleted
    And I should be on the home page

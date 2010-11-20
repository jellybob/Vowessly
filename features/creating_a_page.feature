Feature: Creating a page
  As a researcher
  I want to create a new page
  So that I can record my findings
  
  Background:
    When I am on the home page
    And I follow "Create a Page" in the navigation
    Then I should be on the new page page
  
  Scenario: A valid page
    When I fill in "Name" with "Alice Hampton"
    And I fill in "Type" with "Person"
    And I fill in "Body" with "She was a lovely vowess. Really lovely."
    And I press "Create Page"
    Then I should be on the "Person" page for "Alice Hampton"
    And I should see "A new person page about Alice Hampton has been created" in the notice flash
  
  Scenario: An invalid page
    When I fill in "Name" with "Alice Hampton"
    And I don't fill in "Type"
    And I press "Create Page"
    Then I should be on the pages page
    And I should see "There was a problem with the details you provided. Have a look below and try again." in the error flash
    And the "Content type" field should have the error "can't be blank"

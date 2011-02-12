Feature: Searching
  As a researcher
  I want to search the wiki
  In order to find related information

  Background:
    Given I have created a "Person" page called "Alice Hampton"
    And I have added the following fact to the page:
      | Label          | Content Type | Value                           | Source                                                     |
      | Date of Birth  | Date         | C15                             | Josiah Clement Wedgwood, History of Parliament: 1439-1509  |
    And I am on the home page

  Scenario: Searching, and not getting any results
    When I search for "Bob Hoskins" in the "Page name" field
    Then I should be on the search results page
    And I should see "Sorry, nothing matched your search for Bob Hoskins."

  Scenario: Searching the title field, and getting results
    When I search for "Alice Hampton" in the "Page name" field
    Then I should be on the search results page
    And I should see "Alice Hampton" as a search result title
    And I should see "Person" as a search result type

  Scenario: Searching the date field, and getting results
    When I search for "C15" in the "Date of Birth" field
    Then I should be on the search results page
    And I should see "Alice Hampton" as a search result title
    And I should see "Person" as a search result type

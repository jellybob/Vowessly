Feature: Facts
  As a researcher
  I want to add facts to my pages
  So that I can search for them later
  In order to create great papers

  Scenario: Displaying facts on a page
    Given I have created a "Person" page called "Alice Hampton"
    And I have added the following fact to the page:
      | Label          | Content Type | Value                           | Source                                                     |
      | Date of Birth  | Date         | C15                             | Josiah Clement Wedgwood, History of Parliament: 1439-1509  |
    When I go to the "Person" page for "Alice Hampton"
    Then I should see the fact "Date of Birth"
    And the type should be "Date"
    And the value should be "C15"
    And the source should be "Josiah Clement Wedgwood, History of Parliament: 1439-1509"

  @javascript
  Scenario: Creating a new fact, all information provided
    Given I have created a "Person" page called "Alice Hampton"
    When I go to the "Person" page for "Alice Hampton"
    And I follow "Add a Fact"
    And I fill in "Label" with "Date of Birth"
    And I fill in "Value" with "C15"
    And I fill in "Type" with "Date"
    And I fill in "Source" with "Josiah Clement Wedgwood, History of Parliament: 1439-1509"
    And I press "Add Fact"
    Then I should be on the "Person" page for "Alice Hampton"
    And I should see the fact "Date of Birth"
    And the type should be "Date"
    And the value should be "C15"
    And the source should be "Josiah Clement Wedgwood, History of Parliament: 1439-1509"

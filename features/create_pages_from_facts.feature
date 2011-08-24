@javascript
Feature: Creating pages from facts
  As a researcher
  I want to create a new page from a fact
  So that I can link to more information
  In order to group my data by content
  
  Scenario: Create a new page from a fact
    Given I have created a "Vowess" page called "Alice Hampton"
    And I have added the following fact to the page:
      | Label | Content Type | Value           |
      | Uncle | Person       | William Hampton |
    When I go to the "Vowess" page for "Alice Hampton"
    And I expand "Uncle"
    And I follow "Create Page"
    Then I should be on the "Person" page for "William Hampton"
 
  Scenario: Creating a fact with an associated page
    Given I have created a "Person" page called "William Hampton"
    And I have created a "Person" page called "Alice Hampton"
    And I have added the following facts to the page:
      | Label   | Content Type | Value           |
      | Uncle   | Person       | William Hampton |
    When I am on the "Person" page for "Alice Hampton"
    And I follow "William Hampton"
    Then I should be on the "Person" page for "William Hampton"

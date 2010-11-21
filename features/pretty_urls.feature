Feature: Pretty URLs
  As a casual browser
  I want to find a page by it's URL
  So that I don't have to mess around with search
  
  Scenario: The page exists
    Given I have created a "Person" page called "Alice Hampton"
    When I go to the URL "/person/alice-hampton"
    Then I should be on the "Person" page for "Alice Hampton"
  
  Scenario: The page does not exist
    When I go to the URL "/person/alice-hampton"
    Then I should be on the new page page
    And the "Type" field should contain "Person"
    And the "Name" field should contain "Alice Hampton"

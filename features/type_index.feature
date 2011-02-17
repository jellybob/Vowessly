Feature: Type indexes
  As a researcher
  I want to see all the pages of a certain type
  So that I can check how they relate to each other

  Scenario: Vowess index
    Given I have created a "Person" page called "Alice Hampton" with the body:
      """
      Alice is a lovely person, who is also a vowess.
      """
    When I go to the home page
    And I follow "People"
    Then I should be on the index page for People
    And I should see "Alice Hampton"

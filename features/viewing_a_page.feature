Feature: Viewing a page
  As a researcher
  I want to read a page
  So I can refresh my memory of the person in question
  
  Scenario: A page
    Given I have created a "Person" page called "Alice Hampton" with the body:
      """
      Alice is a lovely person, who is also a vowess.
      """
    When I go to the "Person" page for "Alice Hampton"
    Then I should see "Alice Hampton" in the title
    And I should see "Person" in the type description
    And I should see "Alice is a lovely person, who is also a vowess." in the page body

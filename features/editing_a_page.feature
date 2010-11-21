Feature: Editing a page
  As a researcher
  I want to edit a page
  So that I can update the details there
  In order to make my records more accurate
  
  Background:
    Given I have created a "Person" page called "Alice Hampton" with the body:
      """
      Alice is a vowess.
      """
    When I am on the "Person" page for "Alice Hampton"
    And I follow "Edit Page"
    And I should see "Editing Alice Hampton" in the title
    Then I should be on the edit "Person" page for "Alice Hampton"
      
  Scenario: Editing, and providing valid information
    When I fill in "Name" with "Bob Monkhouse"
    And I fill in "Type" with "Celebrity"
    And I fill in "Body" with "Bob likes to talk"
    And I press "Save Changes"
    Then I should be on the "Celebrity" page for "Bob Monkhouse"
    And I should see "Your changes have been saved." in the notice flash
    And I should see "Bob Monkhouse" in the title
    And I should see "Celebrity" in the type description
    And I should see "Bob likes to talk" in the page body

  Scenario: Editing, and providing incomplete information
    When I fill in "Name" with "Bob Monkhouse"
    And I don't fill in "Type" 
    And I fill in "Body" with "Bob likes to talk"
    And I press "Save Changes"
    Then I should be on the "Person" page for "Alice Hampton" 
    And I should see "Editing Alice Hampton" in the title
    And I should see "There was a problem with the details you provided. Have a look below and try again." in the error flash
    And the "Content type" field should have the error "can't be blank"

Feature: Linking to other pages
  As a researcher
  I want to include a link to another page in my body text
  So that I can reference other pages
  In order to make my wiki browseable

  Scenario: A link which resolves
    Given I have created a "Person" page called "Alice Hampton"
    And I have created a "Person" page called "Laura Wood" with the body:
      """
      Published an MA thesis about [page='Person/Alice Hampton']Alice Hampton[/page].
      """
    When I am on the "Person" page for "Laura Wood"
    And I follow "Alice Hampton"
    Then I should be on the "Person" page for "Alice Hampton"
 
  Scenario: A link which does not resolve
    Given I have created a "Person" page called "Laura Wood" with the body:
      """
      Published an MA thesis about [page='Person/Alice Hampton']Alice Hampton[/page].
      """
    When I am on the "Person" page for "Laura Wood"
    And I follow "Alice Hampton"
    Then I should be on the new page page
    And the "Type" field should contain "Person"
    And the "Name" field should contain "Alice Hampton"

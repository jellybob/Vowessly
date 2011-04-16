Feature: Label management
  As a researcher
  I want to see a list of all the labels I've used for facts and types
  So that I can check there are no erroneous ones
  In order to keep my data consistant

  Background:
    Given I am on the home page
    And I have created a "Person" page called "Alice Hampton"
    And I have added the following facts to the page:
      | Label   | Content Type | Value           |
      | Uncle   | Person       | William Hampton |
      | Uncel   | Persn        | Mr. Typo        |
  
  Scenario: Viewing fact names
    When I follow "Manage Labels"
    Then the following fact names should be shown:
      | Uncle |
      | Uncel |
    And page level attributes should not be shown as facts
  
  Scenario: Viewing type names
    When I follow "Manage Labels"
    Then the following content types should be shown:
      | Person |
      | Persn  |

  Scenario: Renaming a fact
    When I follow "Manage Labels"
    And I choose to rename the fact "Uncel"
    And I fill in "New name" with "Uncle"
    Then I should be on the labels page
    And the following fact names should be shown:
      | Uncle |

  Scenario: Renaming a type
    When I follow "Manage Labels"
    And I choose to rename the content type "Persn"
    And I fill in "New name" with "Person"
    Then I should be on the labels page
    And the following content types should be shown:
      | Person |

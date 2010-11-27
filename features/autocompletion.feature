Feature: Autocompletion
  As someone entering data
  I want fields to autocomplete
  So that the risk of typos is reduced
  
  Background:
    Given I have the following pages:
      | Name            | Content Type          |
      | Alice Hampton   | Vowess                |
      | Minchinhampton  | Place                 |
      | Newcastle       | Place                 |
      | Jon Wood        | Application Developer |
    And I have the following facts:
      | Page     | Label            | Content Type |
      | Jon Wood | Date of Birth    | Date         |
      | Jon Wood | Date of Marriage | Date         |
      | Jon Wood | Place of Birth   | Place        |
      | Jon Wood | Occupation       | Occupation   |
  
  @wip
  Scenario: When filling in a type field
    When I start filling in the type field with "Pl"
    Then I should see JSON:
      """
      [ "Place" ]
      """

  Scenario: When filling in a fact label field
    When I start filling in the label field with "Da"
    Then I should see JSON:
      """
      [ "Date of Birth", "Date of Marriage" ]
      """

  Scenario: When filling in a fact value field
    When the content type is "Place"
    And I start filling in the value field with "Ne"
    Then I should see JSON:
      """
      [ "Newcastle" ]
      """

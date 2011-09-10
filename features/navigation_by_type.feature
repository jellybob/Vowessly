Feature: Listing pages by type
  As a user
  I want to view a list of pages by type
  So that I can get a summary of what is available

  Scenario: No pages have been created
    When there are no pages
    And I go to the home page
    Then there should be no types listed in the navigation bar

  Scenario: Some pages have been created
    When there are some pages
    And I go to the home page
    Then there should be page types shown in the navigation bar
    When I click on a type
    Then it should show all the pages of that type
    And it shouldn't show pages of other types

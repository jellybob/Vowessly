Feature: Generating a Bibliography
  As a researcher
  I want to generate a bibliography
  So that I don't have to spend days writing one by hand

  Scenario: The entry for a book
    When I generate the entry for a book
    Then it should look like:
      """
      CSurname, Forename 1, and Forename 2 Surname 2, |Title| (Pub place: Publisher, Year)
      """

  Scenario: The entry for a chapter in a book
    When I generate the entry for a chapter
    Then it should look like:
      """
      BSurname, Forename 1, and Forename 2 Surname 2, 'Title' in |Book Title|, ed. by Editor, A.N. (Pub place: Publisher, Year)
      """

  Scenario: The entry for a journal article
    When I generate the entry for a journal article
    Then it should look like:
      """
      ASurname, Forename 1, and Forename 2 Surname 2, 'Title' |Journal Name|, Volume/Issue (Year), Pages
      """

  @wip
  Scenario: Getting the full bibliography
    Given I have some bibliography entries
    When I ask for the bibliography
    Then it should be ordered by surname alphabetically

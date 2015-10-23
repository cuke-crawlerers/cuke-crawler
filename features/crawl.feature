Feature: A quest
  As a mighty hero
  In order to win fame and glory
  I want to go on a quest

  Scenario: Crawl the dungeon
    Given I am at the entrance to the Acid Gate dungeon
    And I look around
    When I pick up the sword
    And I pick up the coloured sand
    And I go north
    And I look around
    And I attack the ghost
    And I look around
    And I take the cucumber
    And I go west
    And I look around
    And I attack the ghost
    Then my quest is complete

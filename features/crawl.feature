Feature: A quest
  As a mighty hero
  In order to win fame and glory
  I want to go on a quest

  Scenario: Crawl the dungeon
    Given I am at the entrance to the Acid Gate dungeon
    And I look around
    When I pick up the sword
    And I attack
    And I go north
    And I look around
    And I attack
    And I go north
    And I look around
    And I attack
    And I go west
    And I look around
    And I attack
    And I pick up the golden cucumber
    And I go east
    And I look around
    And I go south
    And I look around
    Then my quest is complete

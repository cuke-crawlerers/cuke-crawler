Feature: A quest
  As a mighty hero
  In order to win fame and glory
  I want to go on a quest

  Scenario: Crawl the dungeon
    Given I am at the entrance to the Acid Gate dungeon
    When I attack
    And I go west
    And I attack
    And I look around
    And I go north
    And I attack
    And I go north
    And I look around
    And I attack
    And I look at my inventory
    And I pick up the golden cucumber
    And I look at my inventory
    And my quest is complete

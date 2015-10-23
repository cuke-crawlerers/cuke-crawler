Feature: A quest
  As a mighty hero
  In order to win fame and glory
  I want to go on a quest

  Scenario: Crawl the Icky Spider dungeon
    Given I am at the entrance to the Icky Spider dungeon
    And I take the sword
    And I go north
    And I go west
    And I go north
    And I go east
    And I attack the spider
    And I take everything
    And I go east
    And I attack the ghost
    And I take everything
    And I go west
    And I go west
    And I go south
    And I go south
    And I attack the orc
    And I take everything
    And I look around
    Then my quest is complete

![Cuke Crawler](https://github.com/fauxparse/cuke-crawler/blob/master/cuke.png)

[![Build Status](https://travis-ci.org/cuke-crawlerers/cuke-crawler.svg?branch=master)](https://travis-ci.org/cuke-crawlerers/cuke-crawler)

# How to play

Create a new `.feature` in `features/`, and run with `cucumber --format DungeonMaster`:

```
Feature: A quest
  As a mighty hero
  In order to win fame and glory
  I want to go on a quest

  Scenario: Crawl the dungeon
    Given I am at the entrance to the dungeon
    # ...
    Then my quest is complete
```

Fill in the `...` to find the golden cucumber and emerge from the dungeon victorious!

![Sample steps](https://github.com/fauxparse/cuke-crawler/blob/master/sample.png)

Every day, there is a new dungeon to complete, each named with a new Pleasant Lawyer name.

module CukeCrawler
  LARGE_NUMBER = 0xabad1dea

  class RanIntoAWallError < Error; end
end

class String
  def bold_words
    split(" ").map(&:bold).join(" ")
  end
end

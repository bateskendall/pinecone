require "mechanize"
require "pry"

agent = Mechanize.new

page = agent.get("https://news.ycombinator.com/item?id=18589702")

page.search('.comment').each do |comment|
  # filter all comments that don't contain 'new york' or 'nyc'. 
  # Replace with whichever city you like.
  if comment.text.downcase.include?('new york') || comment.text.downcase.include?('nyc')
    puts comment.text
    binding.pry
  end
end
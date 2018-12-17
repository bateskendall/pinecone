require "mechanize"
require "pry"

agent = Mechanize.new
page = agent.get("https://news.ycombinator.com/item?id=18589702")

# Search for elements with 'comment' class name
loop do
  page.search('.comment').each do |comment|
    # filter all comments that don't contain 'new york' or 'nyc'. 
    # Replace with whichever city you like.
    if comment.text.downcase.include?('new york') || comment.text.downcase.include?('nyc')
      puts comment.text
    end
  end
  
  # if there are more comments, go to next page
  if link = page.link_with(:text => 'More')
    page = link.click
  else
    break
  end
end
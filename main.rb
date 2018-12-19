require "mechanize"
require "pry"
require "csv"
require "./job.rb"

agent = Mechanize.new
page = agent.get("https://news.ycombinator.com/item?id=18589702")

loop do
  # Search for elements with 'comment' class name
  page.search('.comment').each do |comment|
    # filter all comments that don't contain 'new york' or 'nyc'. 
    # Replace with whichever city you like.
    if comment.text.include?(' | ') && ( comment.text.downcase.include?('new york') || comment.text.downcase.include?('nyc') )
        
        # Get job from the comment text. Split into "company" and "employer"
        job = Job.new(comment)
        
        # save results to .csv file
        job.send_to_csv
    end
  end
  
  # if there are more comments, go to next page
  if link = page.link_with(:text => 'More')
    page = link.click
  else
    break
  end
end
require "mechanize"
require "pry"
require "csv"

agent = Mechanize.new
page = agent.get("https://news.ycombinator.com/item?id=18589702")

loop do
  # Search for elements with 'comment' class name
  page.search('.comment').each do |comment|
    # filter all comments that don't contain 'new york' or 'nyc'. 
    # Replace with whichever city you like.
    if comment.text.downcase.include?('new york') || comment.text.downcase.include?('nyc')
      if comment.text.include?(' | ')
        # split comment text into 'company' and 'description'
        job = {company: comment.text.split("|").first.strip, description: comment.text.partition('|').last.strip}
        
        # save results to .csv file
        CSV.open('job_info.csv', 'a+') do |csv|
          csv << [job[:company], job[:description]]
        end
      end
    end
  end
  
  # if there are more comments, go to next page
  if link = page.link_with(:text => 'More')
    page = link.click
  else
    break
  end
end
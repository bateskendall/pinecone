class Job
  def initialize(comment)
    @job = { company:     comment.text.split("|").first.strip, 
             description: comment.text.partition('|').last.strip }
  end
  
  def send_to_csv
    CSV.open('job_info.csv', 'a+') { |csv| csv << [@job[:company], @job[:description]] }
  end
end
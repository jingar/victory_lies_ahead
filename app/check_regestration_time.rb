class CheckRegestrationTime < ActiveRecord::Base
  
  start_date = Date.new(2013,3,7)
  end_date = Date.new(2013,3,8)
  now = Time.now
  
  if now >= start_date && now <= end_date
    output = File.open( "outputfile.yml", "w" )
    output << "Here I am writing to a new file"
    output.close  
  else
    puts "out of time"
  end
end

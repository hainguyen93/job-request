module JobsHelper

  # print out the job deadline, compare to current time
  def deadline_to_today(deadline)
    if (deadline >= Time.now)
      "<span style='color: green;'> #{ distance_of_time_in_words(Time.now, deadline, true, :highest_measures => 2)} left</span>".html_safe
    else
      "<span style='color: red;'> #{ distance_of_time_in_words(deadline, Time.now, true, :highest_measures => 2) } ago</span>".html_safe
    end
  end
  
  def alert_overdue?
    flag = false   
    current_user.jobs.each do |smth|
      if smth.deadline.utc < Time.now.utc && (smth.status.casecmp "done") != 0
        flag = true        
      end
    end    
    flag   #return value
  end
  
		
  def alert_deadlines?
    flag = false
    current_user.jobs.each do |smth|
      if smth.deadline.utc < (Time.now + 3.days).utc && (smth.status.casecmp "done") != 0 && !(smth.deadline.utc < Time.now.utc)
	flag = true
      end
    end
    flag   #return value
  end

  
end

module ApplicationHelper
  
  # dynamically display the title for different pages
  def page_title(title='')
    base = "Job Request System"
    if title.empty?
      base
    else 
      "#{title} | #{base}"
    end
  end  

end

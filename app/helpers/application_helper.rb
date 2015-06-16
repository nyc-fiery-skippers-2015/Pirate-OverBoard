module ApplicationHelper
  def pirate_time( datetime )
    datetime.strftime("%B %d, %Y")
  end
end

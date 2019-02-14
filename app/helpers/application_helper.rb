module ApplicationHelper
  def time_string(time)
    time.to_s[0..7].split(":").zip(['hours','minutes','seconds']).join(" ")
  end
end

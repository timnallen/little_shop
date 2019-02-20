module ApplicationHelper
  def time_string(time)
    labels = ['hours','minutes','seconds']
    if time.include?(":")
      time.to_s[0..7].split(":").map.with_index do |time, index|
        "#{time} #{labels[index]} "
      end.join("").rstrip
    else
      time
    end
  end
end

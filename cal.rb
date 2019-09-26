require "erb"
require "time"

def cal_month(timestamp)
  year, month, day = timestamp.split("-")
  t = Time.new(year, month, day)
  month_name = t.strftime("%B")
  end_day = (Time.new(t.year, t.month + 1) - 1).day
  start_day = Time.new(t.year, t.month, 1).wday
  pad = t.wday
  end_pad = 6 - Time.new(t.year, t.month, end_day).wday

  padded_month = Array.new
  start_day.times { |n| padded_month << "-" }
  (1..end_day).to_a.each { |day| padded_month << day.to_s }
  end_pad.times { |n| padded_month << "-" }
  return month_name, padded_month.each_slice(7).to_a
end

month, cal = cal_month(ARGV[0])

output = ERB.new(File.read("./index.erb")).result(binding)
File.write("./index.html", output)

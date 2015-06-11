require "csv"

# Usage: ruby parse-iis.rb <log_file>

log_file = ARGV.shift

src_ip_addrs = []

CSV.foreach(log_file, col_sep: " ") do |row|
    puts row.inspect if $DEBUG
    src_ip_addrs << row[2] unless row.first =~ /^#/
end

src_ip_addrs.sort!

src_ip_counts = Hash.new(0)
src_ip_addrs.each { |ip| src_ip_counts[ip] += 1 }
sorted_counts = src_ip_counts.sort_by { |ip, count| count }.reverse!

puts "%-15s %s" % [ "Src IP Addr", "Count" ]
sorted_counts.each do |ip, count|
    puts "%-15s %d" % [ ip, count ]
end


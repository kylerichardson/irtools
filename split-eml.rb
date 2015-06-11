#!/usr/bin/env ruby

# Usage: ruby split-eml.rb <dir_of_eml_files> [output_dir]

input_dir = ARGV.shift
output_dir = ARGV.shift
unless output_dir
    output_dir = input_dir
end

eml_files = []
Dir.foreach(input_dir) do |file_name|
    if file_name !~ /^\./
        eml_files << file_name
    end
end

puts eml_files.inspect if $DEBUG

eml_files.each do |file_name|
    puts "Input File: #{input_dir}#{file_name}" if $DEBUG
    lines = File.readlines("#{input_dir}#{file_name}")
    while true
        puts lines[0] if $DEBUG
        if lines[0] !~ /^>From/
            lines.shift
        else
            lines.shift
            break
        end
    end
    out_file = File.new("#{output_dir}alt-#{file_name}", "w")
    lines.each do |line|
        out_file.write(line)
    end
    out_file.close
end


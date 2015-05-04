#!/usr/bin/python2

# Simple utility function to normailze date
# from logged time to local time. Assumes
# log was generated in CTC (Chicago).

from dateutil.tz import tzstr, tzlocal

def bc_date_to_local(logdate):
    logdate = logdate.replace(tzinfo=tzstr("CST6CDT"))
    return logdate.astimezone(tzlocal())

# Read in the raw log file and write out
# a new CSV file with localized date and
# time and normalized URL (remove commas
# and special characters).

import sys
import csv
from dateutil.parser import parse
from urllib import quote_plus

infile = open(sys.argv[1], 'r')
reader = csv.reader(infile)
outfile = open(sys.argv[1]+".out", 'w')
writer = csv.writer(outfile)

# Write the header row
header = reader.next()
header[0] = "Date"
header.insert(1, "Time")
writer.writerow(header)

for row in reader:
    logdate = bc_date_to_local(parse(row[0]))
    row[0] = logdate.strftime("%Y-%m-%d")
    row.insert(1, logdate.strftime("%X"))
    row[2] = quote_plus(row[2])
    writer.writerow(row)

infile.close()
outfile.close()

#!/usr/bin/python3

import sys
import geoip2.database

MAX_MIND_DB = 'GeoLite2-City.mmdb'

if len(sys.argv) != 2:
    sys.exit('usage: python3 ' + sys.argv[0] + ' <ipaddr>')

query_ip = sys.argv[1]
reader = geoip2.database.Reader(MAX_MIND_DB)
response = reader.city(query_ip)

output = query_ip + ': ' + response.city.name + ', ' + \
    response.subdivisions.most_specific.iso_code + ' ' + \
    response.postal.code + ' ' + response.country.iso_code

print(output)

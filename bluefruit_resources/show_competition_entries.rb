#!/usr/bin/env ruby

# A ruby script to display the entries to the competition.
# This script outputs to a TSV style format so it can be
# imported into a spreadsheet easily

require_relative '../admin_scripts/lib_domain'

dojo = create_dojo

competition = dojo.competition

puts "id\tfullname\temail\tpublish\tcareer\tnews\tage\tip\ttime"
competition.each do |entry|
	puts entry[:id] + "\t" + entry[:fullname] + "\t" + entry[:email] + "\t" + entry[:publish] + "\t" + entry[:career] + "\t" + entry[:news] + "\t" + entry[:age] + "\t" + entry[:ip] + "\t" + entry[:time]
end


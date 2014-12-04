#!/usr/bin/env ruby

require '/var/www/cyber-dojo/admin_scripts/lib_domain'

dojo = create_dojo

dojo.katas.each do |kata|
  avatars = kata.avatars
  avatars.each do |avatar|
    print kata.id + ":"
    if avatar.exists? then
      begin
        lights = avatar.lights
        lights.each do |light|
          case light.colour
          when :red
            print "R"
          when :amber
            print "A"
          when :green
            print "G"
          else
            print "?"
          end
        end
        puts
        #puts lights.inspect
      rescue Exception => error
        puts "Error"
      end
    end # if avatar.exists
  end
end

# brew aliasapps
#
# Aliases any Applications (.app) found in installed prefixes to
# /Applications/HomebrewAliases
#
# Adapted from brew linkapps
# https://github.com/Homebrew/homebrew/blob/master/Library/Homebrew/cmd/linkapps.rb
#
# Depends on:
# - https://github.com/Homebrew/homebrew/blob/master/Library/Formula/trash.rb
# - https://github.com/alphabetum/aliasapp/
require 'keg'

target_dir = File.join(ENV['HOME'], "/Applications/HomebrewAliases")

if File.exist? target_dir
  system "trash", target_dir
end
# Homebrew overrides FileUtils.mkdir, so calling system command directly.
system "mkdir", "-p", target_dir


HOMEBREW_CELLAR.subdirs.each do |rack|
  kegs = rack.subdirs.map { |d| Keg.new(d) }
  next if kegs.empty?

  keg = kegs.detect(&:linked?) || kegs.max {|a,b| a.version <=> b.version}

  Dir["#{keg}/*.app", "#{keg}/bin/*.app", "#{keg}/libexec/*.app"].each do |app|
    puts "Aliasing #{app}"
    app_name = File.basename(app)
    target = File.join(target_dir, app_name)

    system "aliasapp", app, target
  end
end

puts "Finished aliasing. Find the alias applications under #{target_dir}."


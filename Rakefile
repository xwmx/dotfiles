desc "List dotfile status (i = identical, e = a file exists, x = no file eixsts). " +
     "'@' suffixes denote existing symlinks."
task :status do |t|
  Dotfile.all.each do |file|

    source = Dotfile.source(file)
    target = Dotfile.target(file)

    if File.exists?(target) && File.identical?(source, target)
      status = "i  "
    elsif File.exists?(target)
      status = " e "
    else
      status = "  x"
    end
    symlink_status = "@" if File.symlink?(target)
    puts "#{status} #{file}#{symlink_status}"
  end
end

desc "List dotfile.bak status (i = identical, e = a file exists, x = no file eixsts). " +
     "'@' suffixes denote existing symlinks."
task :bak_status do |t|
  Dotfile.all.each do |file|

    source = Dotfile.source(file)
    target = Dotfile.target("#{file}.bak")

    if File.exists?(target) && File.identical?(source, target)
      status = "i  "
    elsif File.exists?(target)
      status = " e "
    else
      status = "  x"
    end

    puts "#{status} #{file}"
  end
end


desc "Remove dotfile links in home directory with status 'i'"
task :clean do |t|
  Dotfile.all.each do |file|

    source = Dotfile.source(file)
    target = Dotfile.target(file)

    if Dotfile.is_linked?(source, target)
      puts "Removing linked file: #{target}"
      File.delete(target)
    end
  end
end

desc "Remove dotfiles from home directory with status 'i' (via clean task), backs up files with status 'e'"
task :clear => [:clean] do |t|
  Dotfile.all.each do |file|

    source = Dotfile.source(file)
    target = Dotfile.target(file)

    if File.exists?(target) && !File.identical?(source, target)
      puts "Backing up file: #{target}"
      File.rename(target,"#{target}.bak")
    end
  end
end

desc "Link dotfiles to home directory. List files skipped."
task :link do |t|
  existing = []
  Dotfile.all.each do |file|

    source = Dotfile.source(file)
    target = Dotfile.target(file)

    if File.exists?(target)
      existing << file
    else
      puts "Linking #{source} => #{target}"
      File.symlink(source, target)
    end
  end
  unless existing.empty?
    puts %Q|Already present:\n#{existing.join("\n")}|
  end
end

desc "Configure OS X Preferences"
task :osx do |t|
  puts %x[./script/packages/osx.sh]
end

desc "Update Homebrew and Homebrew Cask"
task :brew do |t|
  puts %x[./script/packages/brew.sh]
end

desc "Update npm global modules"
task :npm do |t|
  puts %x[./script/packages/npm.sh]
end

desc "Update Homebrew custom icons"
task :customize_icons do |t|
  puts %x[./script/customizations/customize_icons.rb]
end

desc "Update submodules"
task :update_submodules do |t|
  git_command = "git submodule foreach git pull"
  puts git_command
  puts %x[#{git_command}]
end

module Dotfile
  module Directory
    def self.source
      File.join(File.dirname(__FILE__), 'home')
    end

    def self.target
      Dir.home
    end
  end

  def self.source(file)
    File.join(Dotfile::Directory.source, file)
  end

  def self.target(file)
    File.join(Dotfile::Directory.target, file)
  end

  def self.all
    dotfiles = Dir.entries(Dotfile::Directory.source)

    dotfiles -= %w(. ..)
  end

  def self.is_linked?(source, target)
    File.exists?(target) &&
      File.symlink?(target) &&
      File.identical?(source, target)
  end
end


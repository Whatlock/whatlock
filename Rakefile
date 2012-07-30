require 'rake'

namespace :whatcd do
  THREAD_URL = "https://ssl.what.cd/forums.php?action=viewthread&threadid=88089"
  THREAD_REPLY_URL = "#{THREAD_URL}#quickpostform"

  desc "Open What.CD thread URL for Whatlock because karlbright is lazy..."
  task :thread do
    system %Q{open -a "/Applications/Google Chrome.app" "#{THREAD_URL}"}
  end

  namespace :thread do
    desc "Open What.CD thread ready for reply. Useful for a new release"
    task :reply do
      system %Q{open -a "/Applications/Google Chrome.app" "#{THREAD_REPLY_URL}"}
    end
  end
end

namespace :stylesheet do
  COMPASS_CONFIG = File.join(File.dirname(__FILE__), 'compass.rb')

  desc "Build stylesheet"
  task :build do
    system %Q{compass compile -e development --force}
  end

  desc "Watch stylesheet for changes and build automatically."
  task :watch do
    system %Q{compass watch -e development --force}
  end

  desc "Build stylesheet with compressed output, copy to server and open thread for comment"
  task :release do
    system %Q{compass compile -e production --force}
    # SCP stylesheet to server
    # Backup previous stylesheet
    # Bump version number?
    Rake::Task['whatcd:thread:reply'].invoke
  end
end

namespace :pow do
  POW_DIR   = File.join(ENV['HOME'], '.pow')

  desc "Initialise public directory and symlink to $HOME/.pow directory"
  task :setup do
    if File.exists?(POW_DIR) and File.directory?(POW_DIR)
      Rake::Task['stylesheet:build'].invoke
      system %Q{rm -rf "$PWD/public"}
      system %Q{rm "$HOME/.pow/whatlock"}
      system %Q{mkdir "$PWD/public"}
      system %Q{ln -s "$PWD/build/whatlock.css" "$PWD/public/whatlock.css"}
      system %Q{ln -s "$PWD" "$HOME/.pow/whatlock"}
    else
      puts "Doesn't look like you have Pow installed. It can be installed from http://pow.cx/"
    end
  end
end

namespace :dotjs do
  DOTJS_DIR     = File.join(ENV['HOME'], '.js')
  ORIGINAL_FILE = "what.cd.js"

  desc "Symlink dotjs for both ssl and non-ssl domains to your $HOME/.js directory"
  task :symlink do
    Rake::Task['dotjs:symlink:nonssl'].invoke
    Rake::Task['dotjs:symlink:ssl'].invoke
  end

  namespace :symlink do
    desc "Symlink dotjs file to what.cd.js in your $HOME/.js directory"
    task :nonssl do
      symlink_dotjs_file_to 'what.cd.js'
    end

    desc "Symlink dotjs file to ssl.what.cd.js in your $HOME/.js directory"
    task :ssl do
      symlink_dotjs_file_to 'ssl.what.cd.js'
    end
  end
end

def symlink_dotjs_file_to(renamed)
  if File.exists?(DOTJS_DIR) and File.directory?(DOTJS_DIR)
    if File.exist? File.join(ENV['HOME'], '.js', renamed)
      puts "File already exists: #{ENV['HOME']}/.js/#{renamed} - overwrite it?"
      puts "(y)es or (n)o?"
      case $stdin.gets.chomp
      when 'y'
        system %Q{rm "$HOME/.js/#{renamed}"}
        system %Q{ln -s "$PWD/#{ORIGINAL_FILE}" "$HOME/.js/#{renamed}"}
        puts "#{ORIGINAL_FILE} => #{renamed}"
      when 'n'
        puts "Exiting. No files were modified."
        exit
      end
    else
      system %Q{ln -s "$PWD/#{ORIGINAL_FILE}" "$HOME/.js/#{renamed}"}
      puts "#{ORIGINAL_FILE} => #{renamed} successful"
    end
  else
    puts "Doesn't look like you have dotjs installed. It can be installed from http://defunkt.io/dotjs/"
  end
end

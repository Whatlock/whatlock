require 'rake'

namespace :dotjs do

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
  if File.exist? File.join(ENV['HOME'], '.js', renamed)
    puts "File already exists: #{ENV['HOME']}/.js/#{renamed} - overwrite it?"
    puts "(y)es or (n)o?"
    case $stdin.gets.chomp
    when 'y'
      system %Q{rm "$HOME/.js/#{renamed}"}
      system %Q{ln -s "$PWD/#{original_file}" "$HOME/.js/#{renamed}"}
      puts "#{original_file} => #{renamed}"
    when 'n'
      puts "Exiting. No files were modified."
      exit
    end
  else
    system %Q{ln -s "$PWD/#{original_file}" "$HOME/.js/#{renamed}"}
    puts "#{original_file} => #{renamed} successful"
  end
end

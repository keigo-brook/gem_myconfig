require 'mygem'
require 'mygem/command'

module Mygem
  class Command < Thor
    desc 'config', 'change settings'
    def config
      config_path = Dir.home + '/.mygem'
      if Dir.exists?(config_path)
        puts "Your current name is [#{Mygem.config[:name]}]."
      else
        Dir.mkdir(config_path)
        yml_path = Mygem.get_config_path + '/settings.yml '
        File.open(yml_path, 'w').close
      end

      print 'Input your name: '
      loop do
        s = $stdin.gets.chomp!
        if s.size != 0
          Mygem.configure(name: s)
          break
        else
          puts 'Invalid Name. please try again:'
        end
      end
      puts "Update Your name to [#{Mygem.config[:name]}]."
    end
  end
end

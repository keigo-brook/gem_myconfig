require 'mygem'
require 'mygem/command'

module Mygem
  class Command < Thor
    desc 'hello', 'Say Hello!'
    def hello
      puts "Hello!, #{Mygem.config[:name]}"
    end
  end
end

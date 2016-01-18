require 'mygem'
require 'mygem/command'

module Mygem
  class Command < Thor
    desc 'hello', 'Say Hello!'
    def hello
      puts 'Hello!'
    end
  end
end

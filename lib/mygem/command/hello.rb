require 'mygem'
require 'mygem/command'

module Mygem 
    class Command < Thor
        desc 'f', 'f'
        def f
            puts 21
        end
    end
end

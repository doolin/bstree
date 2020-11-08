# frozen_string_literal: true

require_relative './tree'
require_relative './node'

class Generator
  class << self
    def build(nodes)
      tree = Tree.new(Node.new(nodes.shift))
      nodes.each { |n| tree.insert(Node.new(n)) }
      tree
    end

    def tree1
      Generator.build [11]
    end

    def tree2
      Generator.build [11, 7]
    end

    def tree3
      Generator.build [11, 7, 13]
    end

    def tree4
      Generator.build [11, 7, 5]
    end

    def tree5
      Generator.build [5, 7, 11]
    end

    def tree6
      Generator.build [11, 5, 3, 7, 13]
    end

    def tree7
      Generator.build [5, 3, 11, 7, 13]
    end

    def tree8
      Generator.build [11, 5, 3, 7, 17, 13, 19]
    end

    def tree9
      Generator.build [19, 23, 13, 17, 11, 5, 7]
    end

    def tree10
      Generator.build [11, 5, 3, 19, 17, 29, 23, 41, 37, 53]
    end

    # These could go into yaml files in spec/fixtures, or even in a
    # globally accessible file for use by all implementations.
    def tree213
      Generator.build [2, 1, 3]
    end

    def tree123
      Generator.build [1, 2, 3]
    end

    def tree132
      Generator.build [1, 3, 2]
    end

    def tree321
      Generator.build [3, 2, 1]
    end

    def tree312
      Generator.build [3, 1, 2]
    end
  end
end

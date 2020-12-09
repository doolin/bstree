# frozen_string_literal: true

require_relative './tree'
require_relative './node'

class Generator
  class << self
    def build(nodes, uuid)
      tree = Tree.new(Node.new(nodes.shift, uuid))
      nodes.each { |n| tree.insert(Node.new(n, uuid)) }
      tree
    end

    def tree1(uuid = nil)
      Generator.build [11], uuid
    end

    def tree2(uuid = nil)
      Generator.build [11, 7], uuid
    end

    def tree3(uuid = nil)
      Generator.build [11, 7, 13], uuid
    end

    def tree4(uuid = nil)
      Generator.build [11, 7, 13, 3], uuid
    end

    def tree5(uuid = nil)
      Generator.build [11, 7, 13, 3, 19], uuid
    end

    def tree6(uuid = nil)
      Generator.build [11, 7, 13, 3, 19, 29], uuid
    end

    def tree7(uuid = nil)
      Generator.build [11, 7, 13, 3, 19, 29, 5], uuid
    end

    def tree8(uuid = nil)
      Generator.build [11, 7, 13, 3, 19, 29, 5, 2], uuid
    end

    def tree9(uuid = nil)
      Generator.build [11, 7, 13, 3, 19, 29, 5, 2, 17], uuid
    end

    def tree10(uuid = nil)
      Generator.build [11, 7, 13, 3, 19, 29, 5, 2, 17, 23], uuid
    end

    # These could go into yaml files in spec/fixtures, or even in a
    # globally accessible file for use by all implementations.
    def tree213(uuid = nil)
      Generator.build [2, 1, 3], uuid
    end

    def tree123(uuid = nil)
      Generator.build [1, 2, 3], uuid
    end

    def tree132(uuid = nil)
      Generator.build [1, 3, 2], uuid
    end

    def tree321(uuid = nil)
      Generator.build [3, 2, 1], uuid
    end

    def tree312(uuid = nil)
      Generator.build [3, 1, 2], uuid
    end
  end
end

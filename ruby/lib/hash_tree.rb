# frozen_string_literal: true

require 'digest'

# First crack at a hash tree.
class HashTree
  # A node in the tree.
  class Node
    attr_accessor :key, :left, :right, :parent
  end

  attr_accessor :root, :documents, :hashes

  def initialize
    @documents = []
    @hashes = []
  end

  def insert(document)
    @documents << document
  end

  def rehash
    @documents.each do |document|
      @hashes << Digest::SHA256.hexdigest(document)
    end
  end
end

# frozen_string_literal: true

RSpec.describe Tree do
  def node_pointers_nil?(node)
    node.left.nil? && node.right.nil? && node.parent.nil?
  end

  describe 'transplant' do
    it 'transplants right child into root' do
      root = Node.new 17
      tree = described_class.new root
      n23 = Node.new 23

      tree.transplant(root, n23)
      expect(tree.root).to eq n23
      expect(n23.parent).to be_nil
    end

    it 'transplants left child into root' do
      root = Node.new 17
      tree = described_class.new root
      n5 = Node.new 5
      tree.insert n5
      tree.transplant(root, n5)
      expect(tree.root).to eq n5
      expect(n5.parent).to be_nil
    end

    it 'transplants left child' do
      root = Node.new 17
      tree = described_class.new root
      n5 = Node.new 5
      n7 = Node.new 7
      tree.insert n5
      tree.insert n7

      tree.transplant(n5, n7)
      expect(n7.parent).to eq tree.root
      expect(tree.root.left).to eq n7
    end

    it 'transplants right child' do
      root = Node.new 17
      tree = described_class.new root
      n23 = Node.new 23
      n29 = Node.new 29
      tree.insert n23
      tree.insert n29

      tree.transplant(n23, n29)
      expect(n29.parent).to eq tree.root
      expect(tree.root.right).to eq n29
    end
  end

  describe 'delete_by_key' do
    describe 'delete root node' do
      it 'deletes root with no children' do
        root = Node.new 17
        tree = described_class.new root
        expect(tree.delete_by_key(17)).to eq root
        expect(tree.root.nil?).to be true
        expect(tree.size).to eq 0
        expect(tree.height).to eq 0
        expect(tree.list_keys).to eq []
      end

      it 'deletes root with left child' do
        root = Node.new 17
        tree = described_class.new root
        n5 = Node.new 5
        tree.insert n5
        expect(tree.delete_by_key(17)).to eq root
        expect(tree.root).to eq n5
        expect(tree.size).to eq 1
        expect(tree.height).to eq 0
        expect(tree.list_keys).to eq [5]
      end

      it 'deletes root with right child' do
        root = Node.new 17
        tree = described_class.new root
        n23 = Node.new 23
        tree.insert n23
        expect(tree.delete_by_key(17)).to eq root
        expect(tree.root).to eq n23
        expect(tree.size).to eq 1
        expect(tree.height).to eq 0
        expect(tree.list_keys).to eq [23]
      end

      it 'deletes root with left and right children' do
        root = Node.new 17
        tree = described_class.new root
        n23 = Node.new 23
        n5 = Node.new 5
        tree.insert n23
        tree.insert n5
        expect(tree.delete_by_key(17)).to eq root
        expect(tree.root).to eq n23
        expect(tree.root.left).to eq n5
        expect(n5.parent).to eq n23
        expect(tree.size).to eq 2
        expect(tree.height).to eq 1
        expect(tree.list_keys).to eq [5, 23]
      end
    end

    it 'deletes left node with no children in two node tree' do
      root = Node.new 17
      tree = described_class.new root
      n5 = Node.new 5
      tree.insert n5
      expect(tree.delete_by_key(5)).to eq n5
      expect(tree.root.nil?).to be false
      expect(tree.root.left).to be_nil
      expect(tree.root.right).to be_nil
      expect(tree.size).to eq 1
      expect(tree.height).to eq 0
      expect(tree.list_keys).to eq [17]
    end

    it 'deletes left node with left child in three node tree' do
      root = Node.new 17
      tree = described_class.new root
      n5 = Node.new 5
      tree.insert n5
      n3 = Node.new 3
      tree.insert n3
      expect(tree.delete_by_key(5)).to eq n5
      expect(tree.root.nil?).to be false
      expect(tree.root.left).to be n3
      expect(tree.root.right).to be_nil
      expect(tree.size).to eq 2
      expect(tree.height).to eq 1
      expect(tree.list_keys).to eq [3, 17]
    end

    it 'deletes left node with right child in three node tree' do
      root = Node.new 17
      tree = described_class.new root
      n5 = Node.new 5
      tree.insert n5
      n7 = Node.new 7
      tree.insert n7
      expect(tree.delete_by_key(5)).to eq n5
      expect(tree.root.nil?).to be false
      expect(tree.root.left).to be n7
      expect(tree.root.right).to be_nil
      expect(tree.size).to eq 2
      expect(tree.height).to eq 1
      expect(tree.list_keys).to eq [7, 17]
    end

    it 'deletes right node with no children in two node tree' do
      root = Node.new 17
      tree = described_class.new root
      n23 = Node.new 23
      tree.insert n23
      expect(tree.delete_by_key(23)).to eq n23
      expect(tree.root.nil?).to be false
      expect(tree.root.left).to be_nil
      expect(tree.root.right).to be_nil
      expect(tree.size).to eq 1
      expect(tree.height).to eq 0
      expect(tree.list_keys).to eq [17]
    end

    it 'deletes right node with left child in three node tree' do
      root = Node.new 17
      tree = described_class.new root
      n23 = Node.new 23
      tree.insert n23
      n19 = Node.new 19
      tree.insert n19
      expect(tree.delete_by_key(23)).to eq n23
      expect(tree.root.nil?).to be false
      expect(tree.root.right).to be n19
      expect(tree.root.left).to be_nil
      expect(tree.size).to eq 2
      expect(tree.height).to eq 1
      expect(tree.list_keys).to eq [17, 19]
    end

    it 'deletes right node with right child in three node tree' do
      root = Node.new 17
      tree = described_class.new root
      n23 = Node.new 23
      tree.insert n23
      n29 = Node.new 29
      tree.insert n29
      expect(tree.delete_by_key(23)).to eq n23
      expect(tree.root.nil?).to be false
      expect(tree.root.right).to be n29
      expect(tree.root.left).to be_nil
      expect(tree.size).to eq 2
      expect(tree.height).to eq 1
      expect(tree.list_keys).to eq [17, 29]
    end

    describe 'nodes with 2 children' do
      describe 'left children' do
        it 'deletes a node with a single child subtree successor' do
          root = Node.new 17
          n5 = Node.new 5
          n3 = Node.new 3
          n7 = Node.new 7
          tree = described_class.new root
          tree.insert n5
          tree.insert n7
          tree.insert n3

          expect(tree.delete_by_key(5)).to eq n5
          expect(tree.root.nil?).to be false
          expect(tree.root.left).to eq n7
          expect(n7.parent).to eq tree.root # .left
          expect(n7.left).to eq n3
          expect(n3.parent).to eq n7
          expect(tree.root.right).to be_nil

          expect(tree.size).to eq 3
          expect(tree.height).to eq 2
          expect(tree.list_keys).to eq [3, 7, 17]
        end

        it 'deletes a node with a two child subtree successor' do
          root = Node.new 17
          n5 = Node.new 5
          n3 = Node.new 3
          n7 = Node.new 7
          n6 = Node.new 6
          tree = described_class.new root
          tree.insert n5
          tree.insert n7
          tree.insert n6
          tree.insert n3
          expect(tree.list_keys).to eq [3, 5, 6, 7, 17]
          expect(tree.delete_by_key(5)).to eq n5
          expect(tree.root.nil?).to be false
          expect(tree.root.left).to be n6
          expect(tree.root.right).to be_nil
          expect(tree.size).to eq 4
          expect(tree.height).to eq 2
          expect(tree.list_keys).to eq [3, 6, 7, 17]
        end

        it 'deletes a node with many children in subtree successor' do
          root = Node.new 17
          n5 = Node.new 5
          n3 = Node.new 3
          n7 = Node.new 7
          n8 = Node.new 8
          n11 = Node.new 11
          n12 = Node.new 12
          n10 = Node.new 10

          tree = described_class.new root
          tree.insert n5
          tree.insert n3
          tree.insert n11
          tree.insert n12
          tree.insert n7
          tree.insert n8
          tree.insert n10
          expect(tree.list_keys).to eq [3, 5, 7, 8, 10, 11, 12, 17]
          expect(tree.height).to eq 5
          expect(tree.delete_by_key(5)).to eq n5
          expect(tree.root.left).to be n7
          expect(tree.root.right).to be_nil
          expect(tree.size).to eq 7
          expect(tree.height).to eq 4
          expect(tree.list_keys).to eq [3, 7, 8, 10, 11, 12, 17]

          expect(tree.delete_by_key(7)).to eq n7
          expect(tree.root.left).to be n8
          expect(tree.size).to eq 6
          expect(tree.height).to eq 3
          expect(tree.list_keys).to eq [3, 8, 10, 11, 12, 17]
        end
      end

      describe 'right children' do
        it 'deletes a node with a single child subtree successor' do
          root = Node.new 17
          n23 = Node.new 23
          n19 = Node.new 19
          n29 = Node.new 29
          tree = described_class.new root
          tree.insert n23
          tree.insert n19
          tree.insert n29
          expect(tree.delete_by_key(23)).to eq n23
          expect(tree.root.nil?).to be false
          expect(tree.root.right).to be n29
          expect(tree.root.left).to be_nil
          expect(tree.size).to eq 3
          expect(tree.height).to eq 2
          expect(tree.list_keys).to eq [17, 19, 29]
        end

        # This is for just the right side.
        it 'deletes nodes on the right of root with mongo subtrees' do
          root = Node.new 17
          n23 = Node.new 23
          n19 = Node.new 19
          n29 = Node.new 29
          n20 = Node.new 20
          n21 = Node.new 21
          n22 = Node.new 22

          tree = described_class.new root
          tree.insert n23
          tree.insert n19
          tree.insert n29
          tree.insert n21
          tree.insert n20
          tree.insert n22

          expect(tree.list_keys).to eq [17, 19, 20, 21, 22, 23, 29]

          expect(tree.delete_by_key(23)).to eq n23
          expect(node_pointers_nil?(n23)).to be true
          expect(tree.root.nil?).to be false
          expect(tree.root.right).to be n29
          expect(tree.root.left).to be_nil
          expect(tree.size).to eq 6
          expect(tree.height).to eq 4
          expect(tree.list_keys).to eq [17, 19, 20, 21, 22, 29]
        end
      end

      describe 'mongo delete' do
        it 'deletes all the nodes from a mongo-sized tree' do
          root = Node.new 17
          n5 = Node.new 5
          n3 = Node.new 3
          n7 = Node.new 7
          n8 = Node.new 8
          n11 = Node.new 11
          n12 = Node.new 12
          n10 = Node.new 10
          n23 = Node.new 23
          n19 = Node.new 19
          n29 = Node.new 29
          n20 = Node.new 20
          n21 = Node.new 21
          n22 = Node.new 22

          tree = described_class.new root
          tree.insert n5
          tree.insert n3
          tree.insert n11
          tree.insert n12
          tree.insert n7
          tree.insert n8
          tree.insert n10
          tree.insert n23
          tree.insert n19
          tree.insert n29
          tree.insert n21
          tree.insert n20
          tree.insert n22

          expect(tree.root.right).to be n23
          expected = [3, 5, 7, 8, 10, 11, 12, 17, 19, 20, 21, 22, 23, 29]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected
          expect(tree.height).to eq 5
          expect(tree.delete_by_key(5)).to eq n5
          expect(node_pointers_nil?(n5)).to be true
          expect(tree.root.left).to be n7
          expect(n7.left).to eq n3
          expect(n3.parent).to be n7
          expect(n7.right).to eq n11
          expect(n11.parent).to eq n7
          expect(tree.size).to eq 13
          expect(tree.height).to eq 4
          expected = [3, 7, 8, 10, 11, 12, 17, 19, 20, 21, 22, 23, 29]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.delete_by_key(7)).to eq n7
          expect(tree.root.left).to be n8
          expect(n8.left).to eq n3
          expect(n3.parent).to be n8

          expect(n8.right).to eq n11
          expect(n11.parent).to be n8
          expect(tree.size).to eq 12
          expect(tree.height).to eq 4
          expected = [3, 8, 10, 11, 12, 17, 19, 20, 21, 22, 23, 29]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.delete_by_key(29)).to eq n29
          expect(n23.right).to be_nil
          expect(tree.size).to eq 11
          expected = [3, 8, 10, 11, 12, 17, 19, 20, 21, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected
          expect(tree.delete_by_key(3)).to eq n3
          expect(n8.left).to be_nil
          expect(n3.left).to be_nil
          expect(n3.right).to be_nil
          expect(node_pointers_nil?(n3)).to be true
          expect(tree.size).to eq 10
          expected = [8, 10, 11, 12, 17, 19, 20, 21, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          # n21 still has 2 children
          expect(n21.parent).to eq n19
          expect(n21.left).to eq n20
          expect(n21.right).to eq n22
          expect(tree.delete_by_key(21)).to eq n21

          expect(tree.size).to eq 9

          expect(n19.right).to eq n22
          expect(n19.left).to be_nil
          expect(n22.left).to eq n20
          expect(n20.parent).to eq n22
          expect(n22.parent).to eq n19
          expect(n22.left).to eq n20
          expect(n22.right).to be_nil
          expected = [8, 10, 11, 12, 17, 19, 20, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.root.left).to be n8
          expect(tree.root.right).to be n23
          expect(tree.delete_by_key(17)).to eq root
          expect(tree.root).to eq n19
          expect(n19.parent).to be_nil
          expect(n19.left).to eq n8
          expect(n8.parent).to eq n19
          expect(n19.right).to eq n23
          expect(n23.left).to eq n22
          expect(n23.parent).to eq n19
          expected = [8, 10, 11, 12, 19, 20, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(n12.left).to be_nil
          expect(n12.right).to be_nil
          expect(n12.parent).to eq n11
          expect(tree.delete_by_key(12)).to eq n12
          expected = [8, 10, 11, 19, 20, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.delete_by_key(19)).to eq n19
          expect(tree.root).to eq n20
          expected = [8, 10, 11, 20, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.delete_by_key(8)).to eq n8
          expect(tree.root.left).to eq n11
          expected = [10, 11, 20, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.delete_by_key(11)).to eq n11
          expected = [10, 20, 22, 23]
          expect(tree.list_keys).to eq expected
          # expect(tree.inorder_iterate).to eq expected

          expect(tree.delete_by_key(10)).to eq n10
          expect(tree.list_keys).to eq [20, 22, 23]
          # expect(tree.inorder_iterate).to eq [20, 22, 23]
          expect(tree.delete_by_key(20)).to eq n20

          expect(tree.delete_by_key(23)).to eq n23
          expect(tree.list_keys).to eq [22]
          # expect(tree.inorder_iterate).to eq [22]
        end
      end
    end
  end

  describe '.delete' do
    it 'returns the root node when specified for deletion' do
      root = Node.new(9)
      tree = described_class.new root
      expect(tree.delete(9)).to eq root
      expect(tree.root.nil?).to be true
      expect(tree.size).to eq 0
    end

    it 'deletes the right node specified by key' do
      root = Node.new(9)
      tree = described_class.new root
      n14 = Node.new(14)
      tree.insert n14
      expect(tree.delete(14)).to eq n14
      expect(tree.bst?).to be true
      expect(n14.left.nil?).to be true
      expect(n14.right.nil?).to be true
      expect(tree.size).to eq 1
    end

    it 'deletes a right node reassiging that nodes child' do
      root = Node.new(9)
      tree = described_class.new root
      n14 = Node.new(14)
      n23 = Node.new(23)
      tree.insert n14
      tree.insert n23

      expect(tree.delete(14)).to eq n14
      expect(n14.left.nil?).to be true
      expect(n14.right.nil?).to be true
      expect(tree.bst?).to be true
      expect(tree.root.right).to eq n23
      expect(tree.size).to eq 2
    end

    it 'reassigns right subtree on deletion' do
      root = Node.new(11)
      tree = described_class.new root
      n17 = Node.new(17)
      n19 = Node.new(19)
      n13 = Node.new(13)
      n5 = Node.new(5)
      tree.insert n17
      tree.insert n19
      tree.insert n13
      tree.insert n5

      expect(tree.delete(17)).to eq n17
      expect(tree.bst?).to be true
      expect(n17.left.nil?).to be true
      expect(n17.right.nil?).to be true
      expect(tree.root.right).to eq n19
      expect(tree.root.right.left).to eq n13
      expect(tree.size).to eq 4
    end

    it 'rebuilds subtree after deleting node' do
      root = Node.new(11)
      tree = described_class.new root
      n5 = Node.new(5)
      tree.insert n5

      n17 = Node.new(17)
      n13 = Node.new(13)
      n41 = Node.new(41)
      n37 = Node.new(37)
      n31 = Node.new(31)
      tree.insert n17
      tree.insert n13
      tree.insert n41
      tree.insert n37
      tree.insert n31
      expect(tree.delete(17)).to eq n17
      expect(tree.bst?).to be true
      expect(n17.left.nil?).to be true
      expect(n17.right.nil?).to be true
      expect(tree.root.right).to eq n41
      expect(n31.left).to eq n13
      expect(tree.size).to eq 6
      # delete a leaf node
      expect(tree.delete(13)).to eq n13
      expect(n31.left).to be_nil
      expect(tree.size).to eq 5
    end

    it 'promotes left node on deletion' do
      root = Node.new(11)
      tree = described_class.new root
      n5 = Node.new(5)
      n7 = Node.new(7)
      n3 = Node.new(3)
      tree.insert n5
      tree.insert n7
      tree.insert n3

      expect(tree.delete(5)).to eq n5
      expect(tree.bst?).to be true
      expect(n5.left.nil?).to be true
      expect(n5.right.nil?).to be true
      expect(tree.root.left).to eq n3
      expect(n3.right).to eq n7
      expect(tree.size).to eq 3
    end

    it 'deletes the root node correctly' do
      root = Node.new(11)
      tree = described_class.new root
      n5 = Node.new(5)
      n7 = Node.new(7)
      n3 = Node.new(3)
      tree.insert n5
      tree.insert n7
      tree.insert n3

      n17 = Node.new(17)
      n13 = Node.new(13)
      n41 = Node.new(41)
      n37 = Node.new(37)
      n31 = Node.new(31)
      tree.insert n17
      tree.insert n13
      tree.insert n41
      tree.insert n37
      tree.insert n31

      expect(tree.delete(11)).to eq root
      expect(tree.root).to eq n5
      expect(root.left.nil?).to be true
      expect(root.right.nil?).to be true

      expect(n5.bst?).to be true
      expect(n5.left).to eq n3
      expect(n5.right).to eq n7
      expect(n7.right).to eq n17
      expect(tree.size).to eq 8
    end
  end
end

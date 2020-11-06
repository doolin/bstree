# frozen_string_literal: true

RSpec.describe AvlTree do
  let(:root) { AvlNode.new 17 }
  let(:n11) { AvlNode.new 11 }
  let(:n19) { AvlNode.new 19 }
  let(:n23) { AvlNode.new 23 }
  let(:n7) { AvlNode.new 7 }
  let(:n2) { AvlNode.new 2 }

  describe 'balance_left' do
    it 'sets root balance to -1 when single left child' do
      tree = described_class.new root
      root.left = n7
      n7.parent = root
      tree.balance_left(n7)
      expect(root.balance_factor).to eq(-1)
    end

    it 'rotates with left chain' do
      tree = described_class.new root
      root.left = n7
      root.left.left = n2
      root.balance_factor = -1
      n2.parent = n7
      n2.parent.parent = root
      tree.balance_left(n7)
      expect(n7.right).to eq root
      expect(root.parent).to eq n7
      expect(n7.left).to eq n2
      expect(tree.root).to eq n7
    end

    it 'rotates with left knee' do
      tree = described_class.new root
      root.left = n7
      root.left.right = n11
      root.balance_factor = -1
      n11.parent = n7
      n11.parent.parent = root
      tree.balance_left(n7)
    end
  end

  describe '#balance_right' do
    let(:root) { AvlNode.new 17 }
    let(:n19) { AvlNode.new 19 }
    let(:n23) { AvlNode.new 23 }

    it 'sets root balance to 1 when single right child' do
      tree = described_class.new root
      root.right = n19
      n19.parent = root
      tree.balance_right(n19)
      expect(root.balance_factor).to eq 1
    end

    it 'rotates with two right children' do
      tree = described_class.new root
      root.right = n19
      root.right.right = n23
      root.balance_factor = 1
      n23.parent = n19
      n23.parent.parent = root
      tree.balance_right(n19)
      expect(tree.root).to eq n19
    end
  end

  describe '#retrace' do
    let(:root) { AvlNode.new 17 }

    context 'left' do
      it 'finds left child' do
        tree = AvlTree.new root
        expect(tree.root.balance_factor).to eq 0
        tree.root.left = n7
        n7.parent = tree.root
        tree.retrace(n7)
        expect(tree.root.balance_factor).to eq(-1)
      end

      xit 'finds left left child' do
        tree = AvlTree.new root
        expect(tree.root.balance_factor).to eq 0
        tree.root.left = n7
        n7.parent = tree.root
        tree.retrace(n7)
        expect(tree.root.balance_factor).to eq(-1)
        n7.left = n2
        n2.parent = n7
        tree.retrace(n2)

        expect(tree.root).to eq n7
        expect(root.parent).to eq n7
        expect(n7.right).to eq root
        expect(tree.root.left).to eq n2
        expect(n2.parent).to eq tree.root

        expect(tree.root.balance_factor).to eq(0)
        expect(n7.balance_factor).to eq 0
        expect(root.balance_factor).to eq 0
      end

      xit 'rotates on left right child' do
        tree = AvlTree.new root
        tree.root.left = n2
        n2.parent = tree.root
        tree.retrace(n2)
        expect(tree.root.balance_factor).to eq(-1)
        n2.right = n7
        n7.parent = n2
        tree.retrace(n7)

        expect(tree.root).to eq n7
        expect(tree.root.right).to eq root
        expect(root.parent).to eq n7
        expect(tree.root.left).to eq n2
        expect(n2.parent).to eq tree.root

        expect(tree.root.balance_factor).to eq 0
        expect(root.balance_factor).to eq 0
        expect(n2.balance_factor).to eq 0
      end
    end

    context 'right' do
      it 'finds right child' do
        tree = AvlTree.new root
        expect(tree.root.balance_factor).to eq 0
        tree.root.right = n19
        n19.parent = tree.root
        tree.retrace(n19)
        expect(n19.balance_factor).to eq 0
        expect(tree.root.balance_factor).to eq 1
      end

      it 'find right right child' do
        tree = AvlTree.new root
        tree.root.right = n19
        n19.parent = tree.root
        tree.retrace(n19)
        expect(tree.root.balance_factor).to eq(1)

        n19.right = n23
        n23.parent = n19
        tree.retrace(n23)

        expect(tree.root).to eq n19
        expect(tree.root.left).to eq root
        expect(root.parent).to eq n19
        expect(tree.root.right).to eq n23
        expect(n23.parent).to eq n19

        expect(tree.root.balance_factor).to eq 0
        expect(n23.balance_factor).to eq 0
        expect(root.balance_factor).to eq 0
      end

      it 'rotates on right left child' do
        tree = AvlTree.new root
        tree.root.right = n23
        n23.parent = tree.root
        tree.retrace(n23)
        expect(tree.root.balance_factor).to eq 1

        n23.left = n19
        n19.parent = n23
        tree.retrace(n19)

        expect(tree.root.key).to eq 19
        expect(tree.root.right).to eq n23
        expect(n23.parent).to eq tree.root
        expect(tree.root.left).to eq root
        expect(root.parent).to eq tree.root

        expect(tree.root.balance_factor).to eq 0
        expect(root.balance_factor).to eq 0
        expect(n23.balance_factor).to eq 0
      end
    end
  end

  # Yes, these tests are fragile, they're supposed to break if the logic
  # in the called methods is tampered with. When the called methods need
  # to change, it's perfectly fine to simply delete these tests.
  xcontext 'helper method testing to guard against regression' do
    describe '#balance' do
      it 'balances right' do
        tree = AvlTree.new root
        expect(tree).to receive(:balance_right)
        tree.insert n19
      end

      it 'balances left' do
        tree = AvlTree.new root
        expect(tree).to receive(:balance_left)
        tree.insert n7
      end
    end

    describe '#balance_right' do
      it 'rotates left' do
        tree = AvlTree.new root
        tree.insert n19
        expect(tree.root.balance_factor).to eq 1
        expect(tree).to receive(:rotate_left)
        tree.insert n23
      end
    end

    describe '#balance_left' do
      it 'rotates right' do
        tree = AvlTree.new root
        tree.insert n7
        expect(tree.root.balance_factor).to eq(-1)
        expect(tree).to receive(:rotate_right)
        tree.insert n2
      end
    end
  end
end

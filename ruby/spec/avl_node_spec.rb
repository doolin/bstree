# frozen_string_literal: true

require_relative '../lib/avl_node'

describe AvlNode do
  describe '.insert' do
    let(:root) { AvlNode.new 11 }
    let(:n3) { AvlNode.new 3 }
    let(:n5) { AvlNode.new(5) }
    let(:n7) { AvlNode.new 7 }
    let(:n11) { AvlNode.new 11 }
    let(:n13) { AvlNode.new 13 }
    let(:n17) { AvlNode.new 17 }
    let(:n19) { AvlNode.new 19 }

    it 'returns current root on insertion'

    it 'inserts a node and balances' do
      n11.insert n5
      expect(n5.balanced?).to be true
      expect(n5.weight).to be 0
    end
  end

  describe 'rotations' do
    it 'rotates counterclockwise with 3 nodes right' do
      root = AvlNode.new 17
      n23 = AvlNode.new 23
      n29 = AvlNode.new 29
      root.insert n23
      root.insert n29

      root.rotate_ccw
      expect(n23.left).to eq root
      expect(n23.right).to eq n29
      expect(n23.size).to eq 3
    end

    it 'rotates clockwise with 3 nodes left' do
      root = AvlNode.new 11
      n5 = AvlNode.new 5
      n3 = AvlNode.new 3
      root.insert n5
      root.insert n3
      root.rotate_cw
      expect(n5.right).to eq root
      expect(n5.left).to eq n3
      expect(n5.size).to eq 3
    end

    it 'rotates clockwise' do
      root = AvlNode.new 17
      n23 = AvlNode.new 23
      root.insert n23

      n11 = AvlNode.new 11
      n13 = AvlNode.new 13
      n7 = AvlNode.new 7
      root.insert n11
      root.insert n13
      root.insert n7

      root.rotate_cw
      expect(n11.right).to eq root
      expect(root.left).to eq n13
      expect(n11.size).to eq 5
    end

    it 'rotates counterclockwise' do
      root = AvlNode.new 11
      n7 = AvlNode.new 7
      root.insert n7
      n17 = AvlNode.new 17
      n13 = AvlNode.new 13
      n23 = AvlNode.new 23
      root.insert n17
      root.insert n13
      root.insert n23

      root.rotate_ccw
      expect(n17.left).to eq root
      expect(root.right).to eq n13
      expect(n17.size).to eq 5
    end
  end

  describe 'build avl trees from sorted lists' do
    describe 'trees as linked lists' do
      let(:n2) { AvlNode.new 2 }
      let(:n3) { AvlNode.new 3 }
      let(:n5) { AvlNode.new 5 }
      let(:n7) { AvlNode.new 7 }
      let(:n11) { AvlNode.new 11 }
      let(:n13) { AvlNode.new 13 }
      let(:n17) { AvlNode.new 17 }
      let(:n19) { AvlNode.new 19 }
      let(:n23) { AvlNode.new 23 }
      let(:n29) { AvlNode.new 29 }

      # Check to ensure the rotations are getting called
      # correctly.
      #
      # Consider having insert return the current root.
      #
      # expect(n2).to receive(:rotate_ccw).with("correct argument")
      describe 'only right children' do
        xit 'makes a long right list' do
          n2.insert n3
          n2.insert n5
          expect(n2).to receive(:rotate_cw) # .with("correct argument")
          # expect(n2.height).to eq 1
          # expect(n3.height).to eq 0
          # expect(n3.height).to eq 0
          # expect(n2.pathological?).to be false

          # n2.insert n11
          # n2.insert n13
          # n2.insert n17
          # n2.insert n19
          # n2.insert n23
          # n2.insert n29
          # expect(n2.height).to eq 9
          # expect(n29.height).to eq 0
          # expect(n2.pathological?).to be true
          # expect(n29.pathological?).to be false
          # expect(n23.pathological?).to be false
          # expect(n19.pathological?).to be true
          # expect(n2.degenerate?).to be true
        end
      end

      describe 'only left children' do
        xit 'makes a long left list' do
          n29.insert n23
          n29.insert n19
          n29.insert n17
          n29.insert n13
          n29.insert n11
          n29.insert n7
          n29.insert n5
          n29.insert n3
          n29.insert n2
          expect(n29.height).to eq 9
          expect(n2.height).to eq 0
          # expect(n29.pathological?).to be true
          # expect(n5.pathological?).to be true
          # expect(n3.pathological?).to be false
          # expect(n29.degenerate?).to be true
        end
      end

      describe 'left and right children, alternately aperiodically' do
        it 'make rubocop happy with example'
      end
    end
  end
end

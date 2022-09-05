# frozen_string_literal: true

# TODO: move to spec_helper
RSpec.configure do |c|
  c.alias_it_should_behave_like_to :it_finds, ''
end

RSpec.shared_examples '#predecessor' do
  let(:node) { described_class }
  let(:root) { described_class.new 17 }
  let(:n7) { node.new 7 }
  let(:n29) { node.new 29 }

  context 'for single node' do
    it 'is nil' do
      expect(root.predecessor(root)).to be_nil
    end
  end

  context 'for 2 node trees' do
    it 'finds nil as predecessor to left child' do
      root.insert n7
      expect(root.predecessor(n7)).to be_nil
    end

    it 'finds root as predecessor to right child' do
      root.insert n29
      expect(root.predecessor(n29)).to be root
    end

    it 'finds left child as predecessor to root' do
      root.insert n7
      expect(root.predecessor(root)).to eq n7
    end
  end

  context 'for 3 node' do
    describe 'perfect trees' do
      before do
        root.insert n7
        root.insert n29
      end

      it 'finds nil as predecessor to left child' do
        expect(root.predecessor(n7)).to be_nil
      end

      it 'finds root as predecessor to right child' do
        expect(root.predecessor(n29)).to be root
      end

      context 'when root has 2 childen' do
        subject { root.predecessor(root) }

        it 'finds left child as predecessor to root' do
          expect(subject).to eq n7
        end

        it 'finds predecessor has no right child' do
          expect(subject.right).to be_nil
        end
      end
    end

    # This is probably not necessary, but I'm pushing the limits
    # of how to use describe, context and example/it to best
    # express the meaning of each spec.
    context 'when left trees' do
      let(:n7) { node.new(7) }
      let(:n2) { node.new(2) }

      before do
        root.insert n7
        root.insert n2
      end

      it 'finds minimum as predecessor of root.left' do
        expect(root.predecessor(n7)).to be n2
      end
    end

    context 'when right trees' do
      let(:n29) { node.new(29) }
      let(:n43) { node.new(43) }

      before do
        root.insert n29
        root.insert n43
      end

      it 'finds maximum as predecessor of root.left' do
        expect(root.predecessor(n43)).to be n29
      end
    end
  end

  context 'remaining junk tests' do # rubocop:disable RSpec/ContextWording
    it 'finds predecessors correctly' do
      n2 = node.new 2
      n3 = node.new 3
      n5 = node.new 5
      n7 = node.new 7
      n11 = node.new 11
      n13 = node.new 13
      root.insert n5
      root.insert n3
      root.insert n2
      expect(root.predecessor(n5)).to eq n3
      expect(root.predecessor(n3)).to eq n2

      root.insert n7
      root.insert n11
      root.insert n13
      expect(root.predecessor(root)).to eq n13
      expect(root.predecessor(n13)).to eq n11
      expect(root.predecessor(n11)).to eq n7
      expect(root.predecessor(n7)).to eq n5

      n19 = node.new 19
      n23 = node.new 23
      n29 = node.new 29
      root.insert n23
      root.insert n29
      root.insert n19
      expect(root.predecessor(n19)).to eq root
      expect(root.predecessor(n23)).to eq n19
      expect(root.predecessor(n29)).to eq n23
      # TODO: this behavior no longer works. The iterative
      # implementation will traverse the parent pointers.
      # The recursive implementation sets the parent pointers
      # on each recursion. There is opportunity here to figure
      # out why there is a difference and why it matters. I
      # feel there is a use case for the pointer being treated
      # as an independent even with a parent pointer.
      # expect(n19.predecessor(n19)).to eq nil
    end
  end
end

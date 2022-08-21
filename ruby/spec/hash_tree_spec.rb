# frozen_string_literal: true

RSpec.describe HashTree do
  it 'instantiates' do
    expect(described_class.new).not_to be_nil
  end

  describe 'insert' do
    it 'hashes inserted documents automatically' do
      ht = described_class.new
      doc1 = ''
      doc2 = '1'
      ht.insert doc1
      ht.insert doc2
      ht.rehash
      h1 = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855'
      h2 = '6b86b273ff34fce19d6b804eff5a3f5747ada4eaa22f1d49c01e52ddb7875b4b'
      expect(ht.hashes[0]).to eq h1
      expect(ht.hashes[1]).to eq h2
    end
  end
end

require 'spec_helper'

describe Monologue::Tag do
  let(:tag) { Factory(:tag) }

  it "is valid with valid attributes" do
    tag.should be_valid
  end

  describe "validations" do
    it "is not possible to have save another tag with the same name" do
       expect { Factory(:tag, name: tag.name) }.to raise_error(ActiveRecord::RecordInvalid)
    end

    it "should require the name to be set" do
      expect { Factory(:tag, name:nil) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'scopes' do
    describe '.for_published_posts' do
      let(:published_tag) { Factory(:tag_with_post) }

      it 'returns correct tags' do
        expect(Monologue::Tag.for_published_posts).to eq [published_tag]
      end
    end

    describe 'frequency scopes' do
      let!(:another_tag) { Factory(:tag_with_post) }

      before do
        5.times { tag.posts << Factory(:post) }
      end

      describe '.max_frequency' do
        it 'returns max frequency' do
          expect(Monologue::Tag.max_frequency).to eq 5
        end
      end

      describe '.min_frequency' do
        it 'returns min frequency' do
          expect(Monologue::Tag.min_frequency).to eq 1
        end
      end
    end
  end
end
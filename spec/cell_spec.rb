require 'spec_helper'

describe Kudosu::Cell do
  subject(:cell) { described_class.new(1) }

  shared_examples_for 'unsolved cell' do
    it { expect(cell.value).to be nil }
    it { expect(cell).not_to be_solved }
  end

  shared_examples_for 'solved cell' do |value|
    it { expect(cell.value).to be value }
    it { expect(cell).to be_solved }
  end

  describe 'solved?' do
    context 'cell with value' do
      it_behaves_like 'solved cell', 1
    end

    context 'cell with null value' do
      subject(:cell) { described_class.new(nil) }
      it_behaves_like 'unsolved cell'
    end
  end

  describe 'solve' do
    context 'solution is ambiguous' do
      subject(:cell) { described_class.new(nil) }

      before do
        cell.markup = [2, 3, 4]
        cell.solve
      end

      it_behaves_like 'unsolved cell'
    end

    context 'solution is unambiguous' do
      subject(:cell) { described_class.new(nil) }

      before do
        cell.markup = [2]
        cell.solve
      end

      it_behaves_like 'solved cell', 2
    end

    context 'solution is unambiguous but cell is already solved' do
      before do
        cell.markup = [2]
        cell.solve
      end

      it_behaves_like 'solved cell', 1
    end
  end

  describe 'reset markup' do
    it 'populates markup with all possible values' do
      expect { cell.reset_markup }.
        to change { cell.markup }.from(nil).to([1, 2, 3, 4, 5, 6, 7, 8, 9])
    end
  end

  describe 'remove from markup' do
    it 'removes values' do
      cell.markup = [1, 2, 3, 4]
      cell.remove_from_markup([2, 4])
      expect(cell.markup).to eq [1, 3]
    end
  end

  describe 'pick random markup value' do
    let(:markup) { [1, 2, 3, 4] }
    before { cell.markup = markup.clone }

    it 'picks value from markup' do
      chosen = cell.pick_random
      expect(markup).to include(chosen)
      expect(cell.value).to eq chosen
    end

    it 'removes value from markup' do
      chosen = markup.sample
      allow(cell.markup).to receive(:sample) { chosen }

      expect { cell.pick_random }
        .to change { cell.markup }.from(markup).to(markup - [chosen])
    end
  end

  describe 'reset' do
    before { cell.reset }
    it_behaves_like 'unsolved cell'
  end
end

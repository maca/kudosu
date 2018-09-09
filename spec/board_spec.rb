require 'spec_helper'

describe Kudosu::Board do
  subject(:board) { described_class.new(values)  }

  describe 'values' do
    let(:values) { (1..9 * 9).to_a }
    it { expect(board.values).to eq values }
  end

  describe 'rows' do
    let(:values) { (1..9 * 9).to_a }
    let(:rows) { board.rows }
    it { expect(rows[0].map(&:value)).to eq (1..9).to_a }
    it { expect(rows[8].map(&:value)).to eq (73..81).to_a }
  end

  describe 'columns' do
    let(:values) { (1..9 * 9).to_a }
    let(:columns) { board.columns }
    it { expect(columns[0].map(&:value)).to eq (1..81).step(9).to_a }
    it { expect(columns[8].map(&:value)).to eq (9..81).step(9).to_a }
  end

  describe 'boxes' do
    let(:values) { (1..9 * 9).to_a }
    let(:boxes) { board.boxes }
    it { expect(boxes[0].map(&:value)).to eq [1, 2, 3, 10, 11, 12, 19, 20, 21] }
    it { expect(boxes[8].map(&:value)).to eq [61, 62, 63, 70, 71, 72, 79, 80, 81] }
  end

  shared_examples_for 'solves sudoku' do
    before { board.solve }
    it { expect(board).to be_valid }
    it { expect(board).to be_solved }
  end

  describe 'solve' do
    context 'simple' do
      let(:values) do
        [
          [nil, nil,  nil, 8,  nil,  nil, 4, 5, 6],
          [5,  nil, 4, 6, 3,  nil, 7,  nil, 1],
          [1, 2,  nil,  nil,  nil,  nil,  nil, 8, 9],
          [6,  nil, 2, 7, 5,  nil, 9,  nil, 8],
          [nil,  nil,  nil, 3, 2,  nil,  nil, 7,  nil],
          [7,  nil,  nil,  nil, 4,  nil, 6,  nil,  nil],
          [2, 4, 1, 5,  nil, 3,  nil,  nil, 7],
          [8, 5, 7,  nil, 9,  nil,  nil, 6, 3],
          [9, 6,  nil, 2, 8, 7,  nil,  nil, 4]
        ]
      end

      it_behaves_like 'solves sudoku'
    end

    context 'sparse' do
      let(:values) do
        [
          [nil, nil,  nil, nil,  nil,  nil, 4, 5, 6],
          [5,  nil, 4, 6, 3,  nil, 7,  nil, 1],
          [1, 2,  nil,  nil,  nil,  nil,  nil, 8, 9],
          [6,  nil, 2, 7, 5,  nil, 9,  nil, 8],
          [nil,  nil,  nil, nil, 2,  nil,  nil, 7,  nil],
          [7,  nil,  nil,  nil, 4,  nil, 6,  nil,  nil],
          [2, nil, 1, nil,  nil, nil,  nil,  nil, 7],
          [nil, nil, nil,  nil, 9,  nil,  nil, 6, 3],
          [nil, nil,  nil, nil, nil, nil,  nil,  nil, 4]
        ]
      end

      it_behaves_like 'solves sudoku'
    end

    context 'empty' do
      let(:values) { [[nil] * 9] * 9 }
      it_behaves_like 'solves sudoku'
    end
  end
end

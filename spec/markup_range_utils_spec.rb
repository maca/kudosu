require 'spec_helper'

describe Kudosu::MarkupRangeUtils do
  let(:null_cell) { instance_double("Cell", value: nil) }
  let(:cell_one) { instance_double("Cell", value: 1) }
  let(:cell_two) { instance_double("Cell", value: 2) }
  let(:cell_three) { instance_double("Cell", value: 3) }
  let(:cell_four) { instance_double("Cell", value: 4) }
  let(:valid_range) { [cell_one, cell_two, null_cell] }
  let(:invalid_range) { [cell_three, cell_four, cell_four, null_cell] }

  describe 'range values' do
    it 'maps values for range without null values' do
      values = described_class.range_values(valid_range)
      expect(values).to eq [1, 2]
    end
  end

  describe 'update ranges markup' do
    it 'updates markup for every cell in range' do
      valid_range.each { |cell| expect(cell)
        .to receive(:remove_from_markup).with([1, 2]) }

      invalid_range.each { |cell| expect(cell)
        .to receive(:remove_from_markup).with([3, 4, 4]) }

      described_class.update_ranges_markup([valid_range, invalid_range])
    end
  end

  describe 'ranges valid?' do
    it 'is valid for range with uniq values' do
      validity = described_class.ranges_valid?([valid_range])
      expect(validity).to be true
    end

    it 'is not valid for range with repeated values' do
      validity = described_class.ranges_valid?([invalid_range])
      expect(validity).to be false
    end

    it 'is not valid when a range is invalid' do
      validity = described_class.ranges_valid?([valid_range, invalid_range])
      expect(validity).to be false
    end
  end
end

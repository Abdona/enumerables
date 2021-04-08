require './enumerables'

describe Enumerable do
  let(:int_array) { [1, 2, 3, 4] }
  let(:str_array) { %w[bear schwarze kalt] }
  let(:mix_array) { [nil, true, 99] }
  let(:empty_array) { [] }
  describe '#my_any?' do
    it 'check my_any for int array' do
      expect(int_array.my_any?).to eql(true)
      expect(int_array.my_any?(1)).to eql(true)
      expect(int_array.my_any? { |x| x > 1 }).to eql(true)
      expect(int_array.my_any?(/d/)).to eql(false)
      expect(int_array.my_any?(10)).to eql(false)
      expect(int_array.my_any? { |x| x > 4 }).to eql(false)
    end
    it 'check my_any for string array' do
      expect(str_array.my_any?).to eql(true)
      expect(str_array.my_any?('schwarze')).to eql(true)
      expect(str_array.my_any? { |x| x.length > 1 }).to eql(true)
      expect(str_array.my_any?('cold')).to eql(false)
      expect(str_array.my_any? { |x| x.length > 8 }).to eql(false)
    end
    it 'check my_any for mix array' do
      expect(mix_array.my_any?).to eql(true)
      expect(mix_array.my_any?(Integer)).to eql(true)
      expect(mix_array.my_any?('Integer')).to eql(false)
    end
    it 'check empty array' do
      expect(empty_array.my_any?).to eql(false)
    end
  end
  # ####my_all###########
  #   describe '#my_all?' do
  #     it 'check my_all for int array' do
  #       expect(int_array.my_all?).to eql(true)
  #       expect(int_array.my_all?(1)).to eql(false)
  #       expect(int_array.my_all? { |x| x >= 1 }).to eql(true)
  #       expect(int_array.my_all?(/d/)).to eql(false)
  #       expect(int_array.my_all?(10)).to eql(false)
  #       expect(int_array.my_all? { |x| x > 4 }).to eql(false)
  #     end
  #     it 'check my_all for string array' do
  #       expect(str_array.my_all?).to eql(true)
  #       expect(str_array.my_all?('schwarze')).to eql(false)
  #       expect(str_array.my_all? { |x| x.length > 1 }).to eql(true)
  #       expect(str_array.my_all?('cold')).to eql(false)
  #       expect(str_array.my_all? { |x| x.length > 6 }).to eql(false)
  #       expect(str_array.my_all? { |x| x.length > 2 }).to eql(true)
  #     end
  #     it 'check my_all for mix array' do
  #       expect(mix_array.my_all?).to eql(false)
  #       expect(mix_array.my_all?(Integer)).to eql(false)
  #       expect(mix_array.my_all?('Integer')).to eql(false)
  #     end
  #     it 'check empty array' do
  #       expect(empty_array.my_all?).to eql(true)
  #     end
  #   end
end

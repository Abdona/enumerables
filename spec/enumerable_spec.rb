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
  describe '#my_all?' do
    it 'check my_all for int array' do
      expect(int_array.my_all?).to eql(true)
      expect(int_array.my_all?(1)).to eql(false)
      expect(int_array.my_all? { |x| x >= 1 }).to eql(true)
      expect(int_array.my_all?(/d/)).to eql(false)
      expect(int_array.my_all?(10)).to eql(false)
      expect(int_array.my_all? { |x| x > 4 }).to eql(false)
    end
    it 'check my_all for string array' do
      expect(str_array.my_all?).to eql(true)
      expect(str_array.my_all?('schwarze')).to eql(false)
      expect(str_array.my_all? { |x| x.length > 1 }).to eql(true)
      expect(str_array.my_all?('cold')).to eql(false)
      expect(str_array.my_all? { |x| x.length > 6 }).to eql(false)
      expect(str_array.my_all? { |x| x.length > 2 }).to eql(true)
    end
    it 'check my_all for mix array' do
      expect(mix_array.my_all?).to eql(false)
      expect(mix_array.my_all?(Integer)).to eql(false)
      expect(mix_array.my_all?('Integer')).to eql(false)
    end
    it 'check empty array' do
      expect(empty_array.my_all?).to eql(true)
    end
  end
  # ######my_each#####
  describe '#my_each' do
    it 'check my_each' do
      expect(int_array.my_each { |x| x * 4 }).to eql([4, 8, 12, 16])
      expect(str_array.my_each do |x|
               "#{x}_extra_string"
             end).to eql(%w[bear_extra_string schwarze_extra_string kalt_extra_string])
    end
  end
  describe '#my_each_with_index' do
    it 'check my_each_with_index' do
      expect(int_array.my_each_with_index { |item, index| item if index.even? }).to eql([1, nil, 3, nil])
      expect(str_array.my_each_with_index do |item, _index|
               "#{item}_extra_string"
             end).to eql(%w[bear_extra_string schwarze_extra_string kalt_extra_string])
    end
  end
  # ##my_none#####
  describe '#my_none?' do
    it 'check my_none for int array' do
      expect(int_array.my_none?).to eql(false)
      expect(int_array.my_none?(1)).to eql(false)
      expect(int_array.my_none? { |x| x > 1 }).to eql(false)
      expect(int_array.my_none?(/d/)).to eql(true)
      expect(int_array.my_none?(10)).to eql(true)
      expect(int_array.my_none? { |x| x > 4 }).to eql(true)
    end
    it 'check my_none for string array' do
      expect(str_array.my_none?).to eql(false)
      expect(str_array.my_none?('schwarze')).to eql(false)
      expect(str_array.my_none? { |x| x.length > 1 }).to eql(false)
      expect(str_array.my_none?('cold')).to eql(true)
      expect(str_array.my_none? { |x| x.length > 8 }).to eql(true)
    end
    it 'check my_none for mix array' do
      expect(mix_array.my_none?).to eql(false)
      expect(mix_array.my_none?(Integer)).to eql(false)
      expect(mix_array.my_none?('Integer')).to eql(true)
    end
    it 'check empty array' do
      expect(empty_array.my_none?).to eql(true)
    end
  end
  ###my_select####
  describe '#my_select' do
    it 'check my_select' do
        expect(int_array.my_select{|item| item%2==0}).to eql([2,4])
        expect(str_array.my_select{|item| item.length>1}).to eql(['bear','schwarze','kalt'])
        expect(mix_array.my_select{|item| item!=nil}).to eql([true,99])
    end
  end
    ###my_count####
    describe '#my_count' do
    it 'check my_coubt' do
        expect(int_array.my_count).to eql(4)
        expect(int_array.my_count{|item| item>1}).to eql(3)
        expect(str_array.my_count{|item| item=='schwarze'}).to eql(1)
    end
  end
end

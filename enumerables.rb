module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    arr = to_a
    size.times { |pos| yield arr[pos] }
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    index = 0
    to_a.my_each do |item|
      (yield item, index)
      index += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = []
    to_a.my_each { |each| array.push(each) if yield each }
    array
  end

  def my_all?(arg = nil)
    if block_given?
      false_counter = 0
      my_each { |item| false_counter += 1 unless yield item }
      false_counter.zero?
    elsif arg.nil?
      my_all? { |item| item }
    else
      my_all? { |item| arg == item }
    end
  end

  def my_any?(arg = nil)
    if block_given?
      true_counter = 0
      my_each { |item| true_counter += 1 if yield item }
      true_counter.positive?
    elsif arg.nil?
      my_any? { |item| item }
    else
      my_any? { |item| arg == item }
    end
  end

  def my_none?(arg = nil)
    if block_given?
      true_counter = 0
      my_each { |item| true_counter += 1 if yield item }
      true_counter.zero?
    elsif arg.nil?
      my_none? { |item| item }
    else
      my_none? { |item| arg == item }
    end
  end

  def none_nil?(pam = nil, item = nil)
    return true if !pam.nil? && pam == item
  end

  def my_count(pam = nil, &block)
    if block_given?
      counter = to_a.my_select(&block)
    elsif pam.nil?
      return to_a.length
    else
      counter = to_a.my_select { |each| each == pam }
    end
    counter.length
  end

  def my_map(proc = nil)
    return to_enum unless block_given? || !proc.nil?

    new_array = []
    if proc.nil?
      to_a.my_each { |item| new_array.push(yield item) }
    else
      to_a.my_each { |item| new_array.push(proc.call(item)) }
    end
    new_array
  end

  def my_inject(first_param = nil, second_param = nil)
    result = nil
    if block_given?
      unless first_param.nil?
        to_a.my_each { |each| first_param = yield(first_param, each) }
        return first_param
      end
      to_a.my_each { |each| result = result.nil? ? each : yield(result, each) }
    elsif symbol?(first_param)
      to_a.my_each { |each| result = result.nil? ? each : result.send(first_param, each) }
    elsif symbol?(second_param)
      to_a.my_each { |each| first_param = first_param.send(second_param, each) }
      return first_param
    else
      raise LocalJumpError, 'no block or arguments given'
    end
    result
  end

  def symbol?(param1 = nil)
    !param1.nil? && (param1.is_a? Symbol)
  end
end

def multiply_els(array)
  array.my_inject(:*)
end

words = %w[dogs door rod blade]
puts words.my_none?(/d/)
puts words.none?(/d/)

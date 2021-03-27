module Enumerable
  def my_each
    return to_a.to_enum unless block_given? # return enum obj if no block given

    index = 0
    self_arr = to_a
    while index < self_arr.length
      yield(self_arr[index])
      index += 1
    end
    to_a # this is supposed to return range
  end

  # ['a', 'b'].my_each{ |item| p item}
  # p ['a', 'b'].my_each
  # p (1..5).each.my_each{ |item| p item}
  # Hash is illegal for each?????
  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given? # return enum obj if no block given

    index = 0
    my_each do |item| #  Use own 'my_each' method from above
      yield(item, index)
      index += 1
    end
    self
  end

  # ['a', 'b'].my_each_with_index{ |item, index| p index}
  # p ['a', 'b'].my_each_with_index
  # Hash is illegal for each?????
  def my_select
    return to_enum(:my_select) unless block_given? # return enum obj if no block given

    arr = []
    my_each do |item| #  Use own 'my_each' method from above
      arr.push(item) if yield(item)
    end
    arr
  end
  # p ['a', 'b', 'ac', 'a'].my_select{ |item| item == 'a'}
  p('a'..'c').my_select { |item| item == 'a' }
  def my_all?(param = nil, &block)
    self_arr = to_a # convert self to array so method could work with ranges too
    return true if self_arr.zero? # return true if empty array given

    if param # If there is parameter given
      case param
      when Regexp # check if Regex class passed as 'parameter'
        return self_arr.my_select do |el|
                 el =~ param
               end.length == self_arr.to_a.length # use =~ to match each element against Regex
      when Class # check if each item is 'parameter' type
        return self_arr.my_select do |el|
                 el.is_a?(param)
               end.length == self_arr.to_a.length # use is_a? to check if the element is of given class
      else
        self_arr.my_each { |el| return false if el != param }
        return true
      end
    end
    if block_given? # else use yield to check if expression is true
      return self_arr.my_select(&block).length == self_arr.to_a.length
    end

    if !param && !block_given? # if no param nor block given check if elements are of same class
      self_arr.my_each do |el|
        return false if [nil, false].include?(el)
      end
      true
    end
  end

  # p [1, 2].my_all? Numeric
  # p ['t', 't'].my_all?(/t/)
  # p [1, 2].my_all?{ |i| i > 0 }
  # p [1, 2, 3].my_all?
  # p [].my_all?
  # p (1..3).my_all?{ |i| i > 0 }
  # p [nil, true, 99].my_all?
  # p [true, true, true].my_all?(true)
  def my_any?(param = nil)
    self_arr = to_a # convert self to array so method could work with ranges too
    return false if self_arr.length.zero? # return false if empty array given

    if param # If there is parameter given
      case param
      when Regexp # check if Regex class passed as 'parameter'
        self_arr.my_each do |el|
          if (el =~ param).nil? # if at least one regex is matched
            return true # return true
          end
        end
        return false # if my_each ends without finding regex return false
      when Class
        self_arr.my_each do |el|
          if el.is_a?(param) # if at least one element class is matched with Class given via param
            return true # return true
          end
        end
        return false # if my_each ends without finding given class in any el return false
      end
    end
    if block_given? # else use yield to check if expression is true for at least one element
      self_arr.my_each do |el|
        return true if yield(el)
      end
      return false
    end
    if !param && !block_given? # if no param nor block given check if at least on element is not nil nor false
      self_arr.my_each { |el| return true if el } # if non of elements is true than its false
      false
    end
  end

  # p ['t', '4'].my_any?(/t/)
  # p [1, 2].my_any? Numeric
  # p [1, 2].my_any?{ |i| i > 2 }
  # p [nil, nil, false].any?
  # p [].my_any?
  # p (1..3).my_any?{ |i| i > 3 }
  def my_none?(param = nil)
    return true if length.zero? # return true if empty array given

    if param # If there is parameter given
      case param
      when Regexp # check if Regex class passed as 'parameter'
        return my_select do |el|
                 el !~ param
               end.length == to_a.length # use =~ to match each element against Regex use ! to invert the meaning so you chose el that are false
      when Class # check if each item is 'parameter' type
        return my_select do |el|
                 !el.is_a?(param)
               end.length == to_a.length # use is_a? to check if none of the element is of given class
      end
    end
    if block_given? # else use yield to check if expression is true and invert it to false
      return my_select { |el| !yield(el) }.length == to_a.length
    end

    if !param && !block_given? # if no param nor block given check if all elements are not true
      my_select(&:!).length == to_a.length
    end
  end

  # p ['a', 'fd'].my_none?(/d/)
  # p [1, 2.0].my_none? Float
  # p [1, 2].my_none?{ |i| i > 2 }
  # p [nil, false].my_none?
  # p [].my_none?
  def my_count(param = nil, &block)
    arr = []
    if param # If there is parameter given add element that matches the parameter to array
      my_each do |el|
        arr << el if el == param
      end
      return arr.length # return the length of array
    end
    my_select(&block).length if block_given?
  end

  # p [1, 2, 4, 2].my_count               #=> 4
  # p [1, 2, 4, 2, 2, 2, 4].my_count(2)            #=> 2
  # p [1, 2, 4, 2].my_count{ |x| x%2==0 } #=> 3
  def my_map(proc = nil)
    arr = []
    if block_given?
      to_a.my_each { |el| arr.push(yield(el)) }
    elsif proc
      to_a.my_each { |el| arr << proc.call(el) }
    end
    arr
  end
  # p (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
  # p (1..4).my_map { "cat" }   #=> ["cat", "cat", "cat", "cat"]
  test_proc = proc { |x| x**2 }
  # p [2, 3, 4].my_map(test_proc)
  def my_inject(param1 = nil, param2 = nil)
    if param1 && !param2 && !block_given?
      if param1.is_a?(Symbol) || param1.is_a?(String)
        self_arr = to_a # convert range (1..3) to array [1, 2, 3]
        result = self_arr[0] # set result as first el of array
        case param1
        when :+, '+'
          self_arr[1..-1].my_each do |el|
            result += el
          end
        when :*, '*'
          self_arr[1..-1].my_each { |el| result *= el }
        when :-, '-'
          self_arr[1..-1].my_each { |el| result -= el }
        when :/, '/'
          self_arr[1..-1].my_each { |el| result /= el }
        when :**, '**'
          self_arr[1..-1].my_each { |el| result **= el }
        end
        return result
      end
    elsif param1 && param2 && !block_given?
      self_arr = to_a # convert range (1..3) to array [1, 2, 3]
      result = param1 # set result as first parameter given to the method
      case param2
      when :+, '+'
        self_arr.my_each do |el|
          result += el
        end
      when :*, '*'
        self_arr.my_each { |el| result *= el }
      when :-, '-'
        self_arr.my_each { |el| result -= el }
      when :/, '/'
        self_arr.my_each { |el| result /= el }
      when :**, '**'
        self_arr.my_each { |el| result **= el }
      end
      return result
    end
    if block_given? && param1
      self_arr = to_a # convert range (1..3) to array [1, 2, 3]
      self_arr.my_each do |el|
        result = result.nil? ? yield(param1, el) : yield(result, el) # if result is null than use param as first accomulated value, else use result
      end
      result
    elsif block_given? && !param1
      self_arr = to_a # convert range (1..3) to array [1, 2, 3]
      result = param1
      self_arr.my_each { |el| result = result.nil? ? el : yield(result, el) }
    end
    result
  end
  # p (5..10).my_inject("+")
  # p (5..10).my_inject(:*)
  # p (5..10).my_inject('-')
  # p [5, 6, 7, 8, 9, 10].my_inject(:/)
  # p (5..10).my_inject(:**)
  # p (5..10).my_inject(1, :+)
  # p [5, 6, 7, 8, 9, 10].my_inject(1, :-)
  # p (5..10).my_inject { |sum, n| sum + n }
  # p (5..10).my_inject(1) { |sum, n| sum + n }
  # p (1..5).my_inject { |value| value * 2 }
end
longest = %w[cat sheep bear caribou].inject do |memo, word|
  memo.length > word.length ? memo : word
end
# puts longest
def multiply_els(arr)
  arr.my_inject(:*)
end
# p multiply_els([2,4,5])

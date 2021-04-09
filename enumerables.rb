module Enumerable
  def my_any?(param = nil)
    if block_given?
      my_each do |item|
        return true if yield item
      end
    elsif param
      my_each do |item|
        return true if match(item, param)
      end
    else
      my_each do |item|
        return true if item
      end
    end
    false
  end

  def my_all?(param = nil)
    if block_given?
      my_each do |item|
        return false unless yield item
      end
    elsif param
      my_each do |item|
        return false unless match(item, param)
      end
    else
      my_each do |item|
        return false unless item
      end
    end
    true
  end

  def match(element, param)
    case param
    when Regexp
      element =~ param
    when Class
      element.is_a?(param)
    else
      element == param
    end
  end

  def my_each
    new_arr = []
    each do |item|
      new_arr.push(yield(item))
    end
    new_arr
  end

  def my_each_with_index
    new_arr = []
    (0...length).each do |i|
      new_arr.push(yield(self[i], i))
    end
    new_arr
  end

  def my_select
    result = []
    my_each do |x|
      result.push(x) if yield(x)
    end
    result
  end

  def my_map
    result = []
    my_each do |x|
      result.push(yield(x))
    end
    result
  end

  def my_count(parm = nil)
    return length unless block_given? || !parm.nil?

    count = 0
    unless parm.nil?
      my_each do |x|
        count += 1 if parm == x
      end
      return count
    end
    my_each do |x|
      count += 1 if yield(x)
    end
    count
  end

  def my_none?(param = nil)
    if block_given?
      my_each do |item|
        return false if yield item
      end
    elsif param
      my_each do |item|
        return false if match(item, param)
      end
    else
      my_each do |item|
        return false if item
      end
    end
    true
  end
end

module Enumerable
  def my_each
    if block_given?
      result = []
      length = self.length - 1
      (0..length).each do |i|
        result.push(yield(self[i]))
      end
      result
    end
    "#<Enumerator: #{self}:my_each>"
  end

  def my_each_with_index
    if block_given?
      result = []
      length = self.length - 1
      (0..length).each do |i|
        result.push(yield(i, self[i]))
      end
      result
    end
    "#<Enumerator: #{self}:my_each>"
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

  def my_any?
    my_each do |x|
      return true if yield(x)
    end
    false
  end

  def my_all?
    my_each do |x|
      return false unless yield(x)
    end
    true
  end

  def my_none?
    my_each do |x|
      return false if yield(x)
    end
    true
  end

  def my_inject?(_arr, total)
    my_each do |x|
      total = yield(total, x)
    end
    total
  end

  def my_count
    return length unless block_given?

    count = 0
    my_each do |m|
      count += 1 if yield == m
    end
    count
  end
end
